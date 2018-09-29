//
//  LogTableView.m
//  LoveBird
//
//  Created by cheli shan on 2018/9/14.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogTableView.h"
#import "MJRefresh.h"
#import "UserDao.h"
#import "ShequModel.h"
#import "MineLogFrameModel.h"
#import "MineLogCell.h"
#import "LogDetailController.h"
#import "CaogaoViewController.h"
#import <SDWebImage/SDImageCache.h>

@interface LogTableView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;


@property (nonatomic, copy) NSString * count;

@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, assign) NSInteger page;

@end


@implementation LogTableView

- (void)dealloc
{
    self.scrollCallback = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableFooterView = [UIView new];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerClass:[MineLogCell class] forCellReuseIdentifier:NSStringFromClass([MineLogCell class])];
        
        if (@available(iOS 11.0, *)) {
            UITableView.appearance.estimatedRowHeight = 0;
            UITableView.appearance.estimatedSectionFooterHeight = 0;
            UITableView.appearance.estimatedSectionHeaderHeight = 0;
        }
        [self addSubview:self.tableView];
        self.isNeedFooter = YES;
        self.isNeedHeader = YES;
    }
    return self;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
    [self.tableView reloadData];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview != nil) {
        if (self.isNeedHeader) {
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForLogHeader)];
        }
        
        if (self.isNeedFooter) {
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForLog)];
        }
    }
    [self.tableView.mj_header beginRefreshing];
}

- (void)selectCellAtIndexPath:(NSIndexPath *)indexPath {
    if (self.lastSelectedIndexPath == indexPath) {
        return;
    }
    if (self.lastSelectedIndexPath != nil) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.lastSelectedIndexPath];
        [cell setSelected:NO animated:NO];
    }
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES animated:NO];
    self.lastSelectedIndexPath = indexPath;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
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
        [[UIViewController currentViewController].navigationController pushViewController:detailController animated:YES];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollCallback(scrollView);
}

#pragma mark - JXPagingViewListViewDelegate

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}


- (void)netForLogHeader {
    self.page = 1;
    [self netForLog];
}

- (void)netForLog {

    @weakify(self);
    [UserDao userLogList:self.page matchId:self.matchid fid:self.taid successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
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
            frameModel.isFirst = NO;
            frameModel.shequModel = model;
            [self.dataArray addObject:frameModel];
        }
        
        MineLogFrameModel *logframeModel = self.dataArray.firstObject;
        logframeModel.isFirst = YES;
        
        self.count = dataModel.draftNum;
        if (!self.taid.length) {
            self.tableView.tableHeaderView = [self makeHeaderView];
        }
        
        
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.tableView];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
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
