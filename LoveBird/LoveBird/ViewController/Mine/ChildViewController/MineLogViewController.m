//
//  MineLogViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/23.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineLogViewController.h"
#import "UserDao.h"
#import "ShequModel.h"
#import "ShequFrameModel.h"
#import "ShequCell.h"

@interface MineLogViewController ()<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation MineLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] init];

    
    [self setTableView];
    
    [self netForLog];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)netForLog {
    
    @weakify(self);
    [UserDao userLogList:1 matchId:nil fid:nil successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        
        ShequDataModel *dataModel = (ShequDataModel *)responseObject;
        for (ShequModel *model in dataModel.data) {
            ShequFrameModel *frameModel = [[ShequFrameModel alloc] init];
            frameModel.shequModel = model;
            [self.dataArray addObject:frameModel];
        }
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

#pragma mark-- tableview 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShequCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShequCell class]) forIndexPath:indexPath];
    ShequFrameModel *model = self.dataArray[indexPath.row];
    cell.shequFrameModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShequFrameModel *model = self.dataArray[indexPath.row];
    return model.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AutoSize6(20);
    }
    
    return 0.01f;
}

- (void)setTableView {
    
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[ShequCell class] forCellReuseIdentifier:NSStringFromClass([ShequCell class])];
    
}

@end