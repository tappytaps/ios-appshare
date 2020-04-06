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
#import <VK_ios_sdk/VKSdk.h>
#import "WXApi.h"

@implementation ShareService

+ (NSArray<ShareService *> *)allServices {
    return @[
        [ShareService serviceWithType:ShareServiceTypeFacebook],
        [ShareService serviceWithType:ShareServiceTypeMessenger],
        [ShareService serviceWithType:ShareServiceTypeWhatsApp],
        [ShareService serviceWithType:ShareServiceTypeTwitter],
        [ShareService serviceWithType:ShareServiceTypeViber],
        [ShareService serviceWithType:ShareServiceTypeWeChat],
        [ShareService serviceWithType:ShareServiceTypeVKontakte],
        [ShareService serviceWithType:ShareServiceTypeEmail],
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
            return @"whatsapp";
        case ShareServiceTypeMessenger:
            return @"messenger";
        case ShareServiceTypeEmail:
            return @"message";
        case ShareServiceTypeCopyLink:
            return @"copy";
        case ShareServiceTypeWeChat:
            return @"weChat";
        case ShareServiceTypeVKontakte:
            return @"vKontakte";
        case ShareServiceTypeViber:
            return @"viber";
        case ShareServiceTypeMore:
        case ShareServiceTypeQRCode:
            return @"more";
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
        case ShareServiceTypeCopyLink:
            return [NSString localizedStringWithKey:@"copyLink"];
        case ShareServiceTypeMore:
            return [NSString localizedStringWithKey:@"more"];
        case ShareServiceTypeQRCode:
            return [NSString localizedStringWithKey:@"qrCode"];
        case ShareServiceTypeWeChat:
            return [NSString localizedStringWithKey:@"weChat"];
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
        case ShareServiceTypeVKontakte:
            return @"vk";
        case ShareServiceTypeViber:
            return @"viber";
        case ShareServiceTypeCopyLink:
        case ShareServiceTypeMore:
        case ShareServiceTypeQRCode:
        case ShareServiceTypeWeChat:
            return @"";
    }
}

- (void)shareRequest:(AppShareRequest *)request from:(nonnull UIViewController *)viewController {
    switch (self.serviceType) {
        case ShareServiceTypeFacebook: {
            NSURL *url = request.linkUrl;
            if (url) {
                FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
                content.contentURL = url;
                content.quote = request.text;
                
                FBSDKShareDialog *dialog = [FBSDKShareDialog dialogWithViewController:viewController withContent:content delegate:nil];
                [dialog show];
            }
        }
        case ShareServiceTypeTwitter:
            [self openUrl:[NSString stringWithFormat:@"%@://post?message=%@", self.urlScheme, request.text]];
        case ShareServiceTypeWhatsApp:
            [self openUrl:[NSString stringWithFormat:@"%@://send?text=%@", self.urlScheme, request.text]];
        case ShareServiceTypeMessenger:
            [self openUrl:[NSString stringWithFormat:@"%@://share?link=%@", self.urlScheme, request.link]];
        case ShareServiceTypeEmail:
            [self openUrl:[NSString stringWithFormat:@"%@:?subject=%@&body=%@", self.urlScheme, request.subject, request.text]];
        case ShareServiceTypeViber:
            [self openUrl:[NSString stringWithFormat:@"%@://forward?text=%@", self.urlScheme, request.text]];
        case ShareServiceTypeCopyLink:
            UIPasteboard.generalPasteboard.string = request.link;
            return;
        case ShareServiceTypeMore: {
            AppShareRequestActivityItem *shareRequestItem = [[AppShareRequestActivityItem alloc] initWithShareRequest:request];
            UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[shareRequestItem] applicationActivities:nil];
            
            [viewController presentViewController:activityController animated:YES completion:nil];
        }
        case ShareServiceTypeQRCode: {
            UIImage *qrCodeImage = [request generateQRCode];
            QRCodeViewController *qrCoreController = [[QRCodeViewController alloc] initWithQRCodeImage:qrCodeImage];
            
            [viewController presentViewController:qrCoreController animated:YES completion:nil];
        }
        case ShareServiceTypeWeChat: {
            WXWebpageObject *ext = [WXWebpageObject object];
            ext.webpageUrl = request.link;
            
            WXMediaMessage *msg = [[WXMediaMessage alloc] init];
            msg.title = request.text;
            msg.mediaObject = ext;
            
            SendMessageToWXReq *weChatRequest = [[SendMessageToWXReq alloc] init];
            weChatRequest.message = msg;
            weChatRequest.text = request.text;
            weChatRequest.bText = NO;
            weChatRequest.scene = WXSceneSession;
            
            [WXApi sendReq:weChatRequest completion:^(BOOL success) {
                NSLog(@"WeChat share result: %i", success);
            }];
        }
        case ShareServiceTypeVKontakte: {
            if (![VKSdk initialized]) {
                [VKSdk initializeWithAppId:@""];
            }
            VKShareDialogController *shareDialog = [VKShareDialogController new];
            shareDialog.text = request.text;
            
            [shareDialog setCompletionHandler:^(VKShareDialogController *dialog, VKShareDialogControllerResult result) {
                [dialog dismissViewControllerAnimated:YES completion:nil];
            }];
            [viewController presentViewController:shareDialog animated:YES completion:nil];
        }
    }
}

- (BOOL)isAvailable {
    if (self.serviceType == ShareServiceTypeCopyLink || self.serviceType == ShareServiceTypeMore || self.serviceType == ShareServiceTypeQRCode) {
        return YES;
    }
    if (self.serviceType == ShareServiceTypeWeChat) {
        return [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi];
    }
    NSURL *testUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@://", self.urlScheme]];
    return [[UIApplication sharedApplication] canOpenURL:testUrl];
}

- (void)openUrl:(NSString *)url {
    NSURL *encodedUrl = [NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLFragmentAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:encodedUrl options:@{} completionHandler:nil];
}

@end
