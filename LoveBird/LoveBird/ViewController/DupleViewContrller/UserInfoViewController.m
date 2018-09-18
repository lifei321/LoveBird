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
#import "JXCategoryTitleImageView.h"

#import "LogTableView.h"
#import "UserBirdClassTableView.h"
#import "UserPhotoTbleView.h"
#import "MineDetailView.h"
#import "MineMessageViewController.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/SDWebImageManager.h>

static BOOL SDImageCacheOldShouldDecompressImages = YES;
static BOOL SDImagedownloderOldShouldDecompressImages = YES;


//612
#define JXTableHeaderViewHeight  AutoSize6(470)

#define JXheightForHeaderInSection AutoSize6(142)

@interface UserInfoViewController ()<JXPagerViewDelegate, JXCategoryViewDelegate>
@property (nonatomic, strong) UserInfoHeaderNewView *headerView;

@property (nonatomic, strong) MineLogViewController *logController;

@property (nonatomic, strong) MineBirdViewController *birdController;

@property (nonatomic, strong) MinePhotoViewController *photoController;

@property (nonatomic, strong) UserModel *userModel;


@property (nonatomic, strong) JXPagerView *pagerView;

@property (nonatomic, strong) JXCategoryTitleImageView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) NSArray <TestListBaseView *> *listViewArray;

@property (nonatomic, strong) UIView *naviBGView;


@end

@implementation UserInfoViewController

//- (void)loadView {
//    [super loadView];
//
//    SDImageCache *canche = [SDImageCache sharedImageCache];
//    SDImageCacheOldShouldDecompressImages = canche.config.shouldDecompressImages;
//    canche.config.shouldDecompressImages = NO;
//
//    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
//    SDImagedownloderOldShouldDecompressImages = downloder.shouldDecompressImages;
//    downloder.shouldDecompressImages = NO;
//}
//
//- (void)dealloc {
//    SDImageCache *canche = [SDImageCache sharedImageCache];
//    canche.config.shouldDecompressImages = SDImageCacheOldShouldDecompressImages;
//
//    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
//    downloder.shouldDecompressImages = SDImagedownloderOldShouldDecompressImages;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.userName;
    
    self.hidesBottomBarWhenPushed = YES;
    
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    [self setHeadForView];
    
    [self netForMyInfo];
    
    [self setNavigationHidden];

    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[SDImageCache sharedImageCache]clearMemory];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = false;
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    //清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[SDImageCache sharedImageCache].config setShouldDecompressImages :NO];
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
//    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[SDImageCache sharedImageCache].config setShouldDecompressImages :YES];
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:YES];


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


- (void)getTitlesWithInfo {
    UserModel *model = self.userModel;
    
    if (!model.articleNum ) {
        model.articleNum = @"0";
    }
    if (!model.birdspeciesNum) {
        model.birdspeciesNum = @"0";
    }
    
    NSString *log = [NSString stringWithFormat:@"日志 %@", model.articleNum];
    NSString *bird = [NSString stringWithFormat:@"鸟种 %@", model.birdspeciesNum];
    
    _titles = @[log, bird, @"相册"];
    self.categoryView.titles = self.titles;
}

