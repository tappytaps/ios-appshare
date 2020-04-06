//
//  AppShareRequest.m
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

#import "AppShareRequest.h"

@implementation AppShareRequest

- (instancetype)initWithLink:(NSString *)link text:(NSString *)text subject:(NSString *)subject {
    self = [super init];
    if (self) {
        _link = link;
        _text = text;
        _subject = subject;
    }
    return self;
}

- (NSURL *)linkUrl {
    return [NSURL URLWithString:self.link];
}

- (UIImage *)generateQRCode {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    if (filter) {
        NSData *data = [self.link dataUsingEncoding:NSASCIIStringEncoding];
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
