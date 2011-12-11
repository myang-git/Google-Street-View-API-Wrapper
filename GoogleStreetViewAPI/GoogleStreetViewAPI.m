//
//  GoogleStreetViewAPI.m
//  GoogleStreetViewAPI
//
//  Created by Ming Yang on 12/10/11.
//

#import "GoogleStreetViewAPI.h"

static NSString* const REQUEST_PARAMETERS_PATTERN = @"%@?size=%dx%d&location=%.6f,%.6f&heading=%d&fov=%d&pitch=%d&sensor=%@";

static BOOL isHTTPOk(int httpResponseCode) {
    return httpResponseCode>=200 && httpResponseCode<300;
}

@implementation GoogleStreetViewAPI

@synthesize delegate;
@synthesize baseUrl;
@synthesize imageWidth, imageHeight;
@synthesize usingSensor;

- (id)initWithImageWidth:(int)width imageHeight:(int)height usingSensor:(BOOL)_usingSensor {
    self = [self initWithBaseUrl:GOOGLE_STREET_VIEW_API_BASE_URL imageWidth:width imageHeight:height usingSensor:_usingSensor];
    return self;
}

- (id)initWithBaseUrl:(NSString*)url imageWidth:(int)width imageHeight:(int)height usingSensor:(BOOL)_usingSensor {
    if (self = [super init]) {
        self.baseUrl = url;
        imageWidth = width;
        imageHeight = height;
        usingSensor = _usingSensor;
        isQuerying = NO;
    }
    return self;
}

- (void)requestForStreetViewAtLatitude:(double)latitude 
                              longitude:(double)longitude
                              heading:(int)heading
                              fov:(int)fov
                              pitch:(int)pitch {
    
    @synchronized(self) {
        if (isQuerying) {
            [urlConn cancel];
        }
        NSString* fullRequestUrlString = 
            [NSString stringWithFormat:REQUEST_PARAMETERS_PATTERN, 
                                       self.baseUrl,
                                       self.imageWidth,
                                       self.imageHeight,
                                       latitude,
                                       longitude,
                                       heading,
                                       fov,
                                       pitch,
                                       (self.usingSensor ? @"true" : @"false")];
        NSURL* fullRequestUrl = [NSURL URLWithString:fullRequestUrlString];
        NSLog(@"url: %@", fullRequestUrlString);
        NSURLRequest* request = [NSURLRequest requestWithURL:fullRequestUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        
        responseData = [[NSMutableData alloc] init];
        urlConn = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
        [urlConn start];
        isQuerying = YES;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    httpResponseCode = httpResponse.statusCode;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (isHTTPOk(httpResponseCode)) {
        [responseData appendData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    @synchronized(self) {
        [responseData release];
        [connection cancel];
        [connection release];
        [self.delegate api:self failedReturnStreetViewImageWithError:error];
        isQuerying = NO;
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    @synchronized(self) {
        if (isHTTPOk(httpResponseCode)) {
            UIImage* streetViewImage = [[UIImage alloc] initWithData:responseData];
            [self.delegate api:self didReturnStreetViewImage:streetViewImage];
            [streetViewImage release];
            [responseData release];
            [connection cancel];
            [connection release];
        }
        else {
            NSError* error = [NSError errorWithDomain:NSURLErrorDomain code:httpResponseCode userInfo:nil];
            [self.delegate api:self failedReturnStreetViewImageWithError:error];
        }
        isQuerying = NO;
    }
}

- (void)dealloc {
    [baseUrl release];
}

@end
