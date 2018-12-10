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
#import "DiscoverDao.h"

#import "TalentViewController.h"
#import "ShequViewController.h"
#import "DasaiViewController.h"
#import "ZhuangbeiViewController.h"
#import "WorksViewController.h"
#import "RankViewController.h"

#import "LogDetailController.h"
#import "AppWebViewController.h"
#import "NearController.h"
#import "SearchViewController.h"
#import "MatchDetailController.h"

#define kStringForBanner @"kStringForBanner"
#define kStringForContent @"kStringForContent"


@interface DiscoverViewController ()<SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, TimeLineClickDelegate>

@property (nonatomic, strong) DiscoverDataSource *viewModel;

@property (nonatomic, strong) DiscoverHeaderView *headerView;

// 刷新页数
@property (nonatomic, assign) NSInteger pageNum;

@property (nonatomic, strong) UIView *navigationView;


@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pageNum = 0;
    
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;

    // 设置UI
    [self setTableView];
    
    if (self.type) {
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(200))];
    } else {
        
        //默认【下拉刷新】
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForContentHeader)];
        //默认【上拉加载】
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForContentFooter)];
        
        [self setHeaderView];
        
        // 加载本地数据
        [self  netForData];
    }
    
}

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 1) {
        self.navigationView.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;

//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"discover_navigation"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"discover_navigation"] forBarMetrics:UIBarMetricsDefault];
    
    [self.view addSubview:self.navigationView];
    
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:kFirstLouchString] boolValue]) {
//        
//        NearController *nearvc = [[NearController alloc] init];
//        [self.navigationController addChildViewController:nearvc];
//        [[NSUserDefaults standardUserDefaults] setObject:@(0) forKey:kFirstLouchString];
//    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.isCustomNavigation = NO;
    self.isNavigationTransparent = NO;
}

- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, total_topView_height)];
        _navigationView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *backView = [[UIImageView alloc] initWithFrame:_navigationView.bounds];
        backView.image = [UIImage imageNamed:@"discover_navigation"];
        backView.contentMode = UIViewContentModeScaleToFill;
        [_navigationView addSubview:backView];
        
        UITextField *searchField = [[UITextField alloc] initWithFrame:CGRectMake(AutoSize6(30), topView_origin_y + 5, SCREEN_WIDTH - AutoSize6(60), total_topView_height - topView_origin_y - 10)];
        searchField.placeholder = @"在此输入文章名/作者名";
        searchField.backgroundColor = [UIColor whiteColor];
        searchField.font = kFont6(26);
        searchField.layer.borderColor = (kLineColoreDefaultd4d7dd).CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.cornerRadius = 2;
        searchField.delegate = self;
        
        CGRect frame = searchField.frame;
        frame.size.width = AutoSize6(15);// 距离左侧的距离
        UIView *leftview = [[UIView alloc] initWithFrame:frame];
        searchField.leftViewMode = UITextFieldViewModeAlways;
        searchField.leftView = leftview;
        
        CGRect rightframe = searchField.frame;
        rightframe.size.width = AutoSize(35);// 距离左侧的距离
        UIImageView *rightview = [[UIImageView alloc] initWithFrame:rightframe];
        rightview.image = [UIImage imageNamed:@"pub_search"];
        rightview.contentMode = UIViewContentModeCenter;
        searchField.rightViewMode = UITextFieldViewModeAlways;
        searchField.rightView = rightview;
        [_navigationView addSubview:searchField];
    }
    return _navigationView;
}

- (void)textFieldShouldBeginEditing:(UITextField *)textField {
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[TimeLineCell class] forCellReuseIdentifier:NSStringFromClass([TimeLineCell class])];
    self.viewModel = [[DiscoverDataSource alloc] init];
}

