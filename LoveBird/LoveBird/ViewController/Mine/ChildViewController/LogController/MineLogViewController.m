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
#import "MineLogFrameModel.h"
#import "MineLogCell.h"

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
        for (int i = 0; i < dataModel.data.count; i++) {
            ShequModel *model = dataModel.data[i];
            MineLogFrameModel *frameModel = [[MineLogFrameModel alloc] init];
            frameModel.isFirst = (i == 0) ? YES : NO;
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
    MineLogCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineLogCell class]) forIndexPath:indexPath];
    MineLogFrameModel *model = self.dataArray[indexPath.row];
    cell.frameModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineLogFrameModel *model = self.dataArray[indexPath.row];
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
    
    [self.tableView registerClass:[MineLogCell class] forCellReuseIdentifier:NSStringFromClass([MineLogCell class])];
    
}

@end
