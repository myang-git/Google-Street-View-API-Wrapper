//
//  ViewController.m
//  TestGoogleStreetViewApp
//
//  Created by Yang Ming-Hsien on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize streetViewImageView;
@synthesize activityIndicatorView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    api = [[GoogleStreetViewAPI alloc] initWithImageWidth:240 imageHeight:240 usingSensor:NO];
    api.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicatorView startAnimating];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    double latitude = 40.7500;
    double longitude = -73.9946;
    [api requestForStreetViewAtLatitude:latitude longitude:longitude heading:0 fov:90 pitch:0];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Google Street View API

- (void)api:(GoogleStreetViewAPI *)api didReturnStreetViewImage:(UIImage *)image {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.streetViewImageView.image = image; 
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;
    });
    
}

- (void)api:(GoogleStreetViewAPI *)api failedReturnStreetViewImageWithError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicatorView stopAnimating];
        self.activityIndicatorView.hidden = YES;
        NSString* errorMessage = [NSHTTPURLResponse localizedStringForStatusCode:error.code];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    });
}

- (void)dealloc {
    [streetViewImageView release];
    [activityIndicatorView release];
    [api release];
}

@end
