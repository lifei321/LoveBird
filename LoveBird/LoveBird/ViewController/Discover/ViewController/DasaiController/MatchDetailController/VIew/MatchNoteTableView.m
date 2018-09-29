//
//  MatchNoteTableView.m
//  LoveBird
//
//  Created by cheli shan on 2018/9/29.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MatchNoteTableView.h"
#import "MJRefresh.h"
#import "DiscoverDao.h"
#import "MatchArticleModel.h"
#import "MatchNoteCell.h"
#import "LogDetailController.h"
#import <SDWebImage/SDImageCache.h>


@interface MatchNoteTableView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;


@property (nonatomic, assign) NSInteger page;

@property (nonatomic, copy) NSString * count;

@property (nonatomic, strong) UILabel *countLabel;

@end


@implementation MatchNoteTableView

- (void)dealloc
{
    self.scrollCallback = nil;
}

#pragma mark-- tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MatchNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MatchNoteCell class]) forIndexPath:indexPath];
    MatchArticleModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize6(338);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AutoSize6(10);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MatchArticleModel *frameModel = self.dataArray[indexPath.row];
    if (frameModel.tid.length) {
        LogDetailController *detailController = [[LogDetailController alloc] init];
        detailController.tid = frameModel.tid;
        [[UIViewController currentViewController].navigationController pushViewController:detailController animated:YES];
    }
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
        [self.tableView registerClass:[MatchNoteCell class] forCellReuseIdentifier:NSStringFromClass([MatchNoteCell class])];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(30))];
        
        
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
    
    NSString *page = [NSString stringWithFormat:@"%ld", self.page] ;

    @weakify(self);
    [DiscoverDao getMatchArctleList:self.matchid page:page SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        self.page ++;
        
        MatchArticleDataModel *dataModel = (MatchArticleDataModel *)responseObject;
        
        [self.dataArray addObjectsFromArray:dataModel.data];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        [AppBaseHud showHudWithfail:error.errstr view:self.tableView];
    }];
}

@end
