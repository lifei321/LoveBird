//
//  FinishMessageViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FinishMessageViewController.h"
#import "MineSetModel.h"


@interface FinishMessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FinishMessageViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"完善个人信息";
    self.tableView.top = total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self makeData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ((indexPath.section == 0) && (indexPath.row == 0)) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    MineSetModel *model = _dataArray[indexPath.section][indexPath.row];
    if (model.iconUrl.length) {
        cell.imageView.image = [UIImage imageNamed:model.iconUrl];
    }
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.detailText;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize(47);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)makeHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize(200))];
    
    
    
    self.tableView.tableHeaderView = headerView;
}

- (void)makeData {
    
    NSMutableArray *section0 = [NSMutableArray new];
    MineSetModel *model = [[MineSetModel alloc] init];
    model.isShowContent = NO;
    model.isShowSwitch = NO;
    model.title = @"昵称";
    [section0 addObject:model];
    
    MineSetModel *model1 = [[MineSetModel alloc] init];
    model1.iconUrl = @"";
    model1.isShowContent = NO;
    model1.isShowSwitch = NO;
    model1.title = @"手机号";
    [section0 addObject:model1];
    
    MineSetModel *model2 = [[MineSetModel alloc] init];
    model2.iconUrl = @"";
    model2.isShowContent = NO;
    model2.isShowSwitch = NO;
    model2.title = @"所在地";
    model2.pushViewController = @"ThirdAcountViewController";
    [section0 addObject:model2];
    
    MineSetModel *model10 = [[MineSetModel alloc] init];
    model10.iconUrl = @"";
    model10.isShowContent = NO;
    model10.isShowSwitch = YES;
    model10.title = @"生日";
    [section0 addObject:model10];
    
    MineSetModel *model11 = [[MineSetModel alloc] init];
    model11.iconUrl = @"";
    model11.isShowContent = NO;
    model11.isShowSwitch = YES;
    model11.title = @"个性签名";
    [section0 addObject:model11];
    
    
    NSMutableArray *section1 = [NSMutableArray new];

    MineSetModel *model12 = [[MineSetModel alloc] init];
    model12.iconUrl = @"";
    model12.isShowContent = NO;
    model12.isShowSwitch = YES;
    model12.title = @"我的微信";
    [section1 addObject:model12];
    
    MineSetModel *model20 = [[MineSetModel alloc] init];
    model20.iconUrl = @"";
    model20.isShowContent = YES;
    model20.isShowSwitch = NO;
    model20.title = @"我的微博";
    [section1 addObject:model20];
    
    MineSetModel *model30 = [[MineSetModel alloc] init];
    model30.iconUrl = @"";
    model30.isShowContent = NO;
    model30.isShowSwitch = NO;
    model30.title = @"我的QQ";
    [section1 addObject:model30];
    
    _dataArray = @[section0, section1];
}

@end
