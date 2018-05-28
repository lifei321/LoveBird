//
//  DiscoverViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2018/1/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverHeaderView.h"
#import "DiscoverDataSource.h"
#import "DiscoverHeaderCell.h"
#import "TimeLineCell.h"
#import "AppHttpManager.h"
#import "MJRefresh.h"


#import "TalentViewController.h"
#import "ShequViewController.h"
#import "DasaiViewController.h"
#import "ZhuangbeiViewController.h"
#import "WorksViewController.h"
#import "RankViewController.h"

#import "LogDetailController.h"
#import "AppWebViewController.h"

#define kStringForBanner @"kStringForBanner"
#define kStringForContent @"kStringForContent"


@interface DiscoverViewController ()<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, TimeLineClickDelegate>

@property (nonatomic, strong) DiscoverDataSource *viewModel;

@property (nonatomic, strong) DiscoverHeaderView *headerView;

// 刷新页数
@property (nonatomic, assign) NSInteger pageNum;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pageNum = 0;
    
    [self setNavigation];
    
    // 设置UI
    [self setTableView];
    [self setHeaderView];
    
    // 加载本地数据
    [self  netForData];
}

- (void)setNavigation {

    self.isNavigationTransparent = YES;
    self.isCustomNavigation = YES;
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"discover_navigation"] forBarMetrics:UIBarMetricsDefault];

}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TimeLineCell class] forCellReuseIdentifier:NSStringFromClass([TimeLineCell class])];
    self.viewModel = [[DiscoverDataSource alloc] init];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForContentHeader)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForContentFooter)];
}

// 设置headerview
- (void)setHeaderView {
    DiscoverHeaderView *headerView = [[DiscoverHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, AutoSize(312))];
    headerView.cycleScrollView.delegate = self;
    headerView.collectionView.delegate = self;
    headerView.collectionView.dataSource = self;
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
}

#pragma mark-- 请求banner数据
- (void)netForData {
    if ([AppCache objectForKey:kStringForBanner]) {
        BannerDataModel *dataModel = [AppCache objectForKey:kStringForBanner];
        self.viewModel.bannerArray = [dataModel.data mutableCopy];
        self.headerView.cycleScrollView.imageURLStringsGroup = self.viewModel.cycleArray;
    }
    if ([AppCache objectForKey:kStringForContent]) {
        DiscoverContentDataModel *dataModel = [AppCache objectForKey:kStringForContent];
        for (DiscoverContentModel *model in dataModel.data) {
            TimeLineLayoutModel *lineModel = [[TimeLineLayoutModel alloc] init];
            lineModel.contentModel = model;
            [self.viewModel.dataSourceArray addObject:lineModel];
        }
    }
    // 请求网络数据
    [self netForBanner];
    [self.tableView.mj_header beginRefreshing];
}

- (void)netForBanner {
    NSDictionary *dic = @{
                          @"cmd":@"homeNavigation",
                          @"bid":@"100",
                          };
    @weakify(self);
    [AppHttpManager GET:kAPI_Discover_Banner parameters:dic jsonModelName:[BannerDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        
        BannerDataModel *dataModel = (BannerDataModel *)responseObject;
        self.viewModel.bannerArray = [dataModel.data mutableCopy];
        self.headerView.cycleScrollView.imageURLStringsGroup = self.viewModel.cycleArray;
        [AppCache setObject:dataModel forKey:kStringForBanner];

    } failure:^(__kindof AppBaseModel *error) {
        
    }];
}

