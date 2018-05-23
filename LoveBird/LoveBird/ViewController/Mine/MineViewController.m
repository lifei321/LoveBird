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
#import <HMSegmentedControl/HMSegmentedControl.h>
#import "MineLogViewController.h"

@interface MineViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic, strong) HMSegmentedControl *segmented;
@property (nonatomic, strong) UIPageViewController *pageVC;
@property (nonatomic, assign) NSInteger currentSelectIndex;
@property (nonatomic, strong) NSArray <UIViewController *> *VCArray;


@property (nonatomic, strong) MineHeaderView *headerView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;
    
    [self setData];
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

- (void)netForLog {
    
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

#pragma mark - UIPageViewControllerDelegate
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.VCArray indexOfObject:viewController];
    if(index == 0 || index == NSNotFound) {
        return nil;
    }
    return (UIViewController *)[self.VCArray objectAtIndex:index - 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.VCArray indexOfObject:viewController];
    if(index == NSNotFound || index == self.VCArray.count - 1) {
        return nil;
    }
    return (UIViewController *)[self.VCArray objectAtIndex:index + 1];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(nonnull NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *viewController = self.pageVC.viewControllers[0];
    NSUInteger index = [self.VCArray indexOfObject:viewController];
    self.currentSelectIndex = index;
    [self.segmented setSelectedSegmentIndex:index animated:YES];
}

- (void)segmentedControlChangedValue:(UISegmentedControl *)segment {
    long index = segment.selectedSegmentIndex;
    [self navigationDidSelectedControllerIndex:index];
}

- (void)navigationDidSelectedControllerIndex:(NSInteger)index {
    if (index == 0) {
        [self.pageVC setViewControllers:@[[self.VCArray objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    }
    else {
        [self.pageVC setViewControllers:@[[self.VCArray objectAtIndex:index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
}


#pragma mark-- UI

- (void)setData {
    
    MineLogViewController *logVC = [[MineLogViewController alloc] init];
    
    self.VCArray = @[logVC, logVC, logVC, logVC, logVC];
}


- (void)setTableView {
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight);
    
    MineHeaderView *headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(612))];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH - kTabBarHeight - self.headerView.height)];
    footerView.backgroundColor = [UIColor whiteColor];
    self.segmented.sectionTitles = @[@"日志", @"收藏", @"鸟种", @"相册", @"朋友圈"];
    [footerView addSubview:self.segmented];

    [self.pageVC setViewControllers:@[self.VCArray.firstObject] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    self.pageVC.view.frame = CGRectMake(0, self.segmented.bottom, SCREEN_WIDTH, footerView.height - self.segmented.height);
    [self addChildViewController:self.pageVC];
    [footerView addSubview:self.pageVC.view];
    
    self.tableView.tableFooterView = footerView;
}

- (UIPageViewController *)pageVC {
    if (!_pageVC) {
        NSDictionary *options = @{UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationMin)};
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                options:options];
        _pageVC.delegate = self;
        _pageVC.dataSource = self;
    }
    return _pageVC;
}

- (HMSegmentedControl *)segmented {
    if (!_segmented) {
        _segmented = [[HMSegmentedControl alloc] init];
        _segmented.selectionIndicatorHeight = 4.0f;
        _segmented.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _segmented.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _segmented.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor greenColor]};
        _currentSelectIndex = 0;
        _segmented.selectedSegmentIndex = _currentSelectIndex;
        _segmented.frame = CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(142));
        [_segmented addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmented;
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
