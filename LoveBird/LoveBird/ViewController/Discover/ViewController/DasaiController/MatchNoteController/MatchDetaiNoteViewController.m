//
//  MatchDetaiNoteViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/10.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MatchDetaiNoteViewController.h"
#import "DiscoverDao.h"
#import "MatchArticleModel.h"
#import "MatchNoteCell.h"


@interface MatchDetaiNoteViewController ()<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString * count;

@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation MatchDetaiNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];
    
    
    [self setTableView];
    [self netForLog];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}


- (void)netForLog {
    
    @weakify(self);
    [DiscoverDao getMatchArctleList:self.matchid SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        MatchArticleDataModel *dataModel = (MatchArticleDataModel *)responseObject;
        
        [self.dataArray addObjectsFromArray:dataModel.data];
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

}

- (void)setTableView {
    
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[MatchNoteCell class] forCellReuseIdentifier:NSStringFromClass([MatchNoteCell class])];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(30))];
}


@end
