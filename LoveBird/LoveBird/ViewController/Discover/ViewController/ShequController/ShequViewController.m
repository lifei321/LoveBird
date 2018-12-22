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

#import "MatchDetailController.h"
@interface ShequViewController ()<SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

// 轮播图
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) NSMutableArray *bannerArray;

@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, assign) NSInteger page;

@end

@implementation ShequViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _dataArray = [[NSMutableArray alloc] init];
        _bannerArray = [NSMutableArray new];
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
        [self.bannerArray removeAllObjects];
        
        [self.bannerArray addObjectsFromArray:dataModel.data];
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

// 最新
- (void)netForNewHeader {
    self.page = 1;
    [AppBaseHud showHudWithLoding:self.view];
    [self netforNew];
}

// 关注
- (void)netForFriendHeader {
    self.page = 1;
    [AppBaseHud showHudWithLoding:self.view];
    [self netForFriend];
}

- (void)netForNearHeader {
    self.page = 1;
    [AppBaseHud showHudWithLoding:self.view];
    [self netForNear];
}

- (void)netforNew {
    @weakify(self);
    [DiscoverDao getShequList:self.page
                      groupId:self.groupId
                       sortId:self.sortId
                     province:[UserPage sharedInstance].province
                         city:[UserPage sharedInstance].city
                 successBlock:^(__kindof AppBaseModel *responseObject) {
                     @strongify(self);
                     [AppBaseHud hideHud:self.view];
                     [self.tableView.mj_header endRefreshing];
                     [self.tableView.mj_footer endRefreshing];
                    ShequDataModel *dataModel = (ShequDataModel *)responseObject;
                     
                     if (self.page == 1) {
                         [self.dataArray removeAllObjects];
                     }
                     self.page++;
                    for (ShequModel *model in dataModel.data) {
                        ShequFrameModel *frameModel = [[ShequFrameModel alloc] init];
                        frameModel.shequModel = model;
                        [self.dataArray addObject:frameModel];
                    }
                     if (dataModel.data.count) {
                         [self.tableView reloadData];
                     }
            } failureBlock:^(__kindof AppBaseModel *error) {
                @strongify(self);
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [AppBaseHud showHudWithfail:error.errstr view:self.view];
            }];
}


- (void)netForFriend {
    
    @weakify(self);
    [UserDao userContenPage:self.page SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (self.page == 1) {
            [self.dataArray removeAllObjects];
        }
        self.page ++;
        
        ShequDataModel *dataModel = (ShequDataModel *)responseObject;
        for (ShequModel *model in dataModel.data) {
            ShequFrameModel *frameModel = [[ShequFrameModel alloc] init];
            frameModel.shequModel = model;
            [self.dataArray addObject:frameModel];
        }
        if (dataModel.data.count) {
            [self.tableView reloadData];
        }
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
}


- (void)netForNear {
    @weakify(self);
    [DiscoverDao getShequList:self.page
                      groupId:self.groupId
                       sortId:self.sortId
                     province:[UserPage sharedInstance].province
                         city:[UserPage sharedInstance].city
                 successBlock:^(__kindof AppBaseModel *responseObject) {
                     @strongify(self);
                     [AppBaseHud hideHud:self.view];
                     [self.tableView.mj_header endRefreshing];
                     [self.tableView.mj_footer endRefreshing];
                     ShequDataModel *dataModel = (ShequDataModel *)responseObject;
                     
                     if (self.page == 1) {
                         [self.dataArray removeAllObjects];
                     }
                     self.page++;
                     for (ShequModel *model in dataModel.data) {
                         ShequFrameModel *frameModel = [[ShequFrameModel alloc] init];
                         frameModel.shequModel = model;
                         [self.dataArray addObject:frameModel];
                     }
                     if (dataModel.data.count) {
                         [self.tableView reloadData];
                     }
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
    
    BannerModel *bannerModel = self.bannerArray[index];
    
    if (bannerModel.view_status.integerValue == 100) {
        LogDetailController *detailController = [[LogDetailController alloc] init];
        detailController.tid = bannerModel.tid;
        [[UIViewController currentViewController].navigationController pushViewController:detailController animated:YES];
        return;
    }
    
    if (bannerModel.view_status.integerValue == 200) {
        LogDetailController *detailvc = [[LogDetailController alloc] init];
        detailvc.aid = bannerModel.aid;
        [[UIViewController currentViewController].navigationController pushViewController:detailvc animated:YES];
        return;
    }
    
    if (bannerModel.view_status.integerValue == 300) {
        
        AppWebViewController *web = [[AppWebViewController alloc] init];
        web.hidesBottomBarWhenPushed = YES;
        web.startupUrlString = bannerModel.url;
        [[UIViewController currentViewController].navigationController pushViewController:web animated:YES];
        return;
    }
    
    if (bannerModel.view_status.integerValue == 400) {
        
        MatchDetailController *web = [[MatchDetailController alloc] init];
        web.hidesBottomBarWhenPushed = YES;
        web.matchid = bannerModel.mid;
        [[UIViewController currentViewController].navigationController pushViewController:web animated:YES];
        return;
    }

}


#pragma mark-- UI

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
            
            self.groupId = @"";
            self.sortId = @"";
            
            self.groupId = ((ShequZuzhiController *)viewController).groupId;
            self.sortId = ((ShequZuzhiController *)viewController).sortId;
            
            self.title = ((ShequZuzhiController *)viewController).zuzhiModel.name;
            
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
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForNewHeader)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netforNew)];
    [self.tableView.mj_header beginRefreshing];
}



