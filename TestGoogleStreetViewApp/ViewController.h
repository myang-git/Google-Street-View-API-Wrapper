//
//  ViewController.h
//  TestGoogleStreetViewApp
//
//  Created by Yang Ming-Hsien on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleStreetViewAPI.h"
#import "GoogleStreetViewAPIDelegate.h"

@interface ViewController : UIViewController <GoogleStreetViewAPIDelegate> {
    IBOutlet UIImageView*  streetViewImageView;
    IBOutlet UIActivityIndicatorView* activityIndicatorView;
    GoogleStreetViewAPI* api;
}

@property (nonatomic, retain) UIImageView* streetViewImageView;
@property (nonatomic, retain) UIActivityIndicatorView* activityIndicatorView;

@end
