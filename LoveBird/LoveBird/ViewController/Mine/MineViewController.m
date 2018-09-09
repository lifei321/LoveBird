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
#import "MineLogViewController.h"
#import "MineCollectViewController.h"
#import "MineBirdViewController.h"
#import "MinePhotoViewController.h"
#import "MineFriendViewController.h"
#import "MineFollowController.h"
#import "WorksViewController.h"
#import "MineDetailView.h"

@interface MineViewController ()

@property (nonatomic, strong) MineHeaderView *headerView;

@property (nonatomic, strong) MineLogViewController *logController;

@property (nonatomic, strong) MineCollectViewController *collectController;

@property (nonatomic, strong) MineBirdViewController *birdController;

@property (nonatomic, strong) MinePhotoViewController *photoController;

@property (nonatomic, strong) MineFriendViewController *friendController;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netForUserInfo) name:kLoginSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOutNotifycation) name:kLogoutSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netForMyInfo) name:kRefreshUserInfoNotification object:nil];

    
    
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;
    
    [self setTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigation];
}

- (void)netForUserInfo {
    [AppBaseHud showHudWithLoding:self.view];
    [self netForMyInfo];
}

- (void)netForMyInfo {
    @weakify(self);
    [UserDao userMyInfo:@"" SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [AppBaseHud hideHud:self.view];
        
        [self.tableView reloadData];
        [self.headerView reloadData];
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

// 退出登录
- (void)logOutNotifycation {
        
}

- (void)notificationButton:(UIButton *)button {
    NotifycationViewController *vc = [[NotifycationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)detailButton:(UIButton *)button {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:backView];
    
    MineDetailView *birdView = [[MineDetailView alloc] initWithFrame:CGRectMake(AutoSize6(80), AutoSize6(260), SCREEN_WIDTH - AutoSize6(160), SCREEN_HEIGHT - AutoSize6(260) - kTabBarHeight - AutoSize6(150))];
    birdView.backView = backView;
    birdView.name = [UserPage sharedInstance].userModel.username;
    birdView.grade = [UserPage sharedInstance].userModel.level;
    birdView.head = [UserPage sharedInstance].userModel.head;
    birdView.userModel = [UserPage sharedInstance].userModel;
    [[UIApplication sharedApplication].keyWindow addSubview:birdView];
}

- (void)shareButton:(UIButton *)button {
    [AppShareManager shareWithTitle:[UserPage sharedInstance].userModel.shareTitle summary:[UserPage sharedInstance].userModel.shareSummary url:[UserPage sharedInstance].userModel.shareUrl image:[UserPage sharedInstance].userModel.shareImg];
}

- (void)setButton:(UIButton *)button {
    MineSetViewController *vc = [[MineSetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}


#pragma mark-- UI


- (void)setTableView {
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight);
    
    MineHeaderView *headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(612))];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    UIScrollView *footerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.height - self.headerView.height)];
    footerView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 0);
    footerView.showsVerticalScrollIndicator = NO;
    footerView.bounces = NO;
    footerView.pagingEnabled = YES;
    self.tableView.tableFooterView = footerView;

    MineLogViewController *logController = [[MineLogViewController  alloc] init];
    [self addChildViewController:logController];
    logController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, footerView.height);
    [footerView addSubview:logController.view];

    MineCollectViewController *collectController = [[MineCollectViewController alloc] init];
    [self addChildViewController:collectController];
    collectController.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, footerView.height);
    [footerView addSubview:collectController.view];

    MineBirdViewController *birdController = [[MineBirdViewController alloc] init];
    [self addChildViewController:birdController];
    birdController.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, footerView.height);
    [footerView addSubview:birdController.view];

    MinePhotoViewController *photoController = [[MinePhotoViewController alloc] init];
    photoController.authorId = [UserPage sharedInstance].uid;
    [self addChildViewController:photoController];
    photoController.view.frame = CGRectMake(SCREEN_WIDTH * 3, 0, SCREEN_WIDTH, footerView.height);
    [footerView addSubview:photoController.view];

    MineFriendViewController *friendController = [[MineFriendViewController alloc] init];
    [self addChildViewController:friendController];
    friendController.view.frame = CGRectMake(SCREEN_WIDTH * 4, 0, SCREEN_WIDTH, footerView.height);
    [footerView addSubview:friendController.view];

    
    @weakify(footerView);
    headerView.headerBlock = ^(NSInteger tag) {
        @strongify(footerView);
        switch (tag) {
            case 100:
            {
                footerView.contentOffset = CGPointMake(0, 0);
            }
                break;
            case 200:
            {
                footerView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
            }
                break;
            case 300:
            {
                footerView.contentOffset = CGPointMake(SCREEN_WIDTH * 2, 0);
            }
                break;
            case 400:
            {
                footerView.contentOffset = CGPointMake(SCREEN_WIDTH * 3, 0);

            }
                break;
            case 500:
            {
                footerView.contentOffset = CGPointMake(SCREEN_WIDTH * 4, 0);
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
    [notificationButton setImage:[UIImage imageNamed:@"home_icon_inform"] forState:UIControlStateNormal];
    [notificationButton setImage:[UIImage imageNamed:@"home_icon_inform"] forState:UIControlStateSelected];
    [notificationButton addTarget:self action:@selector(notificationButton:) forControlEvents:UIControlEventTouchUpInside];
    notificationButton.frame = CGRectMake(0, 0, 30, 10);
    notificationButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
    UIButton *detailButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [detailButton setImage:[UIImage imageNamed:@"mine_detail"] forState:UIControlStateNormal];
    [detailButton addTarget:self action:@selector(detailButton:) forControlEvents:UIControlEventTouchUpInside];
    detailButton.frame = CGRectMake(0, 0, 30, 10);
    detailButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
    UIBarButtonItem *notificationItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    UIBarButtonItem *detailItem = [[UIBarButtonItem alloc] initWithCustomView:detailButton];
    [self.navigationBarItem setLeftBarButtonItems:[NSArray arrayWithObjects: notificationItem, detailItem,nil]];
    
    UIButton *shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [shareButton setImage:[UIImage imageNamed:@"mine_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.frame = CGRectMake(0, 0, 30, 10);
    shareButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
    UIButton *setButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [setButton setImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(setButton:) forControlEvents:UIControlEventTouchUpInside];
    setButton.frame = CGRectMake(0, 0, 30, 10);
    setButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
    [self.navigationBarItem setRightBarButtonItems:[NSArray arrayWithObjects: setItem, shareItem, nil]];
    
}
@end
