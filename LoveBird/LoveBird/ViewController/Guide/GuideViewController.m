//
//  GuideViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2018/1/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "GuideViewController.h"
#import "MJRefresh.h"
#import "GuideCell.h"
#import "FindDao.h"
#import "GuideModel.h"


@interface GuideViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;

@end

@implementation GuideViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
}

- (void)netForBirdGuideHeader {
    self.page = 1;
    [self netForBirdGuide];
}

- (void)netForBirdGuideFooter {
    self.page ++;
    [self netForBirdGuide];
}

- (void)netForBirdGuide {
    
    @weakify(self);
    [FindDao getGuide:[NSString stringWithFormat:@"%ld", self.page] successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        GuideDataModel *dataModel = (GuideDataModel *)responseObject;
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:dataModel.data];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}



#pragma mark- collectionView代理

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AutoSize6(20);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GuideCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GuideCell class]) forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [GuideCell getHeight:self.dataArray[indexPath.row]];
}

- (void)setTableView {
    
    self.title = @"鸟导";
    [self.rightButton setImage:[UIImage imageNamed:@"find_right"]];
    
    self.tableView.top = total_topView_height;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(200))];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[GuideCell class] forCellReuseIdentifier:NSStringFromClass([GuideCell class])];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForBirdGuideHeader)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForBirdGuideFooter)];
    [self.tableView.mj_header beginRefreshing];
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


@end
