//
//  NSBundle+Resources.m
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

#import "NSBundle+Resources.h"
#import "AppShareRequest.h"

@implementation NSBundle (Resources)

+ (NSBundle *)resourcesBundle {
    #if defined(SWIFTPM_MODULE_BUNDLE) 
        return SWIFTPM_MODULE_BUNDLE;
    #else
        NSURL *resourcesBundleUrl = [[NSBundle bundleForClass:[AppShareRequest class]] URLForResource:@"AppShareResources" withExtension:@"bundle"];
        if (resourcesBundleUrl) {
            return [NSBundle bundleWithURL:resourcesBundleUrl];
        } else {
            return nil;
        }
    #endif
}

@end

@implementation UIImage (Bundle)

+ (UIImage *)bundleImageNamed:(NSString *)imageName {
    NSBundle *resourcesBundle = [NSBundle resourcesBundle];
    if (resourcesBundle) {
        return [UIImage imageNamed:imageName inBundle:resourcesBundle compatibleWithTraitCollection:nil];
    } else {
        return nil;
    }
}

@end

@implementation NSString (Bundle)

+ (NSString *)localizedStringWithKey:(NSString *)localizationKey {
    NSBundle *resourcesBundle = [NSBundle resourcesBundle];
    if (resourcesBundle) {
        return NSLocalizedStringFromTableInBundle(localizationKey, nil, resourcesBundle, @"");
    } else {
        return nil;
    }
}

@end
