//
//  MineViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "MineViewController.h"
#import "MineDataSourceManager.h"
#import "MineTableViewCell.h"
#import "MineSetViewController.h"
#import "NotifycationViewController.h"
#import "MineHeaderView.h"
#import "UserDao.h"
#import "MJRefresh.h"
#import "UserModel.h"

@interface MineViewController ()

@property (nonatomic, strong) MineHeaderView *headerView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;
    
    [self setTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigation];
}

- (void)netForMyInfo {

    @weakify(self);
    [UserDao userMyInfoSuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        [self.headerView reloadData];
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (void)notificationButton:(UIButton *)button {
    NotifycationViewController *vc = [[NotifycationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)detailButton:(UIButton *)button {
    NotifycationViewController *vc = [[NotifycationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)shareButton:(UIButton *)button {
    NotifycationViewController *vc = [[NotifycationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setButton:(UIButton *)button {
    MineSetViewController *vc = [[MineSetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setTableView {
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight);
    self.dataSourceArray =  [MineDataSourceManager DataSource];
    [self registerClass:[MineTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MineTableViewCell class]) dataSource:nil];
    
    MineHeaderView *headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(612))];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    @weakify(self);
    headerView.headerBlock = ^(NSInteger tag) {
        @strongify(self);
        
        switch (tag) {
            case 100:
            {
                
            }
                break;
            case 200:
            {
                
            }
                break;
            case 300:
            {
                
            }
                break;
            case 400:
            {
                
            }
                break;
            case 500:
            {
                
            }
                break;
                
            default:
                break;
        }
    };
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForMyInfo)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setNavigation {
    
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    UIButton *notificationButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [notificationButton setImage:[UIImage imageNamed:@"mine_notification_no"] forState:UIControlStateNormal];
    [notificationButton setImage:[UIImage imageNamed:@"mine_notification_yes"] forState:UIControlStateSelected];
    [notificationButton addTarget:self action:@selector(notificationButton:) forControlEvents:UIControlEventTouchUpInside];
    notificationButton.frame = CGRectMake(0, 0, 15, 10);
    notificationButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
    UIButton *detailButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [detailButton setImage:[UIImage imageNamed:@"mine_detail"] forState:UIControlStateNormal];
    [detailButton addTarget:self action:@selector(detailButton:) forControlEvents:UIControlEventTouchUpInside];
    detailButton.frame = CGRectMake(0, 0, 15, 10);
    detailButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
    UIBarButtonItem *notificationItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    UIBarButtonItem *detailItem = [[UIBarButtonItem alloc] initWithCustomView:detailButton];
    [self.navigationBarItem setLeftBarButtonItems:[NSArray arrayWithObjects: notificationItem, detailItem,nil]];
    
    UIButton *shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [shareButton setImage:[UIImage imageNamed:@"mine_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.frame = CGRectMake(0, 0, 15, 10);
    shareButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
    UIButton *setButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [setButton setImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(setButton:) forControlEvents:UIControlEventTouchUpInside];
    setButton.frame = CGRectMake(0, 0, 15, 10);
    setButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
    [self.navigationBarItem setRightBarButtonItems:[NSArray arrayWithObjects: setItem, shareItem, nil]];
    
}
@end
