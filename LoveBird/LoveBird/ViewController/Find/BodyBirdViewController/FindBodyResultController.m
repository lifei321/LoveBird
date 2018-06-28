//
//  FindBodyResultController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindBodyResultController.h"
#import "FindResultCell.h"
#import "BirdDetailController.h"
#import "FindDao.h"

@interface FindBodyResultController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) FindSelectBirdModel *selectBirdModel;

@end

@implementation FindBodyResultController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查询结果";
    self.rightButton.title = @"完成";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    
    [self setTableView];
    
}

- (void)setWord:(NSString *)word {
    _word = [word copy];
    [self netForData];
}

- (void)netForData {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self)
    [FindDao getBirdWord:self.word successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        self.dataModel = (FindSelectBirdDataModel *)responseObject;
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}


#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindResultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FindResultCell class]) forIndexPath:indexPath];
    cell.birdModel = self.dataArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return AutoSize6(130);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FindSelectBirdModel *bridModel = self.dataArray[indexPath.row];
    if (self.selectBirdModel == bridModel) {
        return;
    }
    
    for (FindSelectBirdModel *cellmodel in self.dataArray) {
        if (cellmodel.isSelect) {
            cellmodel.isSelect = NO;
            break;
        }
    }
    self.selectBirdModel = bridModel;
    bridModel.isSelect = YES;
    [self.tableView reloadData];
    
    BirdDetailController *detailvc = [[BirdDetailController alloc] init];
    detailvc.cspCode = bridModel.csp_code;
    [[UIViewController currentViewController].navigationController pushViewController:detailvc animated:YES];
}

- (void)setDataModel:(FindSelectBirdDataModel *)dataModel {
    _dataModel = dataModel;
    _dataArray = [NSMutableArray new];

    [self.dataArray addObjectsFromArray:dataModel.data];
    [self.tableView reloadData];
}

- (void)setTableView {
    
    self.tableView.top = topView_height;
    self.tableView.height = SCREEN_HEIGHT - topView_height;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01f)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[FindResultCell class] forCellReuseIdentifier:NSStringFromClass([FindResultCell class])];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(200))];
}

@end
