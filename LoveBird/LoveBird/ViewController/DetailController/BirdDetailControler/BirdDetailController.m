//
//  BirdDetailController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailController.h"
#import <MJRefresh/MJRefresh.h>
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "DetailDao.h"
#import "BirdDetailModel.h"
#import "BirdDetailTextCell.h"


@interface BirdDetailController ()<SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BirdDetailModel *detailModel;

// 轮播图
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation BirdDetailController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableView];
    [self netForBirdDetail];
}

#pragma mark-- tabelView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return 4;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    BirdDetailTextCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BirdDetailTextCell class]) forIndexPath:indexPath];

    if (section == 0) {
        if (row == 0) {
            cell.title = self.detailModel.alias;
            cell.hasImage = YES;
        } else if (row == 1) {
            cell.title = self.detailModel.name;
        } else if (row == 2) {
            cell.title = self.detailModel.name_latin;
        }
    } else if (section == 1) {
        if (row == 0) {
            cell.title = @"叫声";
            cell.detail = [NSString stringWithFormat:@"%ld种", self.detailModel.song.count];
        } else if (row == 1) {
            cell.title = @"视频";
            cell.detail = [NSString stringWithFormat:@"%ld条", self.detailModel.video.count];
        } else if (row == 2) {
            cell.title = @"观察记录";
            cell.detail = [NSString stringWithFormat:@"%@条", self.detailModel.obs_times];
        } else if (row == 3) {
            cell.title = @"地域分布";
            cell.detail = @"  ";
        }
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        if (row == 0) {
            if (self.detailModel.alias.length) {
                return AutoSize6(92);
            }
        }
        if (row == 1) {
            if (self.detailModel.name.length) {
                return AutoSize6(92);
            }
        }
        if (row == 2) {
            if (self.detailModel.name_latin.length) {
                return AutoSize6(92);
            }
        }
    }
    
    if (section == 1) {
        if (row == 0) {
            if (self.detailModel.song.count) {
                return AutoSize6(92);
            }
        }
        if (row == 1) {
            if (self.detailModel.video.count) {
                return AutoSize6(92);
            }
        }
        if (row == 2) {
            if (self.detailModel.obs_times.length) {
                return AutoSize6(92);
            }
        }
        if (row == 3) {
            return AutoSize6(92);
        }
    }
    
    return AutoSize6(0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0.01f;
    }
    
    if (section == 1) {
        return AutoSize6(10);
    }
    return AutoSize6(0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01f;
    }
    
    if (section == 1) {
        return AutoSize6(10);
    }
    return AutoSize6(0);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)netForBirdDetail {
    @weakify(self);
    [DetailDao getBirdDetail:self.cspCode successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        self.detailModel = (BirdDetailModel *)responseObject;
        
        NSMutableArray *temp = [NSMutableArray new];
        for (BirdDetailImageModel *model in self.detailModel.img) {
            [temp addObject:model.img_url];
        }
        self.cycleScrollView.imageURLStringsGroup = temp;
        
        [self.tableView reloadData];

    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

#pragma mark--- UI

- (void)setNavigation {
    
    self.title = @"鸟种详情";
    self.rightButton.title = @"操作";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    
}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.cycleScrollView;
    
    [self.tableView registerClass:[BirdDetailTextCell class] forCellReuseIdentifier:NSStringFromClass([BirdDetailTextCell class])];

    
    //默认【上拉加载】
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForTalkList)];
}

- (SDCycleScrollView *)cycleScrollView {
    
    if (_cycleScrollView == nil) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(400)) delegate:nil placeholderImage:[UIImage imageNamed:@""]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}


@end
