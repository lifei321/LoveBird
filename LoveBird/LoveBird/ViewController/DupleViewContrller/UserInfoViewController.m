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
#import "UserInfoHeaderNewView.h"
#import "UserDao.h"
#import "MJRefresh.h"
#import "UserModel.h"
#import "MineLogViewController.h"
#import "MineBirdViewController.h"
#import "MinePhotoViewController.h"
#import "MineFollowController.h"

#import "JXPagerView.h"
#import "JXCategoryView.h"
#import "TestListBaseView.h"
#import "JXPagerListRefreshView.h"

#import "LogTableView.h"
#import "UserBirdClassTableView.h"
#import "UserPhotoTbleView.h"

//612
#define JXTableHeaderViewHeight  AutoSize6(470)

static const CGFloat JXheightForHeaderInSection = 50;

@interface UserInfoViewController ()<JXPagerViewDelegate, JXCategoryViewDelegate>
@property (nonatomic, strong) UserInfoHeaderNewView *headerView;

@property (nonatomic, strong) MineLogViewController *logController;

@property (nonatomic, strong) MineBirdViewController *birdController;

@property (nonatomic, strong) MinePhotoViewController *photoController;

@property (nonatomic, strong) UserModel *userModel;


@property (nonatomic, strong) JXPagerView *pagerView;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) NSArray <TestListBaseView *> *listViewArray;



@end

@implementation UserInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.userName;
    
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    

    [self setHeadForView];

    
    [self netForMyInfo];
}

- (void)setHeadForView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    
    _titles = @[@"日志", @"鸟种", @"相册"];
    UserInfoHeaderNewView *headerView = [[UserInfoHeaderNewView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, JXTableHeaderViewHeight)];
    self.headerView = headerView;
    
    LogTableView *powerListView = [[LogTableView alloc] init];
    powerListView.taid = self.uid;
    
    UserBirdClassTableView *hobbyListView = [[UserBirdClassTableView alloc] init];
    hobbyListView.taid = self.uid;
    
    UserPhotoTbleView *partnerListView = [[UserPhotoTbleView alloc] init];
    partnerListView.authorId = self.uid;
    
    _listViewArray = @[powerListView, hobbyListView, partnerListView];

    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    lineView.indicatorLineWidth = 30;
    self.categoryView.indicators = @[lineView];
    
    _pagerView = [self preferredPagingView];
    [self.view addSubview:self.pagerView];
    
    self.categoryView.contentScrollView = self.pagerView.listContainerView.collectionView;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    
    for (TestListBaseView *listView in self.listViewArray) {
        listView.isNeedHeader = YES;
    }
}

- (JXPagerView *)preferredPagingView {
    return [[JXPagerListRefreshView alloc] initWithDelegate:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.pagerView.frame = self.view.bounds;
}

#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.headerView;
}

- (CGFloat)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}

- (CGFloat)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSArray<UIView<JXPagerViewListViewDelegate> *> *)listViewsInPagerView:(JXPagerView *)pagerView {
    return self.listViewArray;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}



- (void)netForMyInfo {
    [AppBaseHud showHudWithLoding:self.view];

    @weakify(self);
    [UserDao userMyInfo:self.uid SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [AppBaseHud hideHud:self.view];
//        [self setTableView];

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

//- (void)notificationButton:(UIButton *)button {
//    NotifycationViewController *vc = [[NotifycationViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (void)detailButton:(UIButton *)button {
//    NotifycationViewController *vc = [[NotifycationViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (void)shareButton:(UIButton *)button {
//    NotifycationViewController *vc = [[NotifycationViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (void)setButton:(UIButton *)button {
//    MineSetViewController *vc = [[MineSetViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 0.01f;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 0.01f;
//}
//
//
//#pragma mark-- UI
//
//
//- (void)setTableView {
//
//    self.tableView.frame = CGRectMake(0, total_topView_height, SCREEN_WIDTH, SCREEN_HEIGHT - total_topView_height);
//
//    UserInfoHeaderView *headerView = [[UserInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, JXTableHeaderViewHeight)];
//    self.headerView = headerView;
//
//    UIScrollView *footerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.height - self.headerView.height)];
//    footerView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 0);
//    footerView.showsVerticalScrollIndicator = NO;
//    footerView.bounces = NO;
//    footerView.pagingEnabled = YES;
//    self.tableView.tableFooterView = footerView;
//
//    MineLogViewController *logController = [[MineLogViewController  alloc] init];
//    logController.taid = self.uid;
//    [self addChildViewController:logController];
//    logController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, footerView.height);
//    [footerView addSubview:logController.view];
//
//
//    MineBirdViewController *birdController = [[MineBirdViewController alloc] init];
//    birdController.taid = self.uid;
//    [self addChildViewController:birdController];
//    birdController.view.frame = CGRectMake(SCREEN_WIDTH , 0, SCREEN_WIDTH, footerView.height);
//    [footerView addSubview:birdController.view];
//
//    MinePhotoViewController *photoController = [[MinePhotoViewController alloc] init];
//    photoController.authorId = self.uid;
//    [self addChildViewController:photoController];
//    photoController.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, footerView.height);
//    [footerView addSubview:photoController.view];
//
//
//    @weakify(footerView);
//    headerView.headerBlock = ^(NSInteger tag) {
//        @strongify(footerView);
//        switch (tag) {
//            case 100:
//            {
//                footerView.contentOffset = CGPointMake(0, 0);
//            }
//                break;
//
//            case 300:
//            {
//                footerView.contentOffset = CGPointMake(SCREEN_WIDTH , 0);
//            }
//                break;
//            case 400:
//            {
//                footerView.contentOffset = CGPointMake(SCREEN_WIDTH * 2, 0);
//
//            }
//                break;
//
//            default:
//                break;
//        }
//    };
//}

@end
