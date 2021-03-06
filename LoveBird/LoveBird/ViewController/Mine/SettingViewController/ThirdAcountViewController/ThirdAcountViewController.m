//
//  ThirdAcountViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ThirdAcountViewController.h"
#import "MineSetModel.h"


@interface ThirdAcountViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ThirdAcountViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"绑定第三方账号";
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
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
    model.iconUrl = @"binding_weixin";
    model.isShowContent = NO;
    model.isShowSwitch = NO;
    model.title = @"微信";
    model.detailText = @"未绑定";
    [_dataArray addObject:model];
    
    MineSetModel *model1 = [[MineSetModel alloc] init];
    model1.iconUrl = @"binding_qq";
    model1.isShowContent = NO;
    model1.isShowSwitch = NO;
    model1.title = @"QQ";
    model1.detailText = @"未绑定";
    [_dataArray addObject:model1];
    
    MineSetModel *model2 = [[MineSetModel alloc] init];
    model2.iconUrl = @"binding_weibo";
    model2.isShowContent = NO;
    model2.isShowSwitch = NO;
    model2.title = @"微博";
    model2.detailText = @"未绑定";
    [_dataArray addObject:model2];
    
    MineSetModel *model10 = [[MineSetModel alloc] init];
    model10.iconUrl = @"binding_phone";
    model10.isShowContent = NO;
    model10.isShowSwitch = YES;
    model10.title = @"手机号";
    model10.detailText = @"未绑定";
    [_dataArray addObject:model10];
    
    MineSetModel *model11 = [[MineSetModel alloc] init];
    model11.iconUrl = @"binding_PFs";
    model11.isShowContent = NO;
    model11.isShowSwitch = YES;
    model11.title = @"佳友在线用户";
    model11.detailText = @"未绑定";
    [_dataArray addObject:model11];
   
}

@end