- (void)setHeadForView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    
    [self getTitlesWithInfo];
    
    UserInfoHeaderNewView *headerView = [[UserInfoHeaderNewView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, JXTableHeaderViewHeight)];
    self.headerView = headerView;
    
    LogTableView *powerListView = [[LogTableView alloc] init];
    powerListView.taid = self.uid;
    
    UserBirdClassTableView *hobbyListView = [[UserBirdClassTableView alloc] init];
    hobbyListView.taid = self.uid;
    
    UserPhotoTbleView *partnerListView = [[UserPhotoTbleView alloc] init];
    partnerListView.authorId = self.uid;
    
    _listViewArray = @[powerListView, hobbyListView, partnerListView];

    _categoryView = [[JXCategoryTitleImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = kColorDefaultColor;
    self.categoryView.titleColor = UIColorFromRGB(0x7f7f7f);
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.imageNames = @[@"mine_header_log_no", @"mine_header_bird_no", @"mine_header_picture_no"];
    self.categoryView.selectedImageNames = @[@"mine_header_log_yes", @"mine_header_bird_yes", @"mine_header_picture_yes"];
    self.categoryView.cellWidthZoomEnabled = NO;
    self.categoryView.titleFont = kFontPF6(22);
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = kColorDefaultColor;
    lineView.indicatorLineWidth = 30;
//    self.categoryView.indicators = @[lineView];
    
    _pagerView = [self preferredPagingView];
    [self.view addSubview:self.pagerView];
    
    self.categoryView.contentScrollView = self.pagerView.listContainerView.collectionView;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
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
        
        [self getTitlesWithInfo];
        
        [self.headerView reloadData:model];
        [self.categoryView reloadDatas];

    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

// 退出登录
- (void)logOutNotifycation {
    
    
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
    
    self.naviBGView = [[UIView alloc] init];
    self.naviBGView.alpha = 1;
    self.naviBGView.backgroundColor = [UIColor clearColor];
    self.naviBGView.frame = CGRectMake(0, 0, self.view.bounds.size.width, naviHeight);
    [self.view addSubview:self.naviBGView];

    
    UIButton *notificationButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [notificationButton setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
    [notificationButton setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateSelected];
    [notificationButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    notificationButton.frame = CGRectMake(0, topSafeMargin, 44, 44);
    //    notificationButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.naviBGView addSubview:notificationButton];
    
    UIButton *detailButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [detailButton setImage:[UIImage imageNamed:@"mine_detail"] forState:UIControlStateNormal];
    [detailButton addTarget:self action:@selector(detailButton:) forControlEvents:UIControlEventTouchUpInside];
    detailButton.frame = CGRectMake(44, topSafeMargin, 44, 44);
    //    detailButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.naviBGView addSubview:detailButton];
    
    
    //    UIBarButtonItem *notificationItem = [[UIBarButtonItem alloc] initWithCustomView:notificationButton];
    //    UIBarButtonItem *detailItem = [[UIBarButtonItem alloc] initWithCustomView:detailButton];
    //    [self.navigationBarItem setLeftBarButtonItems:[NSArray arrayWithObjects: notificationItem, detailItem,nil]];
    
    UIButton *shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [shareButton setImage:[UIImage imageNamed:@"home_icon_letter"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(sentMessage) forControlEvents:UIControlEventTouchUpInside];
    shareButton.frame = CGRectMake(SCREEN_WIDTH - 98, topSafeMargin, 44, 44);
    //    shareButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.naviBGView addSubview:shareButton];
    
    UIButton *setButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [setButton setImage:[UIImage imageNamed:@"mine_share"] forState:UIControlStateNormal];
    [setButton addTarget:self action:@selector(shareButton:) forControlEvents:UIControlEventTouchUpInside];
    setButton.frame = CGRectMake(SCREEN_WIDTH -54, topSafeMargin, 44, 44);
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

- (void)sentMessage {
    MineMessageViewController *message = [[MineMessageViewController alloc] init];
    message.taid = self.userModel.uid;
    [self.navigationController pushViewController:message animated:YES];
}

- (void)detailButton:(UIButton *)button {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:backView];
    
    MineDetailView *birdView = [[MineDetailView alloc] initWithFrame:CGRectMake(AutoSize6(80), AutoSize6(260), SCREEN_WIDTH - AutoSize6(160), SCREEN_HEIGHT - AutoSize6(260) - kTabBarHeight - AutoSize6(150))];
    birdView.backView = backView;
    birdView.name = self.userModel.username;
    birdView.grade = self.userModel.level;
    birdView.head = self.userModel.head;
    birdView.userModel = self.userModel;
    [[UIApplication sharedApplication].keyWindow addSubview:birdView];
}

- (void)shareButton:(UIButton *)button {
    [AppShareManager shareWithTitle:[UserPage sharedInstance].userModel.shareTitle summary:[UserPage sharedInstance].userModel.shareSummary url:[UserPage sharedInstance].userModel.shareUrl image:[UserPage sharedInstance].userModel.shareImg];
}



- (void)didReceiveMemoryWarning {
    //停止下载所有图片
    [[SDWebImageManager sharedManager] cancelAll];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];

    //清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
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
