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
#import "LogDetailBirdCell.h"
#import "LogContentCell.h"

@interface LogDetailController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) LogDetailModel *detailModel;


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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return self.detailModel.postBody.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    UITableViewCell *cell;
    if (section == 0) {
        LogDetailBirdCell *birdcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogDetailBirdCell class]) forIndexPath:indexPath];
        if (row == 0) {
            birdcell.birdArray = self.detailModel.birdInfo;
        } else if (row == 1) {
            birdcell.location = self.detailModel.locale;
        } else if (row == 2) {
            birdcell.time = [[AppDateManager shareManager] getDateWithTime:self.detailModel.publishTime formatSytle:DateFormatYMD];
        }
        cell = birdcell;
    } else if (section == 1) {
        LogContentCell *birdcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogContentCell class]) forIndexPath:indexPath];
        if (self.detailModel.postBody.count > row) {
            birdcell.bodyModel = self.detailModel.postBody[row];
        }
        cell = birdcell;
    }

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        if (row == 0) {
            return self.detailModel.birdInfo.count ? AutoSize6(94) : 0.0f;
        }
        
        if (row == 1) {
            return self.detailModel.locale.length ? AutoSize6(94) : 0.0f;
        }
        
        if (row == 2) {
            return self.detailModel.publishTime.length ? AutoSize6(94) : 0.0f;
        }
    }

    if (section == 1) {
        if (self.detailModel.postBody.count > row) {
            return [LogContentCell getHeightWithModel:self.detailModel.postBody[row]];
        }
    }
    
    return AutoSize6(0);
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

        self.detailModel = detailModel;
        [self.tableView reloadData];
        
        
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
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LogDetailBirdCell class] forCellReuseIdentifier:NSStringFromClass([LogDetailBirdCell class])];
    [self.tableView registerClass:[LogContentCell class] forCellReuseIdentifier:NSStringFromClass([LogContentCell class])];

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
