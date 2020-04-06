//
//  AppShareViewController.h
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

@import UIKit;

#import "AppShareRequest.h"
#import "AppShareConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppShareViewController : UIViewController

- (instancetype)initWithRequest:(AppShareRequest *)request configuration:(AppShareConfiguration *)configuration;

@end

NS_ASSUME_NONNULL_END
