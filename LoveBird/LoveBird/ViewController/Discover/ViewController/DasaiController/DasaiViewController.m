//
//  DasaiViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/20.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "DasaiViewController.h"
#import "MatchModel.h"
#import "MatchListCell.h"
#import "DiscoverDao.h"


@interface DasaiViewController ()


@end

@implementation DasaiViewController

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
    [self netForData];
}

- (void)netForData {
    [AppBaseHud showHudWithLoding:self.view];
    
    @weakify(self);
    [DiscoverDao getMatchListSuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        MatchListModel *listModel = (MatchListModel *)responseObject;
        NSMutableArray *tempArray = [NSMutableArray new];
        for (MatchModel *model in listModel.data) {
            AppBaseCellModel *cellModel = [[AppBaseCellModel alloc] init];
            cellModel.userInfo = model;
            [tempArray addObject:cellModel];
        }
        self.dataSource.tableListArray = [NSMutableArray arrayWithObjects:tempArray, nil];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize6(576);
}

#pragma mark-- UI
- (void)setNavigation {
    self.navigationItem.title = @"大赛";
    [self.rightButton setImage:[UIImage imageNamed:@"match_right"]];
}


- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.dataSource = [[AppBaseTableDataSource alloc] init];
    [self registerClass:[MatchListCell class] forCellReuseIdentifier:NSStringFromClass([MatchListCell class]) dataSource:self.dataSource];
}

@end