//
//  GoogleStreetViewAPIDelegate.h
//  GoogleStreetViewAPI
//
//  Created by Ming Yang on 12/10/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class GoogleStreetViewAPI;

@protocol GoogleStreetViewAPIDelegate <NSObject>

- (void)api:(GoogleStreetViewAPI*)api didReturnStreetViewImage:(UIImage*)image;

- (void)api:(GoogleStreetViewAPI*)api failedReturnStreetViewImageWithError:(NSError*)error;


@end