- (void)netForContentHeader {
    self.pageNum = 1;

    [self netForContentWithPageNum:self.pageNum header:YES];
}
- (void)netForContentFooter {
    self.pageNum ++;
    [self netForContentWithPageNum:self.pageNum header:NO];
}
- (void)netForContentWithPageNum:(NSInteger)pageNum header:(BOOL)header {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"uid" forKey:@"483887"];
    [dic setObject:@"page" forKey:[NSString stringWithFormat:@"%ld", (long)pageNum]];

    @weakify(self);
    [AppHttpManager POST:kAPI_Discover_Content parameters:dic jsonModelName:[DiscoverContentDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        if (header) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        DiscoverContentDataModel *dataModel = (DiscoverContentDataModel *)responseObject;

        for (DiscoverContentModel *model in dataModel.data) {
            TimeLineLayoutModel *lineModel = [[TimeLineLayoutModel alloc] init];
            lineModel.contentModel = model;
            if (header) {
                [self.viewModel.dataSourceArray removeAllObjects];
            }
            [self.viewModel.dataSourceArray addObject:lineModel];

        }
        [AppCache setObject:dataModel forKey:kStringForContent];

        [self.tableView reloadData];
        
    } failure:^(__kindof AppBaseModel *error) {
        if (header) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

- (void)netForToolButton:(UIButton *)button {
    
    if (button.selected) {
        return;
    }
    NSInteger tag = button.tag;
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    if (tag == 200) { // 收藏
        [dic setObject:@"collectArticle" forKey:@"cmd"];
    } else if (tag == 400) { // 点赞
        [dic setObject:@"upArticle" forKey:@"cmd"];
    }

    [AppHttpManager GET:kAPI_Discover_Collect parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
        button.selected = YES;
    } failure:^(__kindof AppBaseModel *error) {
        
    }];
}

#pragma mark - 轮播图代理

// 图片滚动
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

// 图片点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

#pragma mark- 菜单图代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewModel.listArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DiscoverHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DiscoverHeaderCell class]) forIndexPath:indexPath];
    cell.model = _viewModel.listArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        { // 附近

        }
            break;
        case 1:
        {// 社区
            ShequViewController *shequvc = [[ShequViewController alloc] init];
            shequvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:shequvc animated:YES];
        }
            break;
        case 2:
        {// 达人
            TalentViewController *talentVC = [[TalentViewController alloc] init];
            talentVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:talentVC animated:YES];
        }
            break;
        case 3:
        {// 作品
            WorksViewController *workvc = [[WorksViewController alloc] init];
            workvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:workvc animated:YES];
        }
            break;
        case 4:
        {// 咨询
            ZhuangbeiViewController *zbvc = [[ZhuangbeiViewController alloc] init];
            zbvc.hidesBottomBarWhenPushed = YES;
            zbvc.cid = @"2";
            [self.navigationController pushViewController:zbvc animated:YES];
        }
            break;
        case 5:
        {// 装备
            ZhuangbeiViewController *zbvc = [[ZhuangbeiViewController alloc] init];
            zbvc.hidesBottomBarWhenPushed = YES;
            zbvc.cid = @"1";
            [self.navigationController pushViewController:zbvc animated:YES];
        }
            break;
        case 6:
        {// 大赛
            DasaiViewController *dasaivc = [[DasaiViewController alloc] init];
            dasaivc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:dasaivc animated:YES];
        }
            break;
        case 7:
        {// 排行
            RankViewController *dasaivc = [[RankViewController alloc] init];
            dasaivc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:dasaivc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TimeLineCell class]) forIndexPath:indexPath];
    
    cell.cellLayoutModel = self.viewModel.dataSourceArray[indexPath.row];
    cell.timeLineCellDelegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimeLineLayoutModel *layoutModel = _viewModel.dataSourceArray[indexPath.row];
    return layoutModel.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TimeLineLayoutModel *layoutModel = self.viewModel.dataSourceArray[indexPath.row];
    
    if (layoutModel.contentModel.tid.length) {
        LogDetailController *detailController = [[LogDetailController alloc] init];
        detailController.tid = layoutModel.contentModel.tid;
        [self.navigationController pushViewController:detailController animated:YES];
    } else if (layoutModel.contentModel.aid.length) {
        
    } else if (layoutModel.contentModel.webView.length) {
        AppWebViewController *web = [[AppWebViewController alloc] init];
        web.hidesBottomBarWhenPushed = YES;
        web.startupUrlString = layoutModel.contentModel.webView;
        [self.navigationController pushViewController:web animated:YES];
    }
}

#pragma mark-- cell点击代理
- (void)timeLine:(TimeLineCell *)timeLineCell didClickDelegate:(UIButton *)button {
    
    NSInteger tag = button.tag;
    if (tag == 100) { // 转发
        
    } else if (tag == 200) { // 收藏
        [self netForToolButton:button];
    } else if (tag == 300) { // 评论
        
    } else if (tag == 400) { // 点赞
        [self netForToolButton:button];
    }
}


@end
