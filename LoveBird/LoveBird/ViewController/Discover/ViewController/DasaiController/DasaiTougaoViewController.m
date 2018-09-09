//
//  DasaiTougaoViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/9/9.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "DasaiTougaoViewController.h"
#import "MatchModel.h"
#import "MatchListCell.h"
#import "DiscoverDao.h"
#import "MatchDetailController.h"


@interface DasaiTougaoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation DasaiTougaoViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _dataArray = [NSMutableArray new];
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
    [DiscoverDao getMatchList:@"" SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        MatchListModel *listModel = (MatchListModel *)responseObject;
        for (MatchModel *model in listModel.data) {
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MatchListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MatchListCell class]) forIndexPath:indexPath];
    cell.matchModel = self.dataArray[indexPath.row];
    cell.matchClickBlock = ^(MatchListCell *cell) {
        
        for (MatchModel *match in self.dataArray) {
            if (match.isSelected) {
                match.isSelected = NO;
            }
        }
        MatchModel *selectmodel = cell.matchModel;
        selectmodel.isSelected = YES;
        [self.tableView reloadData];
    };
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
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
    
    MatchModel *model = self.dataArray[indexPath.row];
    MatchDetailController *detailvc = [[MatchDetailController alloc] init];
    detailvc.matchid = model.matchid;
    [self.navigationController pushViewController:detailvc animated:YES];
}

- (CGFloat)getHeight:(NSInteger)row {
    CGFloat height = 0;
    
    MatchModel *model = self.dataArray[row];
    
    height = model.imgHeight * (SCREEN_WIDTH / model.imgWidth);
    
    return  height + AutoSize6(115) + AutoSize6(20);
}

#pragma mark-- UI
- (void)setNavigation {
    self.navigationItem.title = @"投稿";
    
    self.rightButton.title = @"确定";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorTextColor333333, NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorTextColor333333, NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
}

- (void)rightButtonAction {
    
    MatchModel *selectModel = nil;
    for (MatchModel *matchmodel in self.dataArray) {
        if (matchmodel.isSelected) {
            selectModel = matchmodel;
            break;
        }
    }
    if (!selectModel) {
        [AppBaseHud showHudWithfail:@"请选择" view:self.view];
        return;
    }
    
    [AppBaseHud showHudWithLoding:self.view];
    [DiscoverDao getMatch:self.tid matchid:selectModel.matchid SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        [AppBaseHud hideHud:self.view];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}


- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MatchListCell class] forCellReuseIdentifier:NSStringFromClass([MatchListCell class])];
}

@end
