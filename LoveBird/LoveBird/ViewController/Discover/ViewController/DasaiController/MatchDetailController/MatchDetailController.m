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

#define kHeight (- 36)


#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define pageMenuH AutoSize6(80)

@interface MatchDetailController ()<SPPageMenuDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) MatchDetailHeaderView *headerView;


@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) SPPageMenu *pageMenu;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;


@end

@implementation MatchDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;
    
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)netForDetaiModel {
    [AppBaseHud showHudWithLoding:self.view];
    
    @weakify(self);
    [DiscoverDao getMatchDetail:self.matchid SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];

        self.tableView.tableHeaderView = self.headerView;
        self.headerView.detailModel = (MatchDetailModel *)responseObject;
        self.headerView.matchid = self.matchid;
        self.headerView.height = [self.headerView getHeight];
        self.tableView.tableFooterView = self.footerView;
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (void)selectButtonClick:(UIButton *)button {
    NSInteger tag = button.tag;
    if (tag == 100) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    } else if (tag == 200) {
        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    }
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    
    // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
    if (labs(toIndex - fromIndex) >= 2) {
        [self.scrollView setContentOffset:CGPointMake(screenW * toIndex, 0) animated:NO];
    } else {
        [self.scrollView setContentOffset:CGPointMake(screenW * toIndex, 0) animated:YES];
    }
    if (self.myChildViewControllers.count <= toIndex) {return;}
    
    UIViewController *targetViewController = self.myChildViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    
    targetViewController.view.left = screenW * toIndex;
    [_scrollView addSubview:targetViewController.view];
    
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.height - self.headerView.height + kHeight)];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, AutoSize6(10), SCREEN_WIDTH, 0.5)];
        line.backgroundColor = kLineColoreDefaultd4d7dd;
        [_footerView addSubview:line];
        
        self.dataArr = @[@"作品", @"记录"];

        // trackerStyle:跟踪器的样式
        SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, line.bottom, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLine];
        // 传递数组，默认选中第2个
        [pageMenu setItems:self.dataArr selectedItemIndex:0];
        
        // 不可滑动的自适应内容排列
        pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
        pageMenu.selectedItemTitleColor = [UIColor blackColor];
        pageMenu.dividingLineHeight = 0;
        pageMenu.tracker.backgroundColor = kColorDefaultColor;
        
        // 设置代理
        pageMenu.delegate = self;
        [_footerView addSubview:pageMenu];
        _pageMenu = pageMenu;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, pageMenu.bottom, screenW, _footerView.height - pageMenu.bottom)];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        [_footerView addSubview:scrollView];
        _scrollView = scrollView;
        
        // 这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
        self.pageMenu.bridgeScrollView = self.scrollView;
        
        WorksViewController * workvc = [[WorksViewController alloc] init];
        workvc.from = @"dasai";
        workvc.matchid = self.matchid;
        [self addChildViewController:workvc];
        
        MatchDetaiNoteViewController *notevc = [[MatchDetaiNoteViewController alloc] init];
        notevc.matchid = self.matchid;
        [self addChildViewController:notevc];

        [self.myChildViewControllers addObject:workvc];
        [self.myChildViewControllers addObject:notevc];
        
        if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
            AppBaseViewController *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
            [scrollView addSubview:baseVc.view];
            baseVc.view.frame = CGRectMake(screenW*self.pageMenu.selectedItemIndex, 0, screenW, scrollView.height);
            scrollView.contentOffset = CGPointMake(screenW*self.pageMenu.selectedItemIndex, 0);
            scrollView.contentSize = CGSizeMake(self.dataArr.count*screenW, 0);
        }
        
    }
    return _footerView;
}
- (NSMutableArray *)myChildViewControllers {
    
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
        
    }
    return _myChildViewControllers;
}

- (MatchDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MatchDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    
    return _headerView;
}

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



//UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, AutoSize6(10), SCREEN_WIDTH, AutoSize6(80))];
//bottomView.backgroundColor = [UIColor whiteColor];
//[_footerView addSubview:bottomView];
//
//UIButton *workButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, bottomView.height)];
//[workButton setTitle:@"作品" forState:UIControlStateNormal];
//workButton.titleLabel.font = kFont6(32);
//[workButton setTitleColor:kColorTextColor333333 forState:UIControlStateNormal];
//workButton.tag = 100;
//[workButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//[bottomView addSubview:workButton];
//
//UIButton *noteButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, bottomView.height)];
//[noteButton setTitle:@"记录" forState:UIControlStateNormal];
//noteButton.titleLabel.font = kFont6(32);
//[noteButton setTitleColor:kColorTextColor333333 forState:UIControlStateNormal];
//noteButton.tag = 200;
//[noteButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//[bottomView addSubview:noteButton];
//
//UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, bottomView.height, SCREEN_WIDTH, _footerView.height)];
//scrollview.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
//[_footerView addSubview:scrollview];
//scrollview.bounces = NO;
//scrollview.pagingEnabled = YES;
//scrollview.showsVerticalScrollIndicator = NO;
//scrollview.showsHorizontalScrollIndicator = NO;
//scrollview.backgroundColor = [UIColor orangeColor];
//self.scrollView = scrollview;
//
//
//WorksViewController * workvc = [[WorksViewController alloc] init];
//workvc.from = @"dasai";
//workvc.matchid = self.matchid;
//[self addChildViewController:workvc];
//workvc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, scrollview.height);
//[scrollview addSubview:workvc.view];
//
//MatchNoteViewController *notevc = [[MatchNoteViewController alloc] init];
//[self addChildViewController:notevc];
//notevc.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, scrollview.height);
//[scrollview addSubview:notevc.view];
@end
