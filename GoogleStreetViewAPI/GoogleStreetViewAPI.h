//
//  GoogleStreetViewAPI.h
//  GoogleStreetViewAPI
//
//  Created by Ming Yang on 12/10/11.
//

#import <Foundation/Foundation.h>
#import "GoogleStreetViewAPIDelegate.h"

static NSString* const GOOGLE_STREET_VIEW_API_BASE_URL = @"http://maps.googleapis.com/maps/api/streetview";

@interface GoogleStreetViewAPI : NSObject <NSURLConnectionDataDelegate> {
    NSString* baseUrl;
    NSURLConnection* urlConn;
    int httpResponseCode;
    NSMutableData* responseData;
    BOOL isQuerying;

    BOOL usingSensor;
    int imageWidth;
    int imageHeight;
    id<GoogleStreetViewAPIDelegate> delegate;
}

- (id)initWithImageWidth:(int)width imageHeight:(int)height usingSensor:(BOOL)_usingSensor;

- (id)initWithBaseUrl:(NSString*)url imageWidth:(int)width imageHeight:(int)height usingSensor:(BOOL)_usingSensor;

- (void)requestForStreetViewAtLatitude:(double)latitude 
                              longitude:(double)longitude
                              heading:(int)heading
                              fov:(int)fov
                              pitch:(int)pitch;

@property (nonatomic, readonly) int imageWidth;
@property (nonatomic, readonly) int imageHeight;
@property (nonatomic, readonly) BOOL usingSensor;
@property (nonatomic, copy) NSString* baseUrl;
@property (nonatomic, assign) id<GoogleStreetViewAPIDelegate> delegate;

@end
