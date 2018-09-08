//
//  FinishMessageViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FinishMessageViewController.h"
#import "MineSetModel.h"
#import "FinishHeaderView.h"
#import "FinishCell.h"
#import "PublishContenController.h"
#import "ApplyTimePickerView.h"
#import "MineLocationViewController.h"
#import "ShequZuzhiController.h"
#import "DiscoverDao.h"
#import "SetDao.h"

@interface FinishMessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) FinishHeaderView *headerView;

@property (nonatomic, copy) NSString * shengString;

@property (nonatomic, copy) NSString * shiString;


@property (nonatomic, copy) NSString *group;

@property (nonatomic, copy) NSString *wechat;

@property (nonatomic, copy) NSString *weibo;
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *gid;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *sign;


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
    
    self.rightButton.title = @"保存";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorDefaultColor, NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];

    self.tableView.top = total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[FinishCell class] forCellReuseIdentifier:NSStringFromClass([FinishCell class])];

    self.headerView = [[FinishHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(438))];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(200))];
    
    [self makeData];
    
}

- (void)rightButtonAction {
    [self getData];
    [AppBaseHud showHudWithLoding:self.view];
    [SetDao finishMessage:self.shengString
                     city:self.shiString
                   gender:self.headerView.gender
                   wechat:self.wechat
                    weibo:self.weibo
                       qq:self.qq
                      gid:self.gid
                 birthday:self.birthday
                     sign:self.sign
             successBlock:^(__kindof AppBaseModel *responseObject) {
                 [AppBaseHud showHudWithSuccessful:@"保存成功" view:self.view];
                 [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshUserInfoNotification object:nil];
                 
             } failureBlock:^(__kindof AppBaseModel *error) {
                 [AppBaseHud showHudWithfail:error.errstr view:self.view];
             }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FinishCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FinishCell class]) forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return AutoSize6(94);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        ApplyTimePickerView *pickerView = [[ApplyTimePickerView alloc] initWithFrame:self.view.bounds];
        @weakify(self)
        pickerView.handler = ^(ApplyTimePickerView *timePickerView, NSString *date) {
            @strongify(self)
            [timePickerView removeFromSuperview];
            timePickerView = nil;
            if (date.length) {
                MineSetModel *model = self.dataArray[indexPath.section][indexPath.row];
                model.detailText = date;
                self.birthday = date;
                [self.tableView reloadData];
            }
        };
        [self.view addSubview:pickerView];
        return;
    }
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        MineLocationViewController *vc = [[MineLocationViewController alloc] init];
        vc.isFirst = YES;
        vc.block = ^(NSString *sheng, NSString *shi) {
            MineSetModel *model = self.dataArray[indexPath.section][indexPath.row];
            model.detailText = [NSString stringWithFormat:@"%@%@", sheng, shi];
            self.shengString = sheng;
            self.shiString = shi;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    PublishContenController *contentvc = [[PublishContenController alloc] init];
    if (indexPath.section == 0 && indexPath.row == 4) {
        contentvc.contentblock = ^(NSString *contentString) {
            MineSetModel *model = self.dataArray[indexPath.section][indexPath.row];
            model.detailText = contentString;
            self.sign = contentString;
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:contentvc animated:YES];
    } else if (indexPath.section == 1) {
        contentvc.contentblock = ^(NSString *contentString) {
            MineSetModel *model = self.dataArray[indexPath.section][indexPath.row];
            model.detailText = contentString;
            if (indexPath.row == 0) {
                self.wechat = contentString;
            } else if (indexPath.row == 1){
                self.weibo = contentString;
            } else if (indexPath.row == 2) {
                self.qq = contentString;
            }
            
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:contentvc animated:YES];
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self zuzhi];
    }
}

