//
//  LogDetailController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogDetailController.h"
#import "DetailDao.h"
#import "LogDetailHeadView.h"

@interface LogDetailController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;


@property (nonatomic, strong) LogDetailHeadView *headerView;


@end

@implementation LogDetailController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableView];
    [self netForLogDetail];
}

#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RankTableViewCell class]) forIndexPath:indexPath];
//    cell.rankModel = self.dataArray[indexPath.row];
//    return cell;
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return AutoSize6(136);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)netForLogDetail {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [DetailDao getLogDetail:self.tid successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        
        LogDetailModel *detailModel = (LogDetailModel *)responseObject;
        
        self.tableView.tableHeaderView = self.headerView;
        self.headerView.detailModel = detailModel;
        self.headerView.height = [self.headerView getHeight];
        
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

#pragma mark--- UI

- (void)setNavigation {
    
    self.title = @"日志详情";
    self.rightButton.title = @"操作";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    
}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView registerClass:[TimeLineCell class] forCellReuseIdentifier:NSStringFromClass([TimeLineCell class])];
//    self.viewModel = [[DiscoverDataSource alloc] init];
    
    //默认【下拉刷新】
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForContentHeader)];
//    //默认【上拉加载】
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForContentFooter)];
}

- (LogDetailHeadView *)headerView {
    if (!_headerView) {
        _headerView = [[LogDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(300))];
    }
    return _headerView;
}

@end
