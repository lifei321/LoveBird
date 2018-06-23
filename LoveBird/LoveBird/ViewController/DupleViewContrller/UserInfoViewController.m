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
#import "UserInfoHeaderView.h"
#import "UserDao.h"
#import "MJRefresh.h"
#import "UserModel.h"
#import "MineLogViewController.h"
#import "MineBirdViewController.h"
#import "MinePhotoViewController.h"
#import "MineFollowController.h"


@interface UserInfoViewController ()
@property (nonatomic, strong) UserInfoHeaderView *headerView;

@property (nonatomic, strong) MineLogViewController *logController;

@property (nonatomic, strong) MineBirdViewController *birdController;

@property (nonatomic, strong) MinePhotoViewController *photoController;

@property (nonatomic, strong) UserModel *userModel;

@end

@implementation UserInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.talentModel.master;
    
    [self netForMyInfo];
}



- (void)netForMyInfo {
    [AppBaseHud showHudWithLoding:self.view];

    @weakify(self);
    [UserDao userMyInfo:self.talentModel.msaterid SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [AppBaseHud hideHud:self.view];
        [self setTableView];

        UserModel *model = (UserModel *)responseObject;
        self.userModel = model;
        
        [self.tableView reloadData];
        [self.headerView reloadData:model];
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
    
    UserInfoHeaderView *headerView = [[UserInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(612))];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    UIScrollView *footerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.height - self.headerView.height)];
    footerView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 0);
    footerView.showsVerticalScrollIndicator = NO;
    footerView.bounces = NO;
    footerView.pagingEnabled = YES;
    self.tableView.tableFooterView = footerView;
    
    MineLogViewController *logController = [[MineLogViewController  alloc] init];
    logController.taid = self.talentModel.msaterid;
    [self addChildViewController:logController];
    logController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, footerView.height);
    [footerView addSubview:logController.view];
    
    
    MineBirdViewController *birdController = [[MineBirdViewController alloc] init];
    birdController.taid = self.talentModel.msaterid;
    [self addChildViewController:birdController];
    birdController.view.frame = CGRectMake(SCREEN_WIDTH , 0, SCREEN_WIDTH, footerView.height);
    [footerView addSubview:birdController.view];
    
    MinePhotoViewController *photoController = [[MinePhotoViewController alloc] init];
    photoController.taid = self.talentModel.msaterid;
    [self addChildViewController:photoController];
    photoController.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, footerView.height);
    [footerView addSubview:photoController.view];
    
    
    @weakify(footerView);
    headerView.headerBlock = ^(NSInteger tag) {
        @strongify(footerView);
        switch (tag) {
            case 100:
            {
                footerView.contentOffset = CGPointMake(0, 0);
            }
                break;

            case 300:
            {
                footerView.contentOffset = CGPointMake(SCREEN_WIDTH , 0);
            }
                break;
            case 400:
            {
                footerView.contentOffset = CGPointMake(SCREEN_WIDTH * 2, 0);
                
            }
                break;
                
            default:
                break;
        }
    };
}

@end