- (void)zuzhi {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [DiscoverDao getShequSectionSuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        
        ShequZuzhiDataModel *dataModel = (ShequZuzhiDataModel *)responseObject;
        ShequZuzhiController *zuzhivc = [[ShequZuzhiController alloc] init];
        zuzhivc.fromType = 2;
        zuzhivc.dataModel = dataModel;
        zuzhivc.viewControllerActionBlock = ^(UIViewController *viewController, NSObject *userInfo) {
            
            self.gid = ((ShequZuzhiController *)viewController).groupId;
            self.group = ((ShequZuzhiController *)viewController).zuzhiModel.name;
            MineSetModel *model = self.dataArray[2][0];
            model.detailText = self.group;
            [self.tableView reloadData];
            
        };
        [self.navigationController pushViewController:zuzhivc animated:YES];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (void)getData {

    if (self.shengString.length == 0) {
        self.shengString = [UserPage sharedInstance].userModel.province;
        self.shiString = [UserPage sharedInstance].userModel.city;
    }
    
    if (self.wechat.length == 0) {
        self.wechat = [UserPage sharedInstance].userModel.wechat;
    }
    
    if (self.weibo.length == 0) {
        self.weibo = [UserPage sharedInstance].userModel.weibo;
    }

    if (self.qq.length == 0) {
        self.qq = [UserPage sharedInstance].userModel.qq;
    }

    if (self.birthday.length == 0) {
        self.birthday = [UserPage sharedInstance].userModel.birthday;
    }

    if (self.sign.length == 0) {
        self.sign = [UserPage sharedInstance].userModel.sign;
    }

    if (self.gid.length == 0) {
        self.wechat = [UserPage sharedInstance].userModel.gid;
    }

}


- (void)makeData {
    
    NSMutableArray *section0 = [NSMutableArray new];
    MineSetModel *model = [[MineSetModel alloc] init];
    model.isShowContent = NO;
    model.isShowSwitch = NO;
    model.title = @"昵称";
    model.type = @"100";
    model.detailText = [UserPage sharedInstance].userModel.username;
    [section0 addObject:model];
    
    MineSetModel *model1 = [[MineSetModel alloc] init];
    model1.iconUrl = @"";
    model1.isShowContent = NO;
    model1.isShowSwitch = NO;
    model1.title = @"手机号";
    model1.type = @"200";
    model1.detailText = [UserPage sharedInstance].userModel.mobile;
    [section0 addObject:model1];
    
    MineSetModel *model2 = [[MineSetModel alloc] init];
    model2.iconUrl = @"";
    model2.isShowContent = NO;
    model2.isShowSwitch = NO;
    model2.title = @"所在地";
    model2.detailText = [NSString stringWithFormat:@"%@%@", [UserPage sharedInstance].userModel.province, [UserPage sharedInstance].userModel.city];
    model2.pushViewController = @"ThirdAcountViewController";
    [section0 addObject:model2];
    
    MineSetModel *model10 = [[MineSetModel alloc] init];
    model10.iconUrl = @"";
    model10.isShowContent = NO;
    model10.isShowSwitch = YES;
    model10.title = @"生日";
    model10.detailText = [UserPage sharedInstance].userModel.birthday;
    [section0 addObject:model10];
    
    MineSetModel *model11 = [[MineSetModel alloc] init];
    model11.iconUrl = @"";
    model11.isShowContent = NO;
    model11.isShowSwitch = YES;
    model11.title = @"个性签名";
    if ([UserPage sharedInstance].userModel.sign.length) {
        model11.detailText = [UserPage sharedInstance].userModel.sign;
    } else {
        model11.detailText = @"(最多30个字)";
    }
    [section0 addObject:model11];
    
    
    NSMutableArray *section1 = [NSMutableArray new];

    MineSetModel *model12 = [[MineSetModel alloc] init];
    model12.iconUrl = @"";
    model12.isShowContent = NO;
    model12.isShowSwitch = YES;
    model12.title = @"我的微信";
    model12.detailText = [UserPage sharedInstance].userModel.wechat;
    [section1 addObject:model12];
    
    MineSetModel *model20 = [[MineSetModel alloc] init];
    model20.iconUrl = @"";
    model20.isShowContent = YES;
    model20.isShowSwitch = NO;
    model20.title = @"我的微博";
    model20.detailText = [UserPage sharedInstance].userModel.weibo;
    [section1 addObject:model20];
    
    MineSetModel *model30 = [[MineSetModel alloc] init];
    model30.iconUrl = @"";
    model30.isShowContent = NO;
    model30.isShowSwitch = NO;
    model30.title = @"我的QQ";
    model30.detailText = [UserPage sharedInstance].userModel.qq;
    [section1 addObject:model30];
    
    NSMutableArray *section2 = [NSMutableArray new];

    MineSetModel *model40 = [[MineSetModel alloc] init];
    model40.iconUrl = @"";
    model40.isShowContent = NO;
    model40.isShowSwitch = NO;
    model40.title = @"加入组织";
    model40.detailText = [UserPage sharedInstance].userModel.group;
    [section2 addObject:model40];
    
    _dataArray = @[section0, section1, section2];
}

@end
