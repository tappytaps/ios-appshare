//
//  ShareServiceCell.h
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

#import <UIKit/UIKit.h>
#import "ShareService.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShareServiceCell : UITableViewCell

@property (readonly) ShareService *service;

- (instancetype)initWithService:(ShareService *)service;

@end

NS_ASSUME_NONNULL_END
