//
//  MatchDetailController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MatchDetailController.h"
#import "MatchDetailHeaderView.h"
#import "DiscoverDao.h"
#import "MatchDetailModel.h"
#import "WorksViewController.h"
#import "PublishViewController.h"


#import "JXPagerView.h"
#import "JXCategoryView.h"
#import "TestListBaseView.h"
#import "JXPagerListRefreshView.h"
#import "JXCategoryTitleImageView.h"

#import "MatchDetailNoteTableView.h"
#import "UserPhotoTbleView.h"

#define JXheightForHeaderInSection AutoSize6(142)


@interface MatchDetailController ()<JXPagerViewDelegate, JXCategoryViewDelegate>

@property (nonatomic, strong) MatchDetailHeaderView *headerView;

@property (nonatomic, strong) JXPagerView *pagerView;

@property (nonatomic, strong) JXCategoryTitleImageView *categoryView;

@property (nonatomic, strong) NSArray <TestListBaseView *> *listViewArray;

@property (nonatomic, strong) UIView *naviBGView;



@end

@implementation MatchDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    
    [self setHeadForView];
    
    [self creatTouGao];
    
    [self setNavigation];
    
//    [self netForDetaiModel];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = false;
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [[SDWebImageManager sharedManager].imageCache clearMemory];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[SDImageCache sharedImageCache].config setShouldDecompressImages :NO];
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[SDImageCache sharedImageCache].config setShouldDecompressImages :YES];
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:YES];

}

- (void)setDetailModel:(MatchDetailModel *)detailModel {
    _detailModel = detailModel;
    
    MatchDetailHeaderView *headerView = [[MatchDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    headerView.detailModel = detailModel;
    CGFloat headerHeight = [headerView getHeight];
    headerView.height = headerHeight;
    self.headerView = headerView;

}

//- (void)netForDetaiModel {
//    [AppBaseHud showHudWithLoding:self.view];
//
//    @weakify(self);
//    [DiscoverDao getMatchDetail:self.matchid SuccessBlock:^(__kindof AppBaseModel *responseObject) {
//        @strongify(self);
//        [AppBaseHud hideHud:self.view];
//
//        MatchDetailHeaderView *headerView = [[MatchDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
//        headerView.detailModel = responseObject;
//        CGFloat headerHeight = [headerView getHeight];
//        headerView.height = headerHeight;
//        self.headerView = headerView;
//
//        [self.pagerView reloadData];
//        [self.categoryView reloadDatas];
//    } failureBlock:^(__kindof AppBaseModel *error) {
//        @strongify(self);
//        [AppBaseHud showHudWithfail:error.errstr view:self.view];
//
//        [self setNavigation];
//
//    }];
//}


- (void)setNavigation {
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = false;

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
    
    self.pagerView.mainTableView.clipsToBounds = false;

}

- (void)creatTouGao {
    // 投稿
    UIButton *tougaoButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(180), SCREEN_HEIGHT - AutoSize6(300), AutoSize6(120), AutoSize6(120))];
    [tougaoButton setTitle:@"投稿" forState:UIControlStateNormal];
    [tougaoButton setTitle:@"投稿" forState:UIControlStateSelected];
    tougaoButton.titleLabel.font = kFont6(37);
    [tougaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tougaoButton.backgroundColor = UIColorFromRGB(0xf7b03d);
    tougaoButton.layer.cornerRadius = tougaoButton.width / 2;
    [tougaoButton addTarget:self action:@selector(tougaoButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tougaoButton];
    [self.view bringSubviewToFront:tougaoButton];
}

- (void)tougaoButtonDidClick {
    PublishViewController *publishvc = [[PublishViewController alloc] init];
    publishvc.matchid = self.matchid;
    [self.navigationController pushViewController:publishvc animated:YES];
}

- (void)leftButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setHeadForView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    
    UserPhotoTbleView *partnerListView = [[UserPhotoTbleView alloc] init];
    partnerListView.authorId = @"";
    partnerListView.matchId = self.matchid;
    
    MatchDetailNoteTableView *notevc = [[MatchDetailNoteTableView alloc] init];
    notevc.matchid = self.matchid;
    
    _listViewArray = @[partnerListView, notevc];
    
    _categoryView = [[JXCategoryTitleImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
    self.categoryView.titles = @[@"作品", @"记录"];
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = kColorDefaultColor;
    self.categoryView.titleColor = UIColorFromRGB(0x7f7f7f);
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.imageNames = @[@"mine_header_picture_no", @"mine_header_log_no"];
    self.categoryView.selectedImageNames = @[@"mine_header_picture_yes", @"mine_header_log_yes"];
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


#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.headerView;
}

- (CGFloat)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return [self.headerView getHeight];
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

- (void)didReceiveMemoryWarning {
    //停止下载所有图片
    [[SDWebImageManager sharedManager] cancelAll];
    
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    
    //清除内存中的图片
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}








@end
