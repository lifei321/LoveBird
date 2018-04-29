//
//  NotifycationViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "NotifycationViewController.h"
#import "MineSetModel.h"

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
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self makeData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    MineSetModel *model = _dataArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:model.iconUrl];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.detailText;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize(47);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)makeData {
    
    _dataArray = [NSMutableArray new];
    MineSetModel *model = [[MineSetModel alloc] init];
    model.iconUrl = @"message";
    model.isShowContent = NO;
    model.isShowSwitch = NO;
    model.title = @"系统消息";
    [_dataArray addObject:model];
    
    MineSetModel *model1 = [[MineSetModel alloc] init];
    model1.iconUrl = @"comment";
    model1.isShowContent = NO;
    model1.isShowSwitch = NO;
    model1.title = @"评论";
    [_dataArray addObject:model1];
    
    MineSetModel *model2 = [[MineSetModel alloc] init];
    model2.iconUrl = @"follow";
    model2.isShowContent = NO;
    model2.isShowSwitch = NO;
    model2.title = @"关注";
    [_dataArray addObject:model2];
    
    MineSetModel *model10 = [[MineSetModel alloc] init];
    model10.iconUrl = @"like";
    model10.isShowContent = NO;
    model10.isShowSwitch = YES;
    model10.title = @"赞";
    [_dataArray addObject:model10];
    
}

@end
