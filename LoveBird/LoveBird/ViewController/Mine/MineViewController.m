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


#import "JXCategoryView.h"
#import "TestListBaseView.h"
#import "JXPagerListRefreshView.h"
#import "JXCategoryTitleImageView.h"

#import "LogTableView.h"
#import "UserBirdClassTableView.h"
#import "UserPhotoTbleView.h"
#import "UserCollectTableView.h"
#import "UserFriendTableView.h"
#import <SDWebImage/SDWebImageManager.h>

//612
#define JXTableHeaderViewHeight  AutoSize6(470)

#define JXheightForHeaderInSection AutoSize6(142)

@interface MineViewController ()<JXPagerViewDelegate, JXCategoryViewDelegate>

@property (nonatomic, strong) MineHeaderView *headerView;


@property (nonatomic, strong) JXPagerView *pagerView;

@property (nonatomic, strong) JXCategoryTitleImageView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) NSArray <TestListBaseView *> *listViewArray;

@property (nonatomic, strong) UIView *naviBGView;
@property (nonatomic, assign) CGFloat pinHeaderViewInsetTop;


@property (nonatomic, strong) UILabel *countLabel;


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netForUserInfo) name:kLoginSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOutNotifycation) name:kLogoutSuccessNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netForMyInfo) name:kRefreshUserInfoNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNumOfMessageCount) name:kRefreshMessageCountNotification object:nil];


    [self setHeadForView];
    [self netForUserInfo];
    [self setNavigationHidden];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 所有消息数量
    [[AppManager sharedInstance] netForMessageCount];
    
    self.navigationController.navigationBar.translucent = false;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
//    self.pagerView.frame = CGRectMake(0, self.pinHeaderViewInsetTop, self.view.bounds.size.width, self.view.bounds.size.height - self.pinHeaderViewInsetTop);

    self.pagerView.frame = self.view.bounds;
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    CGFloat thresholdDistance = 100;
    CGFloat percent = scrollView.contentOffset.y/thresholdDistance;
    percent = MAX(0, MIN(1, percent));
    self.naviBGView.alpha = 1 - percent;
    
    
}

- (void)refreshNumOfMessageCount {
    if ([AppManager sharedInstance].messageCount.integerValue) {
        self.countLabel.hidden = NO;
        self.countLabel.text = [AppManager sharedInstance].messageCount;
    } else {
        self.countLabel.hidden = YES;
        self.countLabel.text = [AppManager sharedInstance].messageCount;
    }
}


- (void)netForUserInfo {
    [AppBaseHud showHudWithLoding:self.view];
    [self netForMyInfo];
}

