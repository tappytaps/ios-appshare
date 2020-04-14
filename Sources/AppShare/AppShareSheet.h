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

@class ShareService;

typedef void (^ShareFinishedCallback)(ShareService * _Nullable);

NS_ASSUME_NONNULL_BEGIN

@interface AppShareSheet : NSObject

- (instancetype)initWithRequest:(AppShareRequest *)request presentationContext:(UIViewController *)presentationContext;
- (instancetype)initWithRequest:(AppShareRequest *)request presentationContext:(UIViewController *)presentationContext finishedCallback:(ShareFinishedCallback)callback;
- (instancetype)initWithRequest:(AppShareRequest *)request configuration:(AppShareConfiguration *)configuration presentationContext:(UIViewController *)presentationContext;
- (instancetype)initWithRequest:(AppShareRequest *)request configuration:(AppShareConfiguration *)configuration presentationContext:(UIViewController *)presentationContext finishedCallback:(ShareFinishedCallback)callback;
- (void)show;

@end

NS_ASSUME_NONNULL_END
