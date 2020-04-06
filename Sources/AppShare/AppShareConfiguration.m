//
//  AppShareConfiguration.m
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

#import "AppShareConfiguration.h"
#import "NSBundle+Resources.h"

@implementation AppShareConfiguration

+ (instancetype)defaultConfiguration {
    return [[AppShareConfiguration alloc] initWithTitleText:[NSString localizedStringWithKey:@"defaultTitle"] descriptionText:[NSString localizedStringWithKey:@"defaultDescription"]];
}

- (instancetype)initWithTitleText:(NSString *)titleText descriptionText:(NSString *)descriptionText {
    self = [super init];
    if (self) {
        self.titleText = titleText;
        self.descriptionText = descriptionText;
    }
    return self;
}

- (BOOL)hasTitle {
    return self.titleText != nil;
}

@end
