//
//  MineLocationViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/9/8.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineLocationViewController.h"
#import "MineLocationModel.h"
#import "SetDao.h"

@interface MineLocationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *shengArray;

@property (nonatomic, strong) NSMutableArray *shiArray;



@end

@implementation MineLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择所在地";
    _shengArray = [NSMutableArray new];
    _shiArray = [NSMutableArray new];
    
    self.tableView.top = total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    [self getDataWithupid:self.upid];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _isFirst ? _shengArray.count : _shiArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    MineLocationModel *model = _isFirst ? self.shengArray[indexPath.row] : self.shiArray[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isFirst) {
        MineLocationModel *model = self.shengArray[indexPath.row];
        
        
        MineLocationViewController *vc = [[MineLocationViewController alloc] init];
        vc.isFirst = NO;
        vc.upid = model.modelid;
        vc.shengString = model.name;
        vc.block = ^(NSString *sheng, NSString *shi) {
            self.shengString = sheng;
            self.shiString = shi;
            self.block(self.shengString, self.shiString);
            [self.navigationController popViewControllerAnimated:YES];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        MineLocationModel *model = self.shiArray[indexPath.row];

        self.shiString = model.name;
        self.block(self.shengString, self.shiString);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)getDataWithupid:(NSString *)upId {
    
    [AppBaseHud showHudWithLoding:self.view];
    [SetDao getLocation:upId successBlock:^(__kindof AppBaseModel *responseObject) {
        [AppBaseHud hideHud:self.view];
        
        MineLocationDataModel *datamodel = (MineLocationDataModel *)responseObject;
        if (upId.length) {
            [self.shiArray addObjectsFromArray:datamodel.data];
        } else {
            [self.shengArray addObjectsFromArray:datamodel.data];
        }
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        [AppBaseHud hideHud:self.view];

    }];
}

@end
