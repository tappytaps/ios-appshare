//
//  AppShareViewController.m
//  AppShare
//
//  Created by Lukas Boura on 03/04/2020.
//

#import "AppShareViewController.h"
#import "ShareServiceCell.h"
#import "NSBundle+Resources.h"

@interface AppShareViewController () <UITableViewDataSource, UITableViewDelegate>

@property UITableView *tableView;
@property NSMutableArray<ShareServiceCell *> *cells;

@property AppShareRequest *request;
@property AppShareConfiguration *configuration;
@property ShareFinishedCallback callback;

@end

@implementation AppShareViewController

- (instancetype)initWithRequest:(AppShareRequest *)request configuration:(AppShareConfiguration *)configuration callback:(ShareFinishedCallback)callback {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.callback = callback;
        self.request = request;
        self.configuration = configuration;

        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.cells = [[NSMutableArray alloc] init];
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
    self.navigationItem.title = self.configuration.titleText;
    if (@available(iOS 11.0, *)) {
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    }
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
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.estimatedRowHeight = 58;
    self.tableView.estimatedSectionHeaderHeight = 32;
    
    for (ShareService *service in [ShareService allServices]) {
        if ([service isAvailable]) {
            ShareServiceCell *cell = [[ShareServiceCell alloc] initWithService:service];
            [self.cells addObject:cell];
        }
    }
}

- (void)setupLayout {
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:0],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:0],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0]
    ]];
}

- (void)closeButtonAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cells[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.cells[indexPath.row].service shareRequest:self.request from:self];
    // inform main gui which share was selected
    if (self.callback != nil) {
        self.callback(self.cells[indexPath.row].service);
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] init];
    label.text = self.configuration.descriptionText;
    label.font = [UIFont systemFontOfSize:17];
    label.numberOfLines = 0;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:label];
    
    [NSLayoutConstraint activateConstraints:@[
        [label.topAnchor constraintEqualToAnchor:headerView.topAnchor constant:12],
        [label.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor constant:-12],
        [label.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor constant:16],
        [label.trailingAnchor constraintEqualToAnchor:headerView.trailingAnchor constant:-16]
    ]];
    
    return headerView;
}

@end
