//
//  QRCodeViewController.m
//  AppShare
//
//  Created by Lukas Boura on 04/04/2020.
//

#import "QRCodeViewController.h"
#import "NSBundle+Resources.h"

@interface QRCodeViewController ()

@property UILabel *titleLabel;
@property UIImageView *imageView;

@end

@implementation QRCodeViewController

- (instancetype)initWithQRCodeImage:(UIImage *)image {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        self.imageView = [[UIImageView alloc] initWithImage:image];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    [self setupViews];
    [self setupLayout];
}

- (void)setupNavigationItem {
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage bundleImageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonAction)];
    closeButton.tintColor = [UIColor systemGrayColor];
    
    self.navigationItem.leftBarButtonItem = closeButton;
}

- (void)setupViews {
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = [UIColor systemBackgroundColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.text = [NSString localizedStringWithKey:@"qrCodeTitle"];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 2;
}

- (void)setupLayout {
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.imageView];
    
    NSLayoutConstraint *imageViewWidthConstraint = [self.imageView.widthAnchor constraintEqualToConstant:320];
    imageViewWidthConstraint.priority = 999;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.imageView.leadingAnchor constraintGreaterThanOrEqualToAnchor:self.view.leadingAnchor constant:32],
        [self.imageView.trailingAnchor constraintLessThanOrEqualToAnchor:self.view.trailingAnchor constant:-32],
        [self.imageView.heightAnchor constraintEqualToAnchor:self.imageView.widthAnchor],
        imageViewWidthConstraint,
        
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:32],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-32],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.imageView.topAnchor constant:-48]
    ]];
}

- (void)closeButtonAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
