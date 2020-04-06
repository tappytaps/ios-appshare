//
//  ShareServiceCell.m
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

#import "ShareServiceCell.h"
#import "NSBundle+Resources.h"

@interface ShareServiceCell ()

@property UIImageView *iconImageView;
@property UILabel *titleLabel;
@property UIView *separatorView;

@end

@implementation ShareServiceCell

- (instancetype)initWithService:(ShareService *)service {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (self) {
        _service = service;
        [self setup];
    }
    return self;
}

- (void)setup {
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.image = [UIImage bundleImageNamed:self.service.imageName];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.service.name;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    
    self.separatorView = [[UIView alloc] init];
    self.separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    if (@available(iOS 13.0, *)) {
        self.separatorView.backgroundColor = [UIColor systemGray5Color];
    } else {
        self.separatorView.backgroundColor = [UIColor lightGrayColor];
    }
    
    UIStackView *contentStackView = [[UIStackView alloc] init];
    contentStackView.axis = UILayoutConstraintAxisHorizontal;
    contentStackView.spacing = 23;
    contentStackView.alignment = UIStackViewAlignmentCenter;
    contentStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [contentStackView addArrangedSubview:self.iconImageView];
    [contentStackView addArrangedSubview:self.titleLabel];
    
    [self.contentView addSubview:contentStackView];
    [self addSubview:self.separatorView];
    
    [NSLayoutConstraint activateConstraints:@[
        [contentStackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:9],
        [contentStackView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
        [contentStackView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
        [contentStackView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-9],
        
        [self.iconImageView.widthAnchor constraintEqualToConstant:40],
        [self.iconImageView.heightAnchor constraintEqualToConstant:40],
        
        [self.separatorView.heightAnchor constraintEqualToConstant:0.5],
        [self.separatorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:16],
        [self.separatorView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-16],
        [self.separatorView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
    ]];
    
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.backgroundColor = [UIColor clearColor];
}

@end