// 设置headerview
- (void)setHeaderView {
    DiscoverHeaderView *headerView = [[DiscoverHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, AutoSize(325))];
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
        
        self.viewModel.cycleArray = [NSMutableArray new];
        
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
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:[NSString stringWithFormat:@"%ld", (long)pageNum] forKey:@"page"];

    @weakify(self);
    [AppHttpManager POST:kAPI_Discover_Content parameters:dic jsonModelName:[DiscoverContentDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        if (header) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        if (header) {
            [self.viewModel.dataSourceArray removeAllObjects];
        }

        DiscoverContentDataModel *dataModel = (DiscoverContentDataModel *)responseObject;

        for (DiscoverContentModel *model in dataModel.data) {
            TimeLineLayoutModel *lineModel = [[TimeLineLayoutModel alloc] init];
            lineModel.contentModel = model;
            [self.viewModel.dataSourceArray addObject:lineModel];

        }
        [AppCache setObject:dataModel forKey:kStringForContent];

        if (dataModel.data.count) {
            [self.tableView reloadData];
        }
    } failure:^(__kindof AppBaseModel *error) {
        if (header) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - 轮播图代理

// 图片滚动
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

// 图片点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    BannerModel *bannerModel = self.viewModel.bannerArray[index];
    
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
            NearController *nearvc = [[NearController alloc] init];
            [self.navigationController pushViewController:nearvc animated:YES];
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
    
    if (layoutModel.contentModel.article_status == 100) {
        LogDetailController *detailController = [[LogDetailController alloc] init];
        detailController.tid = layoutModel.contentModel.tid;
        [[UIViewController currentViewController].navigationController pushViewController:detailController animated:YES];
        
    } else if (layoutModel.contentModel.article_status == 200) {
        LogDetailController *detailvc = [[LogDetailController alloc] init];
        detailvc.aid = layoutModel.contentModel.aid;
        [[UIViewController currentViewController].navigationController pushViewController:detailvc animated:YES];
    } else if (layoutModel.contentModel.article_status == 300) {
        
        AppWebViewController *web = [[AppWebViewController alloc] init];
        web.hidesBottomBarWhenPushed = YES;
        web.startupUrlString = layoutModel.contentModel.webView;
        [[UIViewController currentViewController].navigationController pushViewController:web animated:YES];
    }
}

#pragma mark-- cell点击代理
- (void)timeLine:(TimeLineCell *)timeLineCell didClickDelegate:(UIButton *)button {
    
    NSInteger tag = button.tag;
    if (tag == 100) { // 转发
        DiscoverContentModel *contentModel = timeLineCell.cellLayoutModel.contentModel;
        
        [AppShareManager shareWithTitle:contentModel.shareTitle summary:contentModel.shareSummary url:contentModel.shareUrl image:contentModel.shareImg];
        
    } else if (tag == 200) { // 收藏
        NSString *stringId;
        if (timeLineCell.cellLayoutModel.contentModel.article_status == 100) {
            stringId = timeLineCell.cellLayoutModel.contentModel.tid;
        }else if (timeLineCell.cellLayoutModel.contentModel.article_status == 200) {
            stringId = timeLineCell.cellLayoutModel.contentModel.aid;
        }
        
        [UserDao userCollect:stringId successBlock:^(__kindof AppBaseModel *responseObject) {
            button.selected = !button.selected;
        } failureBlock:^(__kindof AppBaseModel *error) {
            [AppBaseHud showHudWithfail:error.errstr view:self.view];
        }];
    } else if (tag == 300) { // 评论
        
        TimeLineLayoutModel *layoutModel = timeLineCell.cellLayoutModel;
        
        if (layoutModel.contentModel.article_status == 100) {
            LogDetailController *detailController = [[LogDetailController alloc] init];
            detailController.tid = layoutModel.contentModel.tid;
            [[UIViewController currentViewController].navigationController pushViewController:detailController animated:YES];
            return;
        }
        
        if (layoutModel.contentModel.article_status == 300) {
            
            AppWebViewController *web = [[AppWebViewController alloc] init];
            web.hidesBottomBarWhenPushed = YES;
            web.startupUrlString = layoutModel.contentModel.webView;
            [[UIViewController currentViewController].navigationController pushViewController:web animated:YES];
            return;
        }
        
        if (layoutModel.contentModel.article_status == 200) {
            LogDetailController *detailvc = [[LogDetailController alloc] init];
            detailvc.aid = layoutModel.contentModel.aid;
            [[UIViewController currentViewController].navigationController pushViewController:detailvc animated:YES];
            return;
        }
        

    } else if (tag == 400) { // 点赞
        if (button.selected) {
            [AppBaseHud showHudWithfail:@"已赞" view:self.view];
            return;
        }
        
        NSString *stringId;
        if (timeLineCell.cellLayoutModel.contentModel.article_status == 100) {
            stringId = timeLineCell.cellLayoutModel.contentModel.tid;
        }else if (timeLineCell.cellLayoutModel.contentModel.article_status == 200) {
            stringId = timeLineCell.cellLayoutModel.contentModel.aid;
        }
        
        [UserDao userUp:stringId successBlock:^(__kindof AppBaseModel *responseObject) {
            button.selected = !button.selected;
            [AppBaseHud showHudWithSuccessful:@"点赞成功" view:self.view];

        } failureBlock:^(__kindof AppBaseModel *error) {
            [AppBaseHud showHudWithfail:error.errstr view:self.view];
        }];
    }
}


#pragma mark-- 全局搜索设置
- (void)setWord:(NSString *)word {
    _word = [word copy];
    [self netForSearchData];
}

- (void)netForSearchData {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [DiscoverDao getHuaTiList:self.word successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        DiscoverContentDataModel *dataModel = (DiscoverContentDataModel *)responseObject;
        
        for (DiscoverContentModel *model in dataModel.data) {
            TimeLineLayoutModel *lineModel = [[TimeLineLayoutModel alloc] init];
            lineModel.contentModel = model;
            [self.viewModel.dataSourceArray addObject:lineModel];
            
        }
        [AppCache setObject:dataModel forKey:kStringForContent];
        
        [self.tableView reloadData];
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}


@end
