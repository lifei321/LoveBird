//
//  CaogaoViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/8/11.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "CaogaoViewController.h"
#import "CaogaoTableViewCell.h"
#import "MineCaogaoModel.h"
#import "PublishDao.h"

@interface CaogaoViewController ()<UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CaogaoViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"草稿箱";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    [self setTableView];
    
    [self netForLog];
}


- (void)netForLog {
    
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [PublishDao getCaogaoSuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        MineCaogaoDataModel *datamodel = (MineCaogaoDataModel *)responseObject;
        [self.dataArray addObjectsFromArray:datamodel.data];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
    
}

#pragma mark-- tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CaogaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CaogaoTableViewCell class]) forIndexPath:indexPath];
    MineCaogaoModel *model = self.dataArray[indexPath.row];
    cell.caogaomodel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize6(274);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AutoSize6(20);
    }
    
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)setTableView {
    
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(30))];
    
    [self.tableView registerClass:[CaogaoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([CaogaoTableViewCell class])];
//
//    //默认【下拉刷新】
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForLog)];
//    //默认【上拉加载】
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForLog)];
}
@end
