//
//  AppShareSheet.m
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

#import "AppShareSheet.h"
#import "AppShareViewController.h"

@interface AppShareSheet ()

@property AppShareRequest *request;
@property AppShareConfiguration *configuration;
@property UIViewController *presentationContext;

@end

@implementation AppShareSheet

- (instancetype)initWithRequest:(AppShareRequest *)request presentationContext:(UIViewController *)presentationContext {
    self = [self initWithRequest:request configuration:[AppShareConfiguration defaultConfiguration] presentationContext:presentationContext];
    return self;
}

- (instancetype)initWithRequest:(AppShareRequest *)request configuration:(AppShareConfiguration *)cofiguration presentationContext:(UIViewController *)presentationContext {
    self = [super init];
    if (self) {
        self.request = request;
        self.configuration = cofiguration;
        self.presentationContext = presentationContext;
    }
    return self;
}

- (void)show {
    AppShareViewController *shareController = [[AppShareViewController alloc] initWithRequest:self.request configuration:self.configuration];
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
