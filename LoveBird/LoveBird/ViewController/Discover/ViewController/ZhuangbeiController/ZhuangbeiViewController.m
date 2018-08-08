//
//  ZhuangbeiViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ZhuangbeiViewController.h"
#import "TimeLineCell.h"
#import "AppHttpManager.h"
#import "MJRefresh.h"
#import "DiscoverDao.h"
#import "ZhuangbeiModel.h"
#import "LogDetailController.h"

@interface ZhuangbeiViewController ()<UITableViewDelegate, UITableViewDataSource, TimeLineClickDelegate>

// 刷新页数
@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation ZhuangbeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNum = 0;
    
    _dataArray = [NSMutableArray new];
    
    [self setNavigation];
    
    // 设置UI
    [self setTableView];
    
    if (self.cid.length) {
        [self netForContentHeader];
        
        //默认【下拉刷新】
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForContentHeader)];
        //默认【上拉加载】
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForContentFooter)];
    } else {
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(200))];
    }
}

- (void)netForContentHeader {
    self.pageNum = 1;
    
    [self netForContentWithPageNum:self.pageNum header:YES];
}
- (void)netForContentFooter {
    self.pageNum ++;
    [self netForContentWithPageNum:self.pageNum header:NO];
}
- (void)netForContentWithPageNum:(NSInteger)pageNum header:(BOOL)header {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"page" forKey:[NSString stringWithFormat:@"%ld", (long)pageNum]];
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [DiscoverDao getWordList:self.cid successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        if (header) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        [AppBaseHud hideHud:self.view];
        ZhuangbeiDataModel *dataModel = (ZhuangbeiDataModel *)responseObject;
        if (header) {
            [self.dataArray removeAllObjects];
        }
        
        for (ZhuangbeiModel *model in dataModel.data) {
            TimeLineLayoutModel *lineModel = [[TimeLineLayoutModel alloc] init];
            lineModel.zhuangbeiModel = model;
            [self.dataArray addObject:lineModel];
        }
        [self.tableView reloadData];
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        if (header) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (void)setWord:(NSString *)word {
    _word = [word copy];
    [self netForData];
}

- (void)netForData {

    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [DiscoverDao getZZList:self.word successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        ZhuangbeiDataModel *dataModel = (ZhuangbeiDataModel *)responseObject;
        
        [self.dataArray removeAllObjects];
        for (ZhuangbeiModel *model in dataModel.data) {
            TimeLineLayoutModel *lineModel = [[TimeLineLayoutModel alloc] init];
            lineModel.zhuangbeiModel = model;
            [self.dataArray addObject:lineModel];
        }
        [self.tableView reloadData];
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TimeLineCell class]) forIndexPath:indexPath];
    
    cell.cellLayoutModel = self.dataArray[indexPath.row];
    cell.timeLineCellDelegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimeLineLayoutModel *layoutModel = self.dataArray[indexPath.row];
    return layoutModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TimeLineLayoutModel *cellLayoutModel = self.dataArray[indexPath.row];
    LogDetailController *detailvc = [[LogDetailController alloc] init];
    detailvc.aid = cellLayoutModel.zhuangbeiModel.aid;
    [[UIViewController currentViewController].navigationController pushViewController:detailvc animated:YES];
}

#pragma mark-- cell点击代理
- (void)timeLine:(TimeLineCell *)timeLineCell didClickDelegate:(UIButton *)button {
    
    NSInteger tag = button.tag;
    if (tag == 100) { // 转发
        
    } else if (tag == 200) { // 收藏
        [UserDao userCollect:timeLineCell.cellLayoutModel.zhuangbeiModel.aid successBlock:^(__kindof AppBaseModel *responseObject) {
            button.selected = !button.selected;
        } failureBlock:^(__kindof AppBaseModel *error) {
            [AppBaseHud showHudWithfail:error.errstr view:self.view];
        }];
    } else if (tag == 300) { // 评论
        
    } else if (tag == 400) { // 点赞
        if (button.selected) {
            [AppBaseHud showHudWithfail:@"已赞" view:self.view];
            return;
        }

        [UserDao userUp:timeLineCell.cellLayoutModel.zhuangbeiModel.aid successBlock:^(__kindof AppBaseModel *responseObject) {
            button.selected = !button.selected;
            [AppBaseHud showHudWithSuccessful:@"点赞成功" view:self.view];

        } failureBlock:^(__kindof AppBaseModel *error) {
            [AppBaseHud showHudWithfail:error.errstr view:self.view];
        }];
    }
}

- (void)setNavigation {
    
    if ([self.cid isEqualToString:@"1"]) {
        self.title = @"装备";
    } else if ([self.cid isEqualToString:@"2"]){
        self.title = @"资讯";
    } else {
        
    }
}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TimeLineCell class] forCellReuseIdentifier:NSStringFromClass([TimeLineCell class])];

    
}

@end
