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
    return 0.01f;
}

- (void)setTableView {
    
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[MineLogCell class] forCellReuseIdentifier:NSStringFromClass([MineLogCell class])];
    self.tableView.tableHeaderView = [self makeHeaderView];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(30))];
}

- (UIView *)makeHeaderView {
    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(70))];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, AutoSize6(30), SCREEN_WIDTH, AutoSize6(40))];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
    NSString *placeString = @"3";
    NSString *textString = [NSString stringWithFormat:@"您还有%@篇草稿没有完成 ->", placeString];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textString];
    [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColor7f7f7f range:NSMakeRange(0, 3)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, placeString.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColor7f7f7f range:NSMakeRange(3 + placeString.length, 10)];

    [attrString addAttribute:NSFontAttributeName value:kFont6(24) range:NSMakeRange(0, textString.length)];
    tipLabel.attributedText = attrString;
    [headview addSubview:tipLabel];
    
    return headview;
}

@end
