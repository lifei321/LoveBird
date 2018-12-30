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
#import "MatchDetailController.h"

#import "MatchDetailModel.h"

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
        if (listModel.data.count) {
            [self.tableView reloadData];
        }
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self getHeight:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppBaseCellModel *cellModel = self.dataSource.tableListArray[indexPath.section][indexPath.row];
    MatchModel *model = (MatchModel *)cellModel.userInfo;
    [self netForDetaiModelWithMatchId:model.matchid];
}

- (void)netForDetaiModelWithMatchId:(NSString *)matchid {
    [AppBaseHud showHudWithLoding:self.view];
    
    @weakify(self);
    [DiscoverDao getMatchDetail:matchid SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        
        MatchDetailController *detailvc = [[MatchDetailController alloc] init];
        detailvc.matchid = matchid;
        detailvc.detailModel = responseObject;
        [self.navigationController pushViewController:detailvc animated:YES];

    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
        
    }];
}

- (CGFloat)getHeight:(NSInteger)row {
    CGFloat height = 0;
    
    AppBaseCellModel *cellModel = self.dataSource.tableListArray[0][row];
    
    MatchModel *model = (MatchModel *)cellModel.userInfo;
    
    if (model.imgWidth < 1) {
        return 0.01f;
    }
    
    height = model.imgHeight * (SCREEN_WIDTH / model.imgWidth);
    
    return  height + AutoSize6(115) + AutoSize6(20);
}

#pragma mark-- UI
- (void)setNavigation {
    self.navigationItem.title = @"大赛";
//    [self.rightButton setImage:[UIImage imageNamed:@"match_right"]];
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
