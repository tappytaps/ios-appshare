//
//  AppShareRequest.h
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

@import Foundation;
@import UIKit;
@import LinkPresentation;

NS_ASSUME_NONNULL_BEGIN

@interface AppShareRequest : NSObject

@property (readonly) NSString *link;
@property (readonly) NSString *text;
@property (readonly) NSString *subject;

@property (readonly, nonatomic) NSURL *linkUrl;

- (instancetype)initWithLink:(NSString *)link text:(NSString *)text subject:(NSString *)subject;

- (UIImage *)generateQRCode;

@end

@interface AppShareRequestActivityItem : NSObject<UIActivityItemSource>

- (instancetype)initWithShareRequest:(AppShareRequest *)shareRequest;

@end

NS_ASSUME_NONNULL_END
