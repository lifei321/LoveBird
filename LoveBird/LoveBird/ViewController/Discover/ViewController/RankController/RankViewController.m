//
//  RankViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "RankViewController.h"
#import "DiscoverDao.h"
#import <MJRefresh/MJRefresh.h>
#import "UIImage+Addition.h"
#import "RankModel.h"
#import "RankTableViewCell.h"


@interface RankViewController ()<UITableViewDelegate, UITableViewDataSource>

// 刷新页数
@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIButton *selectButton;

@end

@implementation RankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray new];
    
    [self setNavigation];
    
    // 设置UI
    [self setTableView];
    
    [self netForContentHeader];
}

- (void)netForContentHeader {
    self.type = @"100";
    
    [self netForContentWithPageNum:self.type header:YES];
}
- (void)netForContentFooter {
    [self netForContentWithPageNum:self.type header:NO];
}
- (void)netForContentWithPageNum:(NSString *)pageNum header:(BOOL)header {
    
    @weakify(self);
    [DiscoverDao getRankList:@"" type:self.type successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        if (header) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        RankDataModel *dataModel = (RankDataModel *)responseObject;
        if (header) {
            [self.dataArray removeAllObjects];
        }
        
        [self.dataArray addObjectsFromArray:dataModel.user];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        if (header) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RankTableViewCell class]) forIndexPath:indexPath];
    cell.rankModel = self.dataArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return AutoSize6(136);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)buttonDidClick:(UIButton *)button {
    if (button == self.selectButton) {
        return;
    }
    
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
}

- (void)setNavigation {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AutoSize6(400), AutoSize6(68))];
    titleView.layer.borderColor = kColorDefaultColor.CGColor;
    titleView.layer.borderWidth = 1;
    titleView.layer.cornerRadius = 5;
    titleView.clipsToBounds = YES;
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleView.width / 3, titleView.height)];
    [leftButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
    [leftButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"鸟种" forState:UIControlStateNormal];
    [leftButton setTitle:@"鸟种" forState:UIControlStateSelected];
    leftButton.titleLabel.font = kFont6(24);
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.selected = YES;
    self.selectButton = leftButton;
    [titleView addSubview:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(leftButton.right, 0, titleView.width / 3, titleView.height)];
    [rightButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
    [rightButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"日志" forState:UIControlStateNormal];
    [rightButton setTitle:@"日志" forState:UIControlStateSelected];
    rightButton.titleLabel.font = kFont6(24);
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleView addSubview:rightButton];
    
    UIButton *scolreButton = [[UIButton alloc] initWithFrame:CGRectMake(rightButton.right, 0, titleView.width / 3, titleView.height)];
    [scolreButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
    [scolreButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
    [scolreButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [scolreButton setTitle:@"积分" forState:UIControlStateNormal];
    [scolreButton setTitle:@"积分" forState:UIControlStateSelected];
    scolreButton.titleLabel.font = kFont6(24);
    [scolreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [scolreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleView addSubview:scolreButton];
    
    self.navigationItem.titleView = titleView;
    
    
}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[RankTableViewCell class] forCellReuseIdentifier:NSStringFromClass([RankTableViewCell class])];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForContentHeader)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForContentFooter)];
}



@end
