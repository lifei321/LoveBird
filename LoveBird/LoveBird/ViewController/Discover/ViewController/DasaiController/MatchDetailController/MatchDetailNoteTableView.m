//
//  MatchDetailNoteTableView.m
//  LoveBird
//
//  Created by 十八子飞 on 2018/12/30.
//  Copyright © 2018 shancheli. All rights reserved.
//

#import "MatchDetailNoteTableView.h"
#import "DiscoverDao.h"
#import "MatchArticleModel.h"
#import "MatchNoteCell.h"
#import "LogDetailController.h"

@interface MatchDetailNoteTableView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;


@property (nonatomic, copy) NSString * count;

@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, assign) NSInteger page;

@end

@implementation MatchDetailNoteTableView

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
        [self.tableView registerClass:[MatchNoteCell class] forCellReuseIdentifier:NSStringFromClass([MatchNoteCell class])];
        [self addSubview:self.tableView];
        self.isNeedFooter = YES;
        self.isNeedHeader = YES;
        if (@available(iOS 11.0, *)) {
            UITableView.appearance.estimatedRowHeight = 0;
            UITableView.appearance.estimatedSectionFooterHeight = 0;
            UITableView.appearance.estimatedSectionHeaderHeight = 0;
        }
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
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForHeader)];
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

- (void)netForHeader {
    self.page = 1;
    [self netForLog];
}

- (void)netForLog {
    
    @weakify(self);
    [DiscoverDao getMatchArctleList:self.matchid page:self.page SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        [AppBaseHud hideHud:[UIViewController currentViewController].navigationController.topViewController.view];
        MatchArticleDataModel *dataModel = (MatchArticleDataModel *)responseObject;
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        self.page ++;
        
        [self.dataArray addObjectsFromArray:dataModel.data];
        
        if (dataModel.data.count) {
            [self.tableView reloadData];
        }
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [AppBaseHud showHudWithfail:error.errstr view:[UIViewController currentViewController].navigationController.topViewController.view];
    }];
}



@end
