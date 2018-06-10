//
//  MatchDetailController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MatchDetailController.h"
#import "MatchDetailHeaderView.h"
#import "DiscoverDao.h"
#import "MatchDetailModel.h"

@interface MatchDetailController ()


@property (nonatomic, strong) MatchDetailHeaderView *headerView;

@end

@implementation MatchDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;
    
    [self netForDetaiModel];
    
}

- (void)netForDetaiModel {
    [AppBaseHud showHudWithLoding:self.view];
    
    @weakify(self);
    [DiscoverDao getMatchDetail:self.matchid SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];

        self.tableView.tableHeaderView = self.headerView;
        self.headerView.detailModel = (MatchDetailModel *)responseObject;
        self.headerView.height = [self.headerView getHeight];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (MatchDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MatchDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    }
    
    return _headerView;
}

@end
