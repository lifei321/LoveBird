//
//  MineSetViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/5.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineSetViewController.h"
#import "MineSetTableViewCell.h"
#import "UserModel.h"


@interface MineSetViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation MineSetViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.tableView.top = total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MineSetTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MineSetTableViewCell class])];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(200))];
    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, AutoSize6(20), SCREEN_WIDTH, AutoSize6(50))];
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutButton setTitleColor:kColorDefaultColor forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logoutButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:logoutButton];
    
    self.tableView.tableFooterView = footerView;
    
    [self makeData];
}

- (void)logoutButtonDidClick {
    [UserPage logoutBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineSetTableViewCell class]) forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize6(94);
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AutoSize6(77);
        
    } else if (section == 1) {
        return AutoSize6(77);
        
    } else if (section == 2) {
        return AutoSize6(20);
        
    } else if (section == 3) {
        return AutoSize6(77);
    }
    
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(77))];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(20), SCREEN_WIDTH -  AutoSize6(60), AutoSize6(57))];
    label.font = kFont6(28);
    label.textColor = [UIColor lightGrayColor];
    [headView addSubview:label];
    
    if (section == 0) {
        label.text = @"个人信息设置";
    } else if (section == 1) {
        label.text = @"推送设置";

    } else if (section == 2) {
        return nil;
    } else if (section == 3) {
        label.text = @"其他";
    }
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MineSetModel *model = _dataArray[indexPath.section][indexPath.row];
    if (model.pushViewController.length) {
        UIViewController *vc = [[NSClassFromString(model.pushViewController) alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        

        if (indexPath.section == 3) {
            AppWebViewController *webvc = [[AppWebViewController alloc] init];
            NSString *url;
            
            if (indexPath.row == 0) {
                url = [UserPage sharedInstance].userModel.aboutUrl;
            } else if (indexPath.row == 1) {
                url = [UserPage sharedInstance].userModel.helpUrl;
            } else if (indexPath.row == 2) {
                url = [UserPage sharedInstance].userModel.feedbackUrl;
            }
            [self.navigationController pushViewController:webvc animated:YES];
        }
    }
}

- (void)makeData {
    
    NSMutableArray *section0 = [NSMutableArray new];
    MineSetModel *model = [[MineSetModel alloc] init];
    model.iconUrl = [UserPage sharedInstance].userModel.head;
    model.isShowContent = NO;
    model.isShowSwitch = NO;
    model.title = [UserPage sharedInstance].userModel.username;
    model.pushViewController = @"FinishMessageViewController";
    [section0 addObject:model];
    
    MineSetModel *model1 = [[MineSetModel alloc] init];
    model1.iconUrl = @"";
    model1.isShowContent = NO;
    model1.isShowSwitch = NO;
    model1.title = @"我的二维码";
    [section0 addObject:model1];
    
    MineSetModel *model2 = [[MineSetModel alloc] init];
    model2.iconUrl = @"";
    model2.isShowContent = NO;
    model2.isShowSwitch = NO;
    model2.title = @"绑定第三方";
    model2.pushViewController = @"ThirdAcountViewController";
    [section0 addObject:model2];
    
    NSMutableArray *section1 = [NSMutableArray new];
    MineSetModel *model10 = [[MineSetModel alloc] init];
    model10.iconUrl = @"";
    model10.isShowContent = NO;
    model10.isShowSwitch = YES;
    model10.title = @"系统消息";
    [section1 addObject:model10];
    
    MineSetModel *model11 = [[MineSetModel alloc] init];
    model11.iconUrl = @"";
    model11.isShowContent = NO;
    model11.isShowSwitch = YES;
    model11.title = @"评论我";
    [section1 addObject:model11];
    
    MineSetModel *model12 = [[MineSetModel alloc] init];
    model12.iconUrl = @"";
    model12.isShowContent = NO;
    model12.isShowSwitch = YES;
    model12.title = @"关注我";
    [section1 addObject:model12];
    
    NSMutableArray *section2 = [NSMutableArray new];
    MineSetModel *model20 = [[MineSetModel alloc] init];
    model20.iconUrl = @"";
    model20.isShowContent = YES;
    model20.isShowSwitch = NO;
    model20.title = @"清理缓存";
    [section2 addObject:model20];
    
    NSMutableArray *section3 = [NSMutableArray new];
    MineSetModel *model30 = [[MineSetModel alloc] init];
    model30.iconUrl = @"";
    model30.isShowContent = NO;
    model30.isShowSwitch = NO;
    model30.title = @"关于我们";
    [section3 addObject:model30];
    
    MineSetModel *model31 = [[MineSetModel alloc] init];
    model31.iconUrl = @"";
    model31.isShowContent = NO;
    model31.isShowSwitch = NO;
    model31.title = @"帮助文档";
    [section3 addObject:model31];
    
    MineSetModel *model32 = [[MineSetModel alloc] init];
    model32.iconUrl = @"";
    model32.isShowContent = NO;
    model32.isShowSwitch = NO;
    model32.title = @"意见反馈";
    [section3 addObject:model32];
    
    _dataArray = @[section0, section1, section2, section3];
}


@end
