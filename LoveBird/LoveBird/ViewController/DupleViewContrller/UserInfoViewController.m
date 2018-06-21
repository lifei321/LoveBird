//
//  UserInfoViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/21.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "UserInfoViewController.h"
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


@interface UserInfoViewController ()
@property (nonatomic, strong) MineHeaderView *headerView;

@property (nonatomic, strong) MineLogViewController *logController;

@property (nonatomic, strong) MineCollectViewController *collectController;

@property (nonatomic, strong) MineBirdViewController *birdController;

@property (nonatomic, strong) MinePhotoViewController *photoController;

@property (nonatomic, strong) MineFriendViewController *friendController;
@end

@implementation UserInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.talentModel.master;
    
    [self setTableView];
    [self netForMyInfo];
}


- (void)netForUserInfo {
    [AppBaseHud showHudWithLoding:self.view];
    [self netForMyInfo];
}

- (void)netForMyInfo {
    @weakify(self);
    [UserDao userMyInfoSuccessBlock:^(__kindof AppBaseModel *responseObject) {
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}


#pragma mark-- UI


- (void)setTableView {
    
    self.tableView.frame = CGRectMake(0, total_topView_height, SCREEN_WIDTH, SCREEN_HEIGHT - total_topView_height);
    
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
}

@end
