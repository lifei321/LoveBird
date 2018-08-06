//
//  ShequViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/14.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ShequViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "DiscoverDao.h"
#import "ShequModel.h"
#import "ShequCell.h"
#import "ShequFrameModel.h"
#import "BannerModel.h"
#import "LogDetailController.h"
#import "ShequZuzhiModel.h"
#import "ShequZuzhiController.h"
#import "MJRefresh.h"


@interface ShequViewController ()<SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

// 轮播图
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;

@end

@implementation ShequViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableView];
    
    [self netForBanner];
}

- (void)netForBanner {
    NSDictionary *dic = @{
                          @"cmd":@"homeNavigation",
                          @"bid":@"200",
                          };
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [AppHttpManager GET:kAPI_Discover_Banner parameters:dic jsonModelName:[BannerDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        BannerDataModel *dataModel = (BannerDataModel *)responseObject;
        
        NSMutableArray *temp = [NSMutableArray new];
        for (BannerModel *model in dataModel.data) {
            [temp addObject:model.img];
        }
        self.cycleScrollView.imageURLStringsGroup = [temp mutableCopy];
    } failure:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (void)netForHeader {
    self.page = 1;
    [self netforData];
}

- (void)netForFooter {
    self.page++;
    [self netforData];
}

- (void)netforData {
    @weakify(self);
    [DiscoverDao getShequList:self.page
                      groupId:self.groupId
                       sortId:self.sortId
                 successBlock:^(__kindof AppBaseModel *responseObject) {
                     @strongify(self);
                     [AppBaseHud hideHud:self.view];
                     [self.tableView.mj_header endRefreshing];
                     [self.tableView.mj_footer endRefreshing];
                    ShequDataModel *dataModel = (ShequDataModel *)responseObject;
                     
                     if (self.page == 1) {
                         [self.dataArray removeAllObjects];
                     }
                    for (ShequModel *model in dataModel.data) {
                        ShequFrameModel *frameModel = [[ShequFrameModel alloc] init];
                        frameModel.shequModel = model;
                        [self.dataArray addObject:frameModel];
                    }
                    [self.tableView reloadData];
        
            } failureBlock:^(__kindof AppBaseModel *error) {
                @strongify(self);
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShequFrameModel *frameModel = self.dataArray[indexPath.row];
    if (frameModel.shequModel.tid.length) {
        LogDetailController *detailController = [[LogDetailController alloc] init];
        detailController.tid = frameModel.shequModel.tid;
        [self.navigationController pushViewController:detailController animated:YES];
    }
}


#pragma mark - 轮播图代理

// 图片滚动
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

// 图片点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}


#pragma mark-- UI
- (void)setNavigation {
    self.navigationItem.title = @"社区";
    [self.rightButton setImage:[UIImage imageNamed:@"shequ_right"]];
}

- (void)rightButtonAction {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [DiscoverDao getShequSectionSuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        
        ShequZuzhiDataModel *dataModel = (ShequZuzhiDataModel *)responseObject;
        ShequZuzhiController *zuzhivc = [[ShequZuzhiController alloc] init];
        zuzhivc.dataModel = dataModel;
        zuzhivc.viewControllerActionBlock = ^(UIViewController *viewController, NSObject *userInfo) {
            self.groupId = ((ShequZuzhiController *)viewController).groupId;
            self.sortId = ((ShequZuzhiController *)viewController).sortId;
            [self.tableView.mj_header beginRefreshing];
        };
        [self.navigationController pushViewController:zuzhivc animated:YES];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}


- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[ShequCell class] forCellReuseIdentifier:NSStringFromClass([ShequCell class])];
    
    self.cycleScrollView.delegate = self;
    self.tableView.tableHeaderView = self.cycleScrollView;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForHeader)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForFooter)];
    [self.tableView.mj_header beginRefreshing];
}



- (SDCycleScrollView *)cycleScrollView {
    
    if (_cycleScrollView == nil) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(400)) delegate:self placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _cycleScrollView;
}

@end
