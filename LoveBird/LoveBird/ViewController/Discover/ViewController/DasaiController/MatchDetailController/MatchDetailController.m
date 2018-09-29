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
#import "MatchDetaiNoteViewController.h"
#import <SPPageMenu/SPPageMenu.h>
#import "PublishViewController.h"


#import "JXPagerView.h"
#import "JXCategoryView.h"
#import "TestListBaseView.h"
#import "JXPagerListRefreshView.h"
#import "JXCategoryTitleImageView.h"


#import "MatchNoteTableView.h"


//612
//#define JXTableHeaderViewHeight  AutoSize6(470)

#define JXheightForHeaderInSection AutoSize6(142)


#define kHeight (- 36)


#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define pageMenuH AutoSize6(80)

@interface MatchDetailController ()<SPPageMenuDelegate, UIScrollViewDelegate, JXPagerViewDelegate, JXCategoryViewDelegate>

@property (nonatomic, strong) MatchDetailHeaderView *headerView;

@property (nonatomic, strong) NSArray *dataArr;



@property (nonatomic, strong) JXPagerView *pagerView;

@property (nonatomic, strong) JXCategoryTitleImageView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) NSArray <TestListBaseView *> *listViewArray;



@end

@implementation MatchDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;
    [self setHeadForView];

    [self netForDetaiModel];
    self.tableView.frame = CGRectMake(0, kHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kHeight);
    self.tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;
    [self setNavigation];
}



- (void)netForDetaiModel {
    [AppBaseHud showHudWithLoding:self.view];
    
    @weakify(self);
    [DiscoverDao getMatchDetail:self.matchid SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];

        self.headerView.detailModel = (MatchDetailModel *)responseObject;
        self.headerView.matchid = self.matchid;
        self.headerView.height = [self.headerView getHeight];
        [self.categoryView reloadDatas];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}





        
//        WorksViewController * workvc = [[WorksViewController alloc] init];
//        workvc.from = @"dasai";
//        workvc.matchid = self.matchid;
//        [self addChildViewController:workvc];




- (void)setNavigation {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    UIButton *detailButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [detailButton setImage:[UIImage imageNamed:@"nav_back_black"] forState:UIControlStateNormal];
    [detailButton addTarget:self action:@selector(detailButton) forControlEvents:UIControlEventTouchUpInside];
    detailButton.frame = CGRectMake(0, 0, 15, 10);
    detailButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
    UIBarButtonItem *detailItem = [[UIBarButtonItem alloc] initWithCustomView:detailButton];
    [self.navigationBarItem setLeftBarButtonItems:[NSArray arrayWithObjects:detailItem,nil]];
    
    
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

- (void)detailButton {
    [self.navigationController popViewControllerAnimated:YES];
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
//    self.naviBGView.alpha = 1 - percent;
    
    
}


- (void)getTitlesWithInfo {
    
    _titles = @[@"作品", @"记录"];
    self.categoryView.titles = self.titles;
}

- (void)setHeadForView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = false;
    
    [self getTitlesWithInfo];
    
    MatchDetailHeaderView *headerView = [[MatchDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(500))];
    self.headerView = headerView;
    
    MatchNoteTableView *powerListView = [[MatchNoteTableView alloc] init];
    powerListView.matchid = self.matchid;
    
    MatchNoteTableView *powerListView2 = [[MatchNoteTableView alloc] init];
    powerListView.matchid = self.matchid;
    
    _listViewArray = @[powerListView, powerListView2];
    
    _categoryView = [[JXCategoryTitleImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, JXheightForHeaderInSection)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = kColorDefaultColor;
    self.categoryView.titleColor = UIColorFromRGB(0x7f7f7f);
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.cellWidthZoomEnabled = NO;
    self.categoryView.titleFont = kFontPF6(30);
    
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


@end
