//
//  AppShareRequest.m
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

#import "AppShareRequest.h"

@implementation AppShareRequest

- (instancetype)initWithLink:(NSString *)link qrLink:(nullable NSString *)qrLink subject:(NSString *)subject text:(NSString *)text personalText:(NSString *)personalText {
    self = [self init];
    if (self) {
        _link = link;
        _qrLink = qrLink;
        _subject = subject;
        _text = text;
        _personalText = personalText;
    }
    return self;
}

- (instancetype)initWithLink:(NSString *)link subject:(NSString *)subject text:(NSString *)text personalText:(NSString *)personalText {
    self = [self initWithLink:link qrLink:nil subject:subject text:text personalText:personalText];
    return self;
}

- (NSURL *)linkUrl {
    return [NSURL URLWithString:self.link];
}

- (UIImage *)generateQRCode {
    NSString *link = self.qrLink ? : self.link;
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    if (filter) {
        NSData *data = [link dataUsingEncoding:NSASCIIStringEncoding];
        [filter setValue:data forKey:@"inputMessage"];
        CGAffineTransform transform = CGAffineTransformMakeScale(12, 12);
        CIImage *output = [[filter outputImage] imageByApplyingTransform:transform];
        if (output) {
            return [UIImage imageWithCIImage:output];
        }
    }
    return nil;
}

@end

@interface AppShareRequestActivityItem ()

@property AppShareRequest *shareRequest;

@end

@implementation AppShareRequestActivityItem

- (instancetype)initWithShareRequest:(AppShareRequest *)shareRequest {
    self = [super init];
    if (self) {
        self.shareRequest = shareRequest;
    }
    return self;
}

- (nullable id)activityViewController:(nonnull UIActivityViewController *)activityViewController itemForActivityType:(nullable UIActivityType)activityType {
    return self.shareRequest.text;
}

- (nonnull id)activityViewControllerPlaceholderItem:(nonnull UIActivityViewController *)activityViewController {
    return self.shareRequest.text;
}

- (NSString *)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(UIActivityType)activityType {
    return self.shareRequest.subject;
}

- (LPLinkMetadata *)activityViewControllerLinkMetadata:(UIActivityViewController *)activityViewController  API_AVAILABLE(ios(13.0)) {
    LPLinkMetadata *metadata = [[LPLinkMetadata alloc] init];
    metadata.originalURL = self.shareRequest.linkUrl;
    return metadata;
}

@end
