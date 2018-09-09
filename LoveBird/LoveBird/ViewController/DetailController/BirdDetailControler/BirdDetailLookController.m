//
//  BirdDetailLookController.m
//  LoveBird
//
//  Created by cheli shan on 2018/8/5.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailLookController.h"
#import "DetailDao.h"
#import "ShequModel.h"
#import "MineLogFrameModel.h"
#import "BirdLookTableViewCell.h"
#import "MJRefresh.h"
#import "LogDetailController.h"


@interface BirdDetailLookController () <UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString * count;

@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, assign) NSInteger page;

@end

@implementation BirdDetailLookController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"观鸟记录";
    _dataArray = [[NSMutableArray alloc] init];
    
    [self setTableView];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForLogHeader)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForLog)];
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)netForLogHeader {
    self.page = 1;
    [self netForLog];
}

- (void)netForLog {
    
    @weakify(self);
    [DetailDao getDetailLogPage:[NSString stringWithFormat:@"%ld", self.page]
                        cspCode:self.csp_code
                   successBlock:^(__kindof AppBaseModel *responseObject) {
                       @strongify(self);
                       [AppBaseHud hideHud:self.view];
                       
                       [self.tableView.mj_header endRefreshing];
                       [self.tableView.mj_footer endRefreshing];
                       
                       if (self.page == 1) {
                           [self.dataArray removeAllObjects];
                       }
                       self.page ++;

                       BirdDetailLogDataModel *dataModel = (BirdDetailLogDataModel *)responseObject;
                       for (BirdDetailLogModel *logmodel in dataModel.data) {
                           MineLogFrameModel *frameModel = [[MineLogFrameModel alloc] init];
                           frameModel.logModel = logmodel;
                           [self.dataArray addObject:frameModel];
                       }
                       MineLogFrameModel *logframemodel = self.dataArray.firstObject;
                       logframemodel.isFirst = YES;
                       
                       [self.tableView reloadData];

                   } failureBlock:^(__kindof AppBaseModel *error) {
                       @strongify(self);
                       [AppBaseHud showHudWithfail:error.errstr view:self.view];
                       [self.tableView.mj_header endRefreshing];
                       [self.tableView.mj_footer endRefreshing];
                   }];
    
}

#pragma mark-- tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BirdLookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BirdLookTableViewCell class]) forIndexPath:indexPath];
    MineLogFrameModel *model = self.dataArray[indexPath.row];
    cell.frameModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineLogFrameModel *model = self.dataArray[indexPath.row];
    return model.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MineLogFrameModel *layoutModel = self.dataArray[indexPath.row];
    
    if (layoutModel.logModel.tid.length) {
        LogDetailController *detailController = [[LogDetailController alloc] init];
        detailController.tid = layoutModel.logModel.tid;
        detailController.logType = 1;
        [self.navigationController pushViewController:detailController animated:YES];
    }
}

- (void)setTableView {
    
    self.tableView.frame = CGRectMake(0, total_topView_height, SCREEN_WIDTH, SCREEN_HEIGHT - total_topView_height);
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[BirdLookTableViewCell class] forCellReuseIdentifier:NSStringFromClass([BirdLookTableViewCell class])];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(30))];
    
    //默认【下拉刷新】
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForLogHeader)];
//    //默认【上拉加载】
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForLog)];
}

@end