- (SDCycleScrollView *)cycleScrollView {
    
    if (_cycleScrollView == nil) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(400)) delegate:self placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _cycleScrollView;
}

- (void)buttonDidClick:(UIButton *)button {
    if (button == self.selectButton) {
        return;
    }
    
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
    if (self.selectButton.tag == 100) {
        [self.rightButton setImage:[UIImage imageNamed:@"shequ_right"]];
    } else {
        [self.rightButton setImage:[UIImage imageNamed:@""]];
    }
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    if (self.selectButton.tag == 100) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForNewHeader)];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netforNew)];

        [self netForNewHeader];
    } else if (self.selectButton.tag == 200) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForFriendHeader)];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForFriend)];

        [self netForFriendHeader];
    } else if (self.selectButton.tag == 300) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForNearHeader)];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForNear)];

        [self netForNearHeader];
    }
    
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
}

- (void)setNavigation {
    
    [self.rightButton setImage:[UIImage imageNamed:@"shequ_right"]];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AutoSize6(400), AutoSize6(68))];
    titleView.layer.borderColor = kColorDefaultColor.CGColor;
    titleView.layer.borderWidth = 1;
    titleView.layer.cornerRadius = 5;
    titleView.clipsToBounds = YES;
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleView.width / 3 - 1, titleView.height)];
    [leftButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
    [leftButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"最新" forState:UIControlStateNormal];
    [leftButton setTitle:@"最新" forState:UIControlStateSelected];
    leftButton.titleLabel.font = kFont6(24);
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.selected = YES;
    self.selectButton = leftButton;
    leftButton.tag = 100;
    [titleView addSubview:leftButton];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(leftButton.right, 0, 1, titleView.height)];
    line1.backgroundColor = kColorDefaultColor;
    [titleView addSubview:line1];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(leftButton.right + 1, 0, titleView.width / 3 - 1, titleView.height)];
    [rightButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
    [rightButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"关注" forState:UIControlStateNormal];
    [rightButton setTitle:@"关注" forState:UIControlStateSelected];
    rightButton.titleLabel.font = kFont6(24);
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightButton.tag = 200;
    
    [titleView addSubview:rightButton];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(rightButton.right, 0, 1, titleView.height)];
    line2.backgroundColor = kColorDefaultColor;
    [titleView addSubview:line2];
    
    UIButton *scolreButton = [[UIButton alloc] initWithFrame:CGRectMake(rightButton.right + 1, 0, titleView.width / 3 - 1, titleView.height)];
    [scolreButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
    [scolreButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
    [scolreButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [scolreButton setTitle:@"附近" forState:UIControlStateNormal];
    [scolreButton setTitle:@"附近" forState:UIControlStateSelected];
    scolreButton.titleLabel.font = kFont6(24);
    [scolreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [scolreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    scolreButton.tag = 300;
    
    [titleView addSubview:scolreButton];
    
    self.navigationItem.titleView = titleView;
}

@end
