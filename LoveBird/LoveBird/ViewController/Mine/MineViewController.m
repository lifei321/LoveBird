//
//  MineViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "MineViewController.h"
#import "MineDataSourceManager.h"
#import "MineTableViewCell.h"
#import "MineSetViewController.h"
#import "NotifycationViewController.h"


@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的";
    self.rightButton.title = @"分享";
    self.leftButton.title = @"通知";
    [self.navigationController wr_setNavBarTintColor:[UIColor clearColor]];
    [self.navigationController wr_setNavBarBackgroundAlpha:0];

    self.dataSourceArray =  [MineDataSourceManager DataSource];
    [self registerClass:[MineTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MineTableViewCell class]) dataSource:nil];
    self.leftSpaceForBottomLine = AutoSize(15);
    [self.tableView reloadData];
}



- (void)rightButtonAction {
    MineSetViewController *setvc = [[MineSetViewController alloc] init];
    [self.navigationController pushViewController:setvc animated:YES];
}


- (void)leftButtonAction {
    NotifycationViewController *vc = [[NotifycationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
