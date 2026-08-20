//
//  NSBundle+Resources.h
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

@import Foundation;
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (Resources)

+ (NSBundle *)resourcesBundle;

@end

@interface UIImage (Bundle)

+ (UIImage *)bundleImageNamed:(NSString *)imageName;

@end


@interface NSString (Bundle)

+ (NSString *)localizedStringWithKey:(NSString *)localizationKey;

@end

NS_ASSUME_NONNULL_END
