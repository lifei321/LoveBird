//
//  BirdDetailLookController.m
//  LoveBird
//
//  Created by cheli shan on 2018/8/5.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailLookController.h"
#import "UserDao.h"
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify) name:kLoginSuccessNotification object:nil];
    
    [self setTableView];
    [self.tableView.mj_header beginRefreshing];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)notify {
    [self.tableView.mj_header beginRefreshing];
}

- (void)netForLogHeader {
    self.page = 1;
    [self netForLog];
}

- (void)netForLog {
    
    @weakify(self);
    [UserDao userLogList:self.page matchId:nil fid:nil successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        self.page ++;
        
        
        ShequLogModel *dataModel = (ShequLogModel *)responseObject;
        for (int i = 0; i < dataModel.articleList.count; i++) {
            ShequModel *model = dataModel.articleList[i];
            MineLogFrameModel *frameModel = [[MineLogFrameModel alloc] init];
            frameModel.isFirst = (i == 0) ? YES : NO;
            frameModel.shequModel = model;
            [self.dataArray addObject:frameModel];
        }
        self.count = dataModel.draftNum;
        
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
    
    if (layoutModel.shequModel.tid.length) {
        LogDetailController *detailController = [[LogDetailController alloc] init];
        detailController.tid = layoutModel.shequModel.tid;
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
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForLogHeader)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForLog)];
}

@end
