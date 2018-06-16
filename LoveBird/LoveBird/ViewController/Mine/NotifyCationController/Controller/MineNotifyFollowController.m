//
//  MineNotifyFollowController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/16.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineNotifyFollowController.h"
#import "NotifyFollowCell.h"
#import "MessageModel.h"
#import "SetDao.h"


@interface MineNotifyFollowController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation MineNotifyFollowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NotifyFollowCell class] forCellReuseIdentifier:NSStringFromClass([NotifyFollowCell class])];
    
    [self netForfollow];
}

- (void)netForfollow {
    
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [SetDao getSetType:self.type successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        
        MessageDataModel *dataModel = (MessageDataModel *)responseObject;
        [self.dataArray addObjectsFromArray:dataModel.data];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NotifyFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NotifyFollowCell class]) forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize6(192);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
