//
//  MineFollowController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineFollowController.h"
#import "UserFollowModel.h"
#import "MineFollowCell.h"
#import "UserDao.h"


@interface MineFollowController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;

@end

@implementation MineFollowController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type == 1) {
        self.title = @"关注";

    } else if (self.type == 2) {
        self.title = @"粉丝";
    } else if (self.type == 2) {
        self.title = @"用户";
    }
    
    
//    self.rightButton.title = @"完成";
//    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
//    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    self.dataArray = [NSMutableArray new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netForFollowList) name:kLoginSuccessNotification object:nil];

    [self setTableView];
    
    if (self.type == 1) {
        
        //默认【下拉刷新】
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForFollowHeader)];
        //默认【上拉加载】
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForFollowList)];

        [self netForFollowHeader];

    } else if (self.type == 2) {
        
        //默认【下拉刷新】
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForFansHeader)];
        //默认【上拉加载】
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForFansList)];

        [self netForFansHeader];
    }
    
    
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)netForFollowHeader {
    self.page = 1;
    [self netForFollowList];
}

- (void)netForFollowList {
    
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [UserDao userFollowList:self.taid page:self.page successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        UserFollowListModel *dataModel = (UserFollowListModel *)responseObject;
        
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
            self.page ++;
        }
        [self.dataArray addObjectsFromArray:dataModel.data];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)netForFansHeader {
    self.page = 1;
    [self netForFansList];
}

- (void)netForFansList {
    
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [UserDao userFansList:self.taid page:self.page successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        UserFollowListModel *dataModel = (UserFollowListModel *)responseObject;
        
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
            self.page ++;
        }
        
        [self.dataArray addObjectsFromArray:dataModel.data];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)setWord:(NSString *)word {
    _word = [word copy];
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForUserHeader)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netforUser)];
    [self netForUserHeader];
}

- (void)netForUserHeader {
    self.page = 1;
    [self netforUser];
}


- (void)netforUser {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [UserDao userGetList:self.word page:self.page successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        UserFollowListModel *dataModel = (UserFollowListModel *)responseObject;
        
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
            self.page ++;
        }

        [self.dataArray addObjectsFromArray:dataModel.data];
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineFollowCell class]) forIndexPath:indexPath];
    cell.followModel = self.dataArray[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return AutoSize6(134);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}


- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01f)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[MineFollowCell class] forCellReuseIdentifier:NSStringFromClass([MineFollowCell class])];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(100))];
}
@end
