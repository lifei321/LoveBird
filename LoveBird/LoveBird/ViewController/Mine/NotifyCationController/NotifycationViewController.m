//
//  NotifycationViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "NotifycationViewController.h"
#import "MineSetModel.h"
#import "MineNotifyCell.h"
#import "MineNotifyFollowController.h"



@interface NotifycationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation NotifycationViewController


- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通知";
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MineNotifyCell class] forCellReuseIdentifier:NSStringFromClass([MineNotifyCell class])];
    [self makeData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MineNotifyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineNotifyCell class]) forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize6(98);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MineSetModel *model = self.dataArray[indexPath.row];
    MineNotifyFollowController *vc = [[MineNotifyFollowController alloc] init];
    vc.type = model.type;
    vc.title = model.title;
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
- (void)makeData {
    
    _dataArray = [NSMutableArray new];
    MineSetModel *model = [[MineSetModel alloc] init];
    model.iconUrl = @"message";
    model.isShowContent = NO;
    model.isShowSwitch = NO;
    model.title = @"系统消息";
    model.type = @"100";
    [_dataArray addObject:model];
    
    MineSetModel *model1 = [[MineSetModel alloc] init];
    model1.iconUrl = @"comment";
    model1.isShowContent = NO;
    model1.isShowSwitch = NO;
    model1.title = @"评论";
    model1.type = @"200";

    [_dataArray addObject:model1];
    
    MineSetModel *model2 = [[MineSetModel alloc] init];
    model2.iconUrl = @"follow";
    model2.isShowContent = NO;
    model2.isShowSwitch = NO;
    model2.title = @"关注";
    model2.type = @"300";

    [_dataArray addObject:model2];
    
    MineSetModel *model10 = [[MineSetModel alloc] init];
    model10.iconUrl = @"like";
    model10.isShowContent = NO;
    model10.isShowSwitch = YES;
    model10.title = @"赞";
    model10.type = @"400";

    [_dataArray addObject:model10];
    
    MineSetModel *model101 = [[MineSetModel alloc] init];
    model101.iconUrl = @"mine_sixin";
    model101.isShowContent = NO;
    model101.isShowSwitch = NO;
    model101.title = @"私信";
    model101.type = @"500";

    [_dataArray addObject:model101];
}

@end
