//
//  AppShareSheet.m
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

#import "AppShareSheet.h"
#import "AppShareViewController.h"
#import "ShareService.h"



@interface AppShareSheet () {
    ShareFinishedCallback shareFinishedCallback;
}

@property AppShareRequest *request;
@property AppShareConfiguration *configuration;
@property UIViewController *presentationContext;

@end



@implementation AppShareSheet

- (instancetype)initWithRequest:(AppShareRequest *)request presentationContext:(UIViewController *)presentationContext {
    self = [self initWithRequest:request presentationContext:presentationContext finishedCallback:nil];
    return self;
}

- (instancetype)initWithRequest:(AppShareRequest *)request configuration:(AppShareConfiguration *)configuration presentationContext:(UIViewController *)presentationContext {
    self = [self initWithRequest:request configuration:configuration presentationContext:presentationContext finishedCallback:nil];
    return self;
}


- (instancetype)initWithRequest:(AppShareRequest *)request presentationContext:(UIViewController *)presentationContext finishedCallback:(ShareFinishedCallback)callback {
    self = [self initWithRequest:request configuration:[AppShareConfiguration defaultConfiguration] presentationContext:presentationContext finishedCallback: callback];
    return self;
}

- (instancetype)initWithRequest:(AppShareRequest *)request configuration:(AppShareConfiguration *)configuration presentationContext:(UIViewController *)presentationContext finishedCallback:(ShareFinishedCallback)callback{
    self = [super init];
    if (self) {
        self.request = request;
        self.configuration = configuration;
        self.presentationContext = presentationContext;
        shareFinishedCallback = callback;
    }
    return self;
}

- (void)show {
    AppShareViewController *shareController = [[AppShareViewController alloc] initWithRequest:self.request configuration:self.configuration callback:shareFinishedCallback];
    shareController.extendedLayoutIncludesOpaqueBars = YES;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:shareController];
    navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    [navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navigationController.navigationBar.shadowImage = [UIImage new];
    navigationController.navigationBar.translucent = NO;
    if (@available(iOS 13.0, *)) {
        navigationController.navigationBar.barTintColor = [UIColor systemBackgroundColor];
    } else {
        navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    }
    
    if (self.configuration.hasTitle) {
        if (@available(iOS 11.0, *)) {
            navigationController.navigationBar.prefersLargeTitles = YES;
        }
    }
    
    [self.presentationContext presentViewController:navigationController animated:YES completion:nil];
}

@end
