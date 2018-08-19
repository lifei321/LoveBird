//
//  MineLogViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/23.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineLogViewController.h"
#import "UserDao.h"
#import "ShequModel.h"
#import "MineLogFrameModel.h"
#import "MineLogCell.h"
#import "MJRefresh.h"
#import "LogDetailController.h"
#import "CaogaoViewController.h"

@interface MineLogViewController ()<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString * count;

@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, assign) NSInteger page;

@end

@implementation MineLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify) name:kLoginSuccessNotification object:nil];

    [self setTableView];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
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
    [UserDao userLogList:self.page matchId:self.matchid fid:self.taid successBlock:^(__kindof AppBaseModel *responseObject) {
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
        if (!self.taid.length) {
            self.tableView.tableHeaderView = [self makeHeaderView];
        }

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
    MineLogCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineLogCell class]) forIndexPath:indexPath];
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
    
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[MineLogCell class] forCellReuseIdentifier:NSStringFromClass([MineLogCell class])];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(30))];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForLogHeader)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForLog)];
}

- (UIView *)makeHeaderView {
    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(70))];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, AutoSize6(30), SCREEN_WIDTH, AutoSize6(40))];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel = tipLabel;
    tipLabel.userInteractionEnabled = YES;
    [tipLabel addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipLabelDidClick)]];
    
    NSString *placeString = self.count;
    NSString *textString = [NSString stringWithFormat:@"您还有%@篇草稿没有完成 ->", placeString];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textString];
    [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColor7f7f7f range:NSMakeRange(0, 3)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, placeString.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColor7f7f7f range:NSMakeRange(3 + placeString.length, 10)];

    [attrString addAttribute:NSFontAttributeName value:kFont6(24) range:NSMakeRange(0, textString.length)];
    tipLabel.attributedText = attrString;
    [headview addSubview:tipLabel];
    
    return headview;
}

- (void)tipLabelDidClick {
    CaogaoViewController *caogaovc = [[CaogaoViewController alloc] init];
    [[UIViewController currentViewController].navigationController pushViewController:caogaovc animated:YES];
}

@end
