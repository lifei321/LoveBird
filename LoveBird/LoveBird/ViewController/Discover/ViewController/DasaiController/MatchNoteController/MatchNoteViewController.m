//
//  MatchNoteViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/10.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MatchNoteViewController.h"
#import "MineLogViewController.h"
#import "WorksViewController.h"
#import "MineBirdViewController.h"
#import <SPPageMenu/SPPageMenu.h>

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define pageMenuH AutoSize6(90)
#define NaviH (screenH == 812 ? 88 : 64) // 812是iPhoneX的高度
#define scrollViewHeight (screenH - NaviH - pageMenuH)

@interface MatchNoteViewController ()<SPPageMenuDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, weak) SPPageMenu *pageMenu;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *myChildViewControllers;

@end

@implementation MatchNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的记录";

    self.dataArr = @[@"日志",@"鸟种",@"作品"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, NaviH, screenW, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLine];
    // 传递数组，默认选中第2个
    [pageMenu setItems:self.dataArr selectedItemIndex:0];
    // 不可滑动的自适应内容排列
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollAdaptContent;
    pageMenu.selectedItemTitleColor = [UIColor blackColor];
    pageMenu.dividingLineHeight = 0;
    pageMenu.tracker.backgroundColor = kColorDefaultColor;
    
    // 设置代理
    pageMenu.delegate = self;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NaviH + pageMenuH, screenW, scrollViewHeight)];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    // 这一行赋值，可实现pageMenu的跟踪器时刻跟随scrollView滑动的效果
    self.pageMenu.bridgeScrollView = self.scrollView;
    
    MineLogViewController *notevc = [[MineLogViewController alloc] init];
    notevc.matchid = self.matchid;
    [self addChildViewController:notevc];
    
    MineBirdViewController *birdController = [[MineBirdViewController alloc] init];
    birdController.matchid = self.matchid;
    [self addChildViewController:birdController];
    
    WorksViewController * workvc = [[WorksViewController alloc] init];
    workvc.from = @"dasai";
    workvc.matchid = self.matchid;
    workvc.authorId = [UserPage sharedInstance].uid;
    [self addChildViewController:workvc];
    [self.myChildViewControllers addObject:notevc];
    [self.myChildViewControllers addObject:birdController];
    [self.myChildViewControllers addObject:workvc];
    
    if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
        AppBaseViewController *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
        [scrollView addSubview:baseVc.view];
        baseVc.view.frame = CGRectMake(screenW*self.pageMenu.selectedItemIndex, 0, screenW, scrollViewHeight);
        scrollView.contentOffset = CGPointMake(screenW*self.pageMenu.selectedItemIndex, 0);
        scrollView.contentSize = CGSizeMake(self.dataArr.count*screenW, 0);
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
    
    targetViewController.view.frame = CGRectMake(screenW * toIndex, 0, screenW, scrollViewHeight);
    [_scrollView addSubview:targetViewController.view];
    
}


//- (void)selectButtonClick:(UIButton *)button {
//    NSInteger tag = button.tag;
//    if (tag == 100) {
//        self.scrollView.contentOffset = CGPointMake(0, 0);
//    } else if (tag == 200) {
//        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
//    } else if (tag == 300) {
//        self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * 2, 0);
//
//    }
//}

- (NSMutableArray *)myChildViewControllers {
    
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
        
    }
    return _myChildViewControllers;
}


//self.view.backgroundColor = [UIColor orangeColor];
//
//UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, AutoSize6(90))];
//bottomView.backgroundColor = [UIColor whiteColor];
//[self.view addSubview:bottomView];
//
//UIButton *logButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 3, bottomView.height)];
//[logButton setTitle:@"日志" forState:UIControlStateNormal];
//logButton.titleLabel.font = kFont6(32);
//[logButton setTitleColor:kColorTextColor333333 forState:UIControlStateNormal];
//logButton.tag = 100;
//[logButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//[bottomView addSubview:logButton];
//
//UIButton *noteButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3, 0, SCREEN_WIDTH / 3, bottomView.height)];
//[noteButton setTitle:@"鸟种" forState:UIControlStateNormal];
//noteButton.titleLabel.font = kFont6(32);
//[noteButton setTitleColor:kColorTextColor333333 forState:UIControlStateNormal];
//noteButton.tag = 200;
//[noteButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//[bottomView addSubview:noteButton];
//
//UIButton *workButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2 / 3, 0, SCREEN_WIDTH / 3, bottomView.height)];
//[workButton setTitle:@"作品" forState:UIControlStateNormal];
//workButton.titleLabel.font = kFont6(32);
//[workButton setTitleColor:kColorTextColor333333 forState:UIControlStateNormal];
//workButton.tag = 300;
//[workButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//[bottomView addSubview:workButton];
//
//UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, bottomView.height, SCREEN_WIDTH, self.view.height - bottomView.height)];
//scrollview.contentSize = CGSizeMake(SCREEN_WIDTH * 3, 0);
//[self.view addSubview:scrollview];
//
//scrollview.bounces = NO;
//scrollview.pagingEnabled = YES;
//scrollview.showsVerticalScrollIndicator = NO;
//scrollview.showsHorizontalScrollIndicator = NO;
//self.scrollView = scrollview;
//
//
//MineLogViewController *notevc = [[MineLogViewController alloc] init];
//[self addChildViewController:notevc];
//notevc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, scrollview.height);
//[scrollview addSubview:notevc.view];
//
//MineBirdViewController *birdController = [[MineBirdViewController alloc] init];
//[self addChildViewController:birdController];
//birdController.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, scrollview.height);
//[scrollview addSubview:birdController.view];
//
//WorksViewController * workvc = [[WorksViewController alloc] init];
//workvc.from = @"dasai";
//workvc.matchid = self.matchid;
//[self addChildViewController:workvc];
//workvc.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, scrollview.height);
//[scrollview addSubview:workvc.view];


@end
