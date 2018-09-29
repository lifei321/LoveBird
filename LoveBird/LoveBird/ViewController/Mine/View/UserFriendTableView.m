//
//  UserFriendTableView.m
//  LoveBird
//
//  Created by cheli shan on 2018/9/15.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "UserFriendTableView.h"
#import "UserDao.h"
#import "ShequModel.h"
#import "ShequFrameModel.h"
#import "ShequCell.h"
#import "MJRefresh.h"
#import "LogDetailController.h"


@interface UserFriendTableView ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;


@property (nonatomic, copy) NSString * count;

@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, assign) NSInteger page;

@end


@implementation UserFriendTableView


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
        [self.tableView registerClass:[ShequCell class] forCellReuseIdentifier:NSStringFromClass([ShequCell class])];
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


- (void)netForHeader {
    self.page = 1;
    [self netForLog];
}

- (void)netForLog {
    
    @weakify(self);
    [UserDao userContenPage:self.page SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        self.page ++;
        
        ShequDataModel *dataModel = (ShequDataModel *)responseObject;
        for (ShequModel *model in dataModel.data) {
            ShequFrameModel *frameModel = [[ShequFrameModel alloc] init];
            frameModel.shequModel = model;
            [self.dataArray addObject:frameModel];
        }
        [self.tableView reloadData];
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.tableView];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}

#pragma mark-- tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShequCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShequCell class]) forIndexPath:indexPath];
    ShequFrameModel *model = self.dataArray[indexPath.row];
    cell.shequFrameModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShequFrameModel *model = self.dataArray[indexPath.row];
    return model.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AutoSize6(20);
    }
    
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ShequFrameModel *frameModel = self.dataArray[indexPath.row];
    if (frameModel.shequModel.tid.length) {
        LogDetailController *detailController = [[LogDetailController alloc] init];
        detailController.tid = frameModel.shequModel.tid;
        [[UIViewController currentViewController].navigationController pushViewController:detailController animated:YES];
    }
}


@end
