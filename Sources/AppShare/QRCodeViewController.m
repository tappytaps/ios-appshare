//
//  QRCodeViewController.m
//  AppShare
//
//  Created by Lukas Boura on 04/04/2020.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()

@property UIImageView *imageView;

@end

@implementation QRCodeViewController

- (instancetype)initWithQRCodeImage:(UIImage *)image {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithImage:image];
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    [self.view addSubview:self.imageView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:32],
        [self.imageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-32],
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.imageView.heightAnchor constraintEqualToAnchor:self.imageView.widthAnchor]
    ]];
}

@end
