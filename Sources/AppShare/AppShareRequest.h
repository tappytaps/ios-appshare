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
@property (readonly) NSString *subject;
@property (readonly) NSString *text;
@property (readonly) NSString *personalText;

@property (readonly, nonatomic) NSURL *linkUrl;

- (instancetype)initWithLink:(NSString *)link subject:(NSString *)subject text:(NSString *)text personalText:(NSString *)personalText;

- (UIImage *)generateQRCode;

@end

@interface AppShareRequestActivityItem : NSObject<UIActivityItemSource>

- (instancetype)initWithShareRequest:(AppShareRequest *)shareRequest;

@end

NS_ASSUME_NONNULL_END
