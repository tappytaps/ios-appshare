//
//  AppShareSheet.h
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

@import Foundation;
@import UIKit;

#import "AppShareRequest.h"
#import "AppShareConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppShareSheet : NSObject

- (instancetype)initWithRequest:(AppShareRequest *)request presentationContext:(UIViewController *)presentationContext;
- (instancetype)initWithRequest:(AppShareRequest *)request configuration:(AppShareConfiguration *)cofiguration presentationContext:(UIViewController *)presentationContext;

- (void)show;

@end

NS_ASSUME_NONNULL_END
