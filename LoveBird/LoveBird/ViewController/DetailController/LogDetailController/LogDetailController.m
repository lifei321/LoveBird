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
#import <MJRefresh/MJRefresh.h>
#import "LogDetailTalkModel.h"
#import "LogDeatilTalkCell.h"
#import "LogDetailHeadCell.h"


@interface LogDetailController ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) LogDetailModel *detailModel;


@property (nonatomic, strong) LogDetailHeadView *headerView;

@property (nonatomic, strong) UIView *footerView;


@property (nonatomic, assign) NSInteger page;


@property (nonatomic, strong) NSMutableArray *dataArray;

// 评论总数
@property (nonatomic, copy) NSString *count;

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
    [self netForTalkList];
}

#pragma mark-- tabelView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return self.detailModel.postBody.count;
    }
    
    if (section == 2) { // 头像列表
        return 1;
    }
    
    if (section == 3) {
        return self.dataArray.count;
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
    } else if (section == 2) {
        
        LogDetailHeadCell *birdcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogDetailHeadCell class]) forIndexPath:indexPath];
        birdcell.count = self.count;
        birdcell.dataArray = self.dataArray;
        cell = birdcell;

    } else if (section == 3) {
        LogDeatilTalkCell *birdcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogDeatilTalkCell class]) forIndexPath:indexPath];
        if (self.dataArray.count > row) {
            birdcell.bodyModel = self.dataArray[row];
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
    
    if (section == 2) {
        if (self.dataArray.count) {
            return AutoSize6(138);
        }
    }
    
    if (section == 3) {
        if (self.dataArray.count) {
            return [LogDeatilTalkCell getHeightWithModel:self.dataArray[row]];
        }
    }
    
    return AutoSize6(0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
//        if (self.detailModel.birdInfo.count || self.detailModel.publishTime.length || self.detailModel.locale.length) {
//        }
        return 0.01f;
    }
    
    if (section == 3) {
        if (self.dataArray.count) {
            return AutoSize6(60);
        }
    }
    return AutoSize6(20);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(60))];
        backView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(35), AutoSize6(400), AutoSize6(25))];
        label1.text = [NSString stringWithFormat:@"已有%@人评论过", self.count];
        label1.textAlignment = NSTextAlignmentLeft;
        label1.textColor = kColorTextColorLightGraya2a2a2;
        label1.font = kFont6(22);
        [backView addSubview:label1];
        return backView;
        
    }
    
    return [[UIView alloc] init];
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


- (void)netForTalkList {
    @weakify(self);
    [DetailDao getLogDetail:self.tid page:[NSString stringWithFormat:@"%ld", self.page] successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
        self.page ++;
        
        LogDetailTalkDataModel *dataModel = (LogDetailTalkDataModel *)responseObject;
        self.count = dataModel.count;
        if (dataModel.commentList.count) {
            [self.dataArray addObjectsFromArray: dataModel.commentList];
        } else {
            [self.tableView.mj_footer removeFromSuperview];
            self.tableView.tableFooterView = self.footerView;
        }
        
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
        [self.tableView.mj_footer endRefreshing];

    }];
}

#pragma mark--- UI

- (void)setNavigation {
    
    self.title = @"日志详情";
    self.rightButton.title = @"操作";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    
    self.page = 1;
    self.dataArray = [NSMutableArray new];
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
    [self.tableView registerClass:[LogDeatilTalkCell class] forCellReuseIdentifier:NSStringFromClass([LogDeatilTalkCell class])];
    [self.tableView registerClass:[LogDetailHeadCell class] forCellReuseIdentifier:NSStringFromClass([LogDetailHeadCell class])];

    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForTalkList)];
}

- (LogDetailHeadView *)headerView {
    if (!_headerView) {
        _headerView = [[LogDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(300))];
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(400))];
        _footerView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(100), AutoSize6(78), AutoSize6(174), AutoSize6(115))];
        icon.image = [UIImage imageNamed:@"detail_no_talk"];
        icon.contentMode = UIViewContentModeCenter;
        [_footerView addSubview:icon];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(icon.right + AutoSize6(15), AutoSize6(78), AutoSize6(400), AutoSize6(50))];
        label1.text = @"抢沙发的机会只有一次，";
        label1.textAlignment = NSTextAlignmentLeft;
        label1.textColor = kColorTextColorLightGraya2a2a2;
        label1.font = kFont6(30);
        [_footerView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(icon.right + AutoSize6(15), label1.bottom + AutoSize6(10), AutoSize6(400), AutoSize6(50))];
        label2.text = @"你还在等什么?";
        label2.textAlignment = NSTextAlignmentLeft;
        label2.textColor = kColorTextColorLightGraya2a2a2;
        label2.font = kFont6(30);
        [_footerView addSubview:label2];
    }
    return _footerView;
}

@end
