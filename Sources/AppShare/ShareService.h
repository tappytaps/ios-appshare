//
//  ShareService.h
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

@import Foundation;

#import "AppShareRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ShareServiceTypeFacebook,
    ShareServiceTypeMessenger,
    ShareServiceTypeWhatsApp,
    ShareServiceTypeTwitter,
    ShareServiceTypeEmail,
    ShareServiceTypeCopyLink,
    ShareServiceTypeMore,
    ShareServiceTypeQRCode,
    ShareServiceTypeWeChat,
    ShareServiceTypeVKontakte,
    ShareServiceTypeViber,
} ShareServiceType;

@interface ShareService : NSObject

@property ShareServiceType serviceType;

@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) NSString *imageName;
@property (readonly, nonatomic) NSString *urlScheme;

+ (NSArray<ShareService *> *)allServices;

+ (instancetype)serviceWithType:(ShareServiceType)serviceType;

- (void)shareRequest:(AppShareRequest *)request from:(UIViewController *)viewController;
- (BOOL)isAvailable;

@end

NS_ASSUME_NONNULL_END
