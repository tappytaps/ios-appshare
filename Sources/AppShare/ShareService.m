//
//  ShareService.m
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

#import "ShareService.h"
#import "NSBundle+Resources.h"
#import "AppShareRequest.h"
#import "QRCodeViewController.h"

#import <FBSDKShareKit/FBSDKShareKit.h>

// #import "WXApi.h"

@implementation ShareService

+ (NSArray<ShareService *> *)allServices {
    return @[
        [ShareService serviceWithType:ShareServiceTypeFacebook],
        [ShareService serviceWithType:ShareServiceTypeMessenger],
        [ShareService serviceWithType:ShareServiceTypeWhatsApp],
        [ShareService serviceWithType:ShareServiceTypeTwitter],
        [ShareService serviceWithType:ShareServiceTypeViber],
        [ShareService serviceWithType:ShareServiceTypeVKontakte],
        [ShareService serviceWithType:ShareServiceTypeEmail],
        [ShareService serviceWithType:ShareServiceTypeSMS],
        [ShareService serviceWithType:ShareServiceTypeCopyLink],
        [ShareService serviceWithType:ShareServiceTypeQRCode],
        [ShareService serviceWithType:ShareServiceTypeMore],
    ];
}

+ (instancetype)serviceWithType:(ShareServiceType)serviceType {
    return [[ShareService alloc] initWithServiceType:serviceType];
}

- (instancetype)initWithServiceType:(ShareServiceType)serviceType {
    self = [super init];
    if (self) {
        _serviceType = serviceType;
    }
    return self;
}

- (NSString *)imageName {
    switch (self.serviceType) {
        case ShareServiceTypeFacebook:
            return @"facebook";
        case ShareServiceTypeTwitter:
            return @"twitter";
        case ShareServiceTypeWhatsApp:
            return @"whatsApp";
        case ShareServiceTypeMessenger:
            return @"messenger";
        case ShareServiceTypeEmail:
            return @"email";
        case ShareServiceTypeSMS:
            return @"sms";
        case ShareServiceTypeCopyLink:
            return @"copy";
        case ShareServiceTypeVKontakte:
            return @"vKontakte";
        case ShareServiceTypeViber:
            return @"viber";
        case ShareServiceTypeMore:
            return @"more";
        case ShareServiceTypeQRCode:
            return @"qrCode";
    }
}

- (NSString *)name {
    switch (self.serviceType) {
        case ShareServiceTypeFacebook:
            return [NSString localizedStringWithKey:@"facebook"];
        case ShareServiceTypeTwitter:
            return [NSString localizedStringWithKey:@"twitter"];
        case ShareServiceTypeWhatsApp:
            return [NSString localizedStringWithKey:@"whatsApp"];
        case ShareServiceTypeMessenger:
            return [NSString localizedStringWithKey:@"messenger"];
        case ShareServiceTypeEmail:
            return [NSString localizedStringWithKey:@"email"];
        case ShareServiceTypeSMS:
            return [NSString localizedStringWithKey:@"sms"];
        case ShareServiceTypeCopyLink:
            return [NSString localizedStringWithKey:@"copyLink"];
        case ShareServiceTypeMore:
            return [NSString localizedStringWithKey:@"more"];
        case ShareServiceTypeQRCode:
            return [NSString localizedStringWithKey:@"qrCode"];
        case ShareServiceTypeVKontakte:
            return [NSString localizedStringWithKey:@"vKontakte"];
        case ShareServiceTypeViber:
            return [NSString localizedStringWithKey:@"viber"];
    }
}

- (NSString *)urlScheme {
    switch (self.serviceType) {
        case ShareServiceTypeFacebook:
            return @"fbapi";
        case ShareServiceTypeTwitter:
            return @"twitter";
        case ShareServiceTypeWhatsApp:
            return @"whatsapp";
        case ShareServiceTypeMessenger:
            return @"fb-messenger";
        case ShareServiceTypeEmail:
            return @"mailto";
        case ShareServiceTypeSMS:
            return @"sms";
        case ShareServiceTypeVKontakte:
            return @"vk";
        case ShareServiceTypeViber:
            return @"viber";
        case ShareServiceTypeCopyLink:
        case ShareServiceTypeMore:
        case ShareServiceTypeQRCode:
            return @"";
    }
}

- (void)shareRequest:(AppShareRequest *)request from:(nonnull UIViewController *)viewController sourceView:(UIView *)sourceView {
    switch (self.serviceType) {
        case ShareServiceTypeFacebook: {
            NSURL *url = request.linkUrl;
            if (url) {
                FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
                content.contentURL = url;
                content.quote = request.personalText;
                
                FBSDKShareDialog *dialog = [FBSDKShareDialog dialogWithViewController:viewController withContent:content delegate:nil];
                [dialog show];
            }
            
        } break;
        case ShareServiceTypeTwitter:
            [self openUrl:[NSString stringWithFormat:@"%@://post?message=%@", self.urlScheme, request.text]];
            break;
        case ShareServiceTypeWhatsApp:
            [self openUrl:[NSString stringWithFormat:@"%@://send?text=%@", self.urlScheme, request.personalText]];
            break;
        case ShareServiceTypeMessenger:
            [self openUrl:[NSString stringWithFormat:@"%@://share?link=%@", self.urlScheme, request.link]];
            break;
        case ShareServiceTypeEmail:
            [self openUrl:[NSString stringWithFormat:@"%@:?subject=%@&body=%@", self.urlScheme, request.subject, request.personalText]];
            break;
        case ShareServiceTypeSMS:
            [self openUrl:[NSString stringWithFormat:@"%@:&body=%@", self.urlScheme, request.personalText]];
            break;
        case ShareServiceTypeViber:
            [self openUrl:[NSString stringWithFormat:@"%@://forward?text=%@", self.urlScheme, request.personalText]];
            break;
        case ShareServiceTypeVKontakte:
            [self openUrl:[NSString stringWithFormat:@"%@://vk.com/share.php?&url=%@", self.urlScheme, request.link]];
            break;
        case ShareServiceTypeCopyLink:
            UIPasteboard.generalPasteboard.string = request.link;
            break;
        case ShareServiceTypeMore: {
            AppShareRequestActivityItem *shareRequestItem = [[AppShareRequestActivityItem alloc] initWithShareRequest:request];
            UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[shareRequestItem] applicationActivities:nil];
            activityController.popoverPresentationController.sourceView = sourceView;
            
            [viewController presentViewController:activityController animated:YES completion:nil];
        } break;
        case ShareServiceTypeQRCode: {
            UIImage *qrCodeImage = [request generateQRCode];
            QRCodeViewController *qrCodeController = [[QRCodeViewController alloc] initWithQRCodeImage:qrCodeImage];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:qrCodeController];
            navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
            [navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            navigationController.navigationBar.shadowImage = [UIImage new];
            if (@available(iOS 11.0, *)) {
                navigationController.navigationBar.prefersLargeTitles = NO;
            }
            
            [viewController presentViewController:navigationController animated:YES completion:nil];
        } break;
    }
}

- (BOOL)isAvailable {
    if (self.serviceType == ShareServiceTypeCopyLink || self.serviceType == ShareServiceTypeMore || self.serviceType == ShareServiceTypeQRCode) {
        return YES;
    }
    NSURL *testUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@://", self.urlScheme]];
    return [[UIApplication sharedApplication] canOpenURL:testUrl];
}

- (void)openUrl:(NSString *)url {
    NSURL *encodedUrl = [NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLFragmentAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:encodedUrl options:@{} completionHandler:nil];
}

@end