- (void)netForMyInfo {
    @weakify(self);
    [UserDao userMyInfo:@"" SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        [self getTitlesWithInfo];
        [self.categoryView reloadDatas];
        
        [self.headerView reloadData];
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
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


#pragma mark-- UI

- (void)getTitlesWithInfo {
    UserModel *model = [UserPage sharedInstance].userModel;
    
    if ([model.articleNum isBlankString]) {
        model.articleNum = @"0";
    }
    if ([model.birdspeciesNum isBlankString]) {
        model.birdspeciesNum = @"0";
    }

    NSString *log = [NSString stringWithFormat:@"日志 %@", model.articleNum];
    NSString *bird = [NSString stringWithFormat:@"鸟种 %@", model.birdspeciesNum];
    
    _titles = @[log, @"收藏", bird, @"相册", @"朋友圈"];
    self.categoryView.titles = self.titles;

}


- (void)setHeadForView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    
    [self getTitlesWithInfo];
    
    MineHeaderView *headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, JXTableHeaderViewHeight)];
    self.headerView = headerView;
    
    LogTableView *powerListView = [[LogTableView alloc] init];
    
    UserCollectTableView *collectListView = [[UserCollectTableView alloc] init];
    
    UserBirdClassTableView *hobbyListView = [[UserBirdClassTableView alloc] init];
    hobbyListView.taid = [UserPage sharedInstance].uid;
    
    UserPhotoTbleView *partnerListView = [[UserPhotoTbleView alloc] init];
    partnerListView.authorId = [UserPage sharedInstance].uid;
    partnerListView.fromMe = YES;
    
    UserFriendTableView *friendListView = [[UserFriendTableView alloc] init];

    _listViewArray = @[powerListView, collectListView, hobbyListView, partnerListView, friendListView];
    
    _categoryView = [[JXCategoryTitleImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = kColorDefaultColor;
    self.categoryView.titleColor = UIColorFromRGB(0x7f7f7f);
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.imageNames = @[@"mine_header_log_no", @"mine_header_collect_no", @"mine_header_bird_no", @"mine_header_picture_no", @"mine_header_friend_no"];
    self.categoryView.selectedImageNames = @[@"mine_header_log_yes", @"mine_header_collect_yes", @"mine_header_bird_yes", @"mine_header_picture_yes", @"mine_header_friend_yes"];
    self.categoryView.cellWidthZoomEnabled = NO;
    self.categoryView.titleFont = kFontPF6(22);
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = kColorDefaultColor;
    lineView.indicatorLineWidth = SCREEN_WIDTH / 5;
//    self.categoryView.indicators = @[lineView];
    
    
    _pagerView = [self preferredPagingView];
    [self.view addSubview:self.pagerView];
    
    self.categoryView.contentScrollView = self.pagerView.listContainerView.collectionView;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (JXPagerView *)preferredPagingView {
    return [[JXPagerListRefreshView alloc] initWithDelegate:self];
}

#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.headerView;
//    return _userHeaderView;
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


- (void)setNavigationHidden {
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat topSafeMargin = 20;
    if (@available(iOS 11.0, *)) {
        if ([UIScreen mainScreen].bounds.size.height == 812) {
            topSafeMargin = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
        }
    }
    CGFloat naviHeight = topSafeMargin + 44;
    self.pinHeaderViewInsetTop = naviHeight;
    
    self.naviBGView = [[UIView alloc] init];
    self.naviBGView.alpha = 1;
    self.naviBGView.backgroundColor = [UIColor clearColor];
    self.naviBGView.frame = CGRectMake(0, 0, self.view.bounds.size.width, naviHeight);
    [self.view addSubview:self.naviBGView];
    
    UIButton *notificationButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [notificationButton setImage:[UIImage imageNamed:@"home_icon_inform"] forState:UIControlStateNormal];
    [notificationButton setImage:[UIImage imageNamed:@"home_icon_inform"] forState:UIControlStateSelected];
    [notificationButton addTarget:self action:@selector(notificationButton:) forControlEvents:UIControlEventTouchUpInside];
    notificationButton.frame = CGRectMake(10, topSafeMargin, 44, 44);
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(notificationButton.width - 18, 0, 18, 18)];
    countLabel.clipsToBounds = YES;
    countLabel.layer.cornerRadius = countLabel.width / 2;
    countLabel.backgroundColor = [UIColor redColor];
    countLabel.font = kFont6(20);
    countLabel.textColor = [UIColor whiteColor];
    countLabel.textAlignment = NSTextAlignmentCenter;
    [notificationButton addSubview:countLabel];
    self.countLabel = countLabel;
    self.countLabel.hidden = YES;
    
//    notificationButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.naviBGView addSubview:notificationButton];
    
    UIButton *detailButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [detailButton setImage:[UIImage imageNamed:@"mine_detail"] forState:UIControlStateNormal];
    [detailButton addTarget:self action:@selector(detailButton:) forControlEvents:UIControlEventTouchUpInside];
    detailButton.frame = CGRectMake(54, topSafeMargin, 44, 44);
//    detailButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.naviBGView addSubview:detailButton];
    
//    UIBarButtonItem *notificationItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
//    UIBarButtonItem *detailItem = [[UIBarButtonItem alloc] initWithCustomView:detailButton];
//    [self.navigationBarItem setLeftBarButtonItems:[NSArray arrayWithObjects: notificationItem, detailItem,nil]];
    
    UIButton *shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [shareButton setImage:[UIImage imageNamed:@"mine_share"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.frame = CGRectMake(SCREEN_WIDTH - 54, topSafeMargin, 44, 44);
//    shareButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.naviBGView addSubview:shareButton];
    
    UIButton *setButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [setButton setImage:[UIImage imageNamed:@"mine_setting"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(setButton:) forControlEvents:UIControlEventTouchUpInside];
    setButton.frame = CGRectMake(SCREEN_WIDTH -98, topSafeMargin, 44, 44);
//    setButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.naviBGView addSubview:setButton];
    
//    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
//    UIBarButtonItem *setItem = [[UIBarButtonItem alloc] initWithCustomView:setButton];
//    [self.navigationBarItem setRightBarButtonItems:[NSArray arrayWithObjects: setItem, shareItem, nil]];
    
    
    //让mainTableView可以显示范围外
    self.pagerView.mainTableView.clipsToBounds = false;
    //让头图的布局往上移动naviHeight高度，填充导航栏下面的内容
//    self.headerView.top = -naviHeight;
//    self.headerView.height = naviHeight + self.headerView.height;
//    self.userHeaderView.imageView.frame = CGRectMake(0, -naviHeight, self.view.bounds.size.width, naviHeight + JXTableHeaderViewHeight);
    
}


- (void)didReceiveMemoryWarning {
    //停止下载所有图片
    [[SDWebImageManager sharedManager] cancelAll];
    //清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}



//- (void)setTableView {
//
//    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight);
//
//
//
//    UIScrollView *footerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.height - self.headerView.height)];
//    footerView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 0);
//    footerView.showsVerticalScrollIndicator = NO;
//    footerView.bounces = NO;
//    footerView.pagingEnabled = YES;
//    self.tableView.tableFooterView = footerView;
//
//    MineLogViewController *logController = [[MineLogViewController  alloc] init];
//    [self addChildViewController:logController];
//    logController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, footerView.height);
//    [footerView addSubview:logController.view];
//
//    MineCollectViewController *collectController = [[MineCollectViewController alloc] init];
//    [self addChildViewController:collectController];
//    collectController.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, footerView.height);
//    [footerView addSubview:collectController.view];
//
//    MineBirdViewController *birdController = [[MineBirdViewController alloc] init];
//    [self addChildViewController:birdController];
//    birdController.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, footerView.height);
//    [footerView addSubview:birdController.view];
//
//    MinePhotoViewController *photoController = [[MinePhotoViewController alloc] init];
//    photoController.fromMe = YES;
//    [self addChildViewController:photoController];
//    photoController.view.frame = CGRectMake(SCREEN_WIDTH * 3, 0, SCREEN_WIDTH, footerView.height);
//    [footerView addSubview:photoController.view];
//
//    MineFriendViewController *friendController = [[MineFriendViewController alloc] init];
//    [self addChildViewController:friendController];
//    friendController.view.frame = CGRectMake(SCREEN_WIDTH * 4, 0, SCREEN_WIDTH, footerView.height);
//    [footerView addSubview:friendController.view];
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
//            case 200:
//            {
//                footerView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
//            }
//                break;
//            case 300:
//            {
//                footerView.contentOffset = CGPointMake(SCREEN_WIDTH * 2, 0);
//            }
//                break;
//            case 400:
//            {
//                footerView.contentOffset = CGPointMake(SCREEN_WIDTH * 3, 0);
//
//            }
//                break;
//            case 500:
//            {
//                footerView.contentOffset = CGPointMake(SCREEN_WIDTH * 4, 0);
//            }
//                break;
//
//            default:
//                break;
//        }
//    };
//
//    //默认【下拉刷新】
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForMyInfo)];
//    [self.tableView.mj_header beginRefreshing];
//
//}

@end
