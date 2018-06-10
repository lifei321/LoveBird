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
#import "MatchNoteViewController.h"

#define kHeight (- 36)


@interface MatchDetailController ()

@property (nonatomic, strong) MatchDetailHeaderView *headerView;


@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UIScrollView *scrollView;


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

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.height - self.headerView.height + kHeight)];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, AutoSize6(10), SCREEN_WIDTH, AutoSize6(80))];
        bottomView.backgroundColor = [UIColor whiteColor];
        [_footerView addSubview:bottomView];
        
        UIButton *workButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 2, bottomView.height)];
        [workButton setTitle:@"作品" forState:UIControlStateNormal];
        workButton.titleLabel.font = kFont6(32);
        [workButton setTitleColor:kColorTextColor333333 forState:UIControlStateNormal];
        workButton.tag = 100;
        [workButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:workButton];
        
        UIButton *noteButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, bottomView.height)];
        [noteButton setTitle:@"记录" forState:UIControlStateNormal];
        noteButton.titleLabel.font = kFont6(32);
        [noteButton setTitleColor:kColorTextColor333333 forState:UIControlStateNormal];
        noteButton.tag = 200;
        [noteButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:noteButton];
        
        UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, bottomView.height, SCREEN_WIDTH, _footerView.height)];
        scrollview.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
        [_footerView addSubview:scrollview];
        scrollview.bounces = NO;
        scrollview.pagingEnabled = YES;
        scrollview.showsVerticalScrollIndicator = NO;
        scrollview.showsHorizontalScrollIndicator = NO;
        scrollview.backgroundColor = [UIColor orangeColor];
        self.scrollView = scrollview;
        
        
        WorksViewController * workvc = [[WorksViewController alloc] init];
        workvc.from = @"dasai";
        workvc.matchid = self.matchid;
        [self addChildViewController:workvc];
        workvc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, scrollview.height);
        [scrollview addSubview:workvc.view];
        
        MatchNoteViewController *notevc = [[MatchNoteViewController alloc] init];
        [self addChildViewController:notevc];
        notevc.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, scrollview.height);
        [scrollview addSubview:notevc.view];
        
    }
    return _footerView;
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
}

- (void)detailButton {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
