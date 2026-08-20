//
//  AppShareConfiguration.h
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppShareConfiguration : NSObject

@property (nullable) NSString *titleText;
@property (nullable) NSString *descriptionText;

+ (instancetype)defaultConfiguration;

- (instancetype)initWithTitleText:(NSString *)titleText descriptionText:(NSString *)descriptionText;

- (BOOL)hasTitle;

@end

NS_ASSUME_NONNULL_END
