//
//  LogDetailController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogDetailController.h"
#import "DetailDao.h"
#import "LogDetailHeadView.h"
#import "LogDetailBirdCell.h"
#import "LogContentCell.h"
#import "MJRefresh.h"
#import "LogDetailTalkModel.h"
#import "LogDeatilTalkCell.h"
#import "LogDetailHeadCell.h"
#import "LogDetailUpModel.h"
#import "LogContentModel.h"
#import "LogContentSubjectCell.h"
#import "UserDao.h"
#import "DiscoverDao.h"
#import "PublishEditViewController.h"
#import "PublishDao.h"
#import "MWPhotoBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DasaiTougaoViewController.h"
#import "BirdDetailController.h"


#import "JXPagerView.h"
#import "JXCategoryView.h"
#import "TestListBaseView.h"
#import "JXPagerListRefreshView.h"
#import "JXCategoryTitleImageView.h"


@interface LogDetailController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, MWPhotoBrowserDelegate>

// 日志
@property (nonatomic, strong) LogDetailModel *detailModel;

// 文章
@property (nonatomic, strong) LogContentModel *contentModel;


@property (nonatomic, strong) LogDetailHeadView *headerView;


@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UIView *toolView;

@property (nonatomic, strong) UIView *talkView;

@property (nonatomic, strong) UIButton *collectButton;

@property (nonatomic, strong) UIButton *likeButton;


@property (nonatomic, strong) AppPlaceHolderTextView *talkTextField;


@property (nonatomic, assign) NSInteger page;

// 是否正在请求
@property (nonatomic, assign) NSInteger isRequesting;


// 评论
@property (nonatomic, strong) NSMutableArray *dataArray;

// 赞
@property (nonatomic, strong) NSMutableArray *headArray;


// 评论总数
@property (nonatomic, copy) NSString *count;

@property (nonatomic, strong) NSMutableArray *photoArray;


@property (nonatomic, copy) NSString *placeString;

// 楼层
@property (nonatomic, copy) NSString *pid;

@end

@implementation LogDetailController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.isRequesting = NO;
        _photoArray = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableView];
    
    if (self.tid.length) {
        [self netForLogDetail];
        
    } else if (self.aid.length) {
        [self netForLogContent];
    }
}

#pragma mark-- tabelView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 4;
    }
    if (section == 1) {
        if (self.tid.length) {
            return self.detailModel.postBody.count;
        } else if (self.aid.length) {
            return self.contentModel.articleList.count + 2;
        }
    }
    
    if (section == 2) { // 头像列表
        return 1;
    }
    
    if (section == 3) {
        return self.dataArray.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    UITableViewCell *cell;
    if (section == 0) {
        LogDetailBirdCell *birdcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogDetailBirdCell class]) forIndexPath:indexPath];
        if (row == 0) {
            birdcell.birdArray = self.detailModel.birdInfo;
        } else if (row == 1) {
            birdcell.location = self.detailModel.locale;
        } else if (row == 2) {
            birdcell.time = [[AppDateManager shareManager] getDateWithTime:self.detailModel.publishTime formatSytle:DateFormatYMD];
        } else if (row == 3) {
            birdcell.evHuanjing = self.detailModel.environment;
        }
        cell = birdcell;
    } else if (section == 1) {
        if (self.aid.length) {
            if (row == 0) {
                LogContentSubjectCell *birdcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogContentSubjectCell class]) forIndexPath:indexPath];
                birdcell.title = [NSString stringWithFormat:@"责任编辑:%@", self.contentModel.author];
                birdcell.detail = [NSString stringWithFormat:@"作者：%@", self.contentModel.origina];
                cell = birdcell;
            } else if (row == (self.contentModel.articleList.count + 1)) {
                LogContentSubjectCell *birdcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogContentSubjectCell class]) forIndexPath:indexPath];
                if (!self.contentModel.from.length) {
                    self.contentModel.from = @" ";
                }
                birdcell.title = [NSString stringWithFormat:@"来源:%@", self.contentModel.from];
                birdcell.detail = @"";
                cell = birdcell;
            } else {
                LogContentCell *birdcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogContentCell class]) forIndexPath:indexPath];

                if (self.contentModel.articleList.count + 1 > row) {
                    birdcell.contentModel = self.contentModel.articleList[row - 1];
                }
                
                birdcell.selectBlock = ^(LogPostBodyModel *selectModel) {
                    
                    
                    NSInteger index = 0;
                    for (int i = 0; i < self.photoArray.count; i++) {
                        MWPhoto *photoModel = self.photoArray[i];
                        if ([selectModel.imgUrl isEqualToString:[photoModel.photoURL absoluteString]]) {
                            index = i;
                            break;
                        }
                    }
                    
                    BOOL displayActionButton = YES;
                    BOOL displaySelectionButtons = NO;
                    BOOL displayNavArrows = NO;
                    BOOL enableGrid = YES;
                    BOOL startOnGrid = NO;
                    BOOL autoPlayOnAppear = NO;
                    
                    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
                    browser.displayActionButton = displayActionButton;
                    browser.displayNavArrows = displayNavArrows;
                    browser.displaySelectionButtons = displaySelectionButtons;
                    browser.alwaysShowControls = displaySelectionButtons;
                    browser.zoomPhotosToFill = YES;
                    browser.enableGrid = enableGrid;
                    browser.startOnGrid = startOnGrid;
                    browser.enableSwipeToDismiss = NO;
                    browser.autoPlayOnAppear = autoPlayOnAppear;
                    [browser setCurrentPhotoIndex:index];
                    [[UIViewController currentViewController].navigationController pushViewController:browser animated:YES];
                    
                };
                
                cell = birdcell;
            }
        } else {
            LogContentCell *birdcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogContentCell class]) forIndexPath:indexPath];
            if (self.tid.length) {
                if (self.detailModel.postBody.count > row) {
                    
                    LogPostBodyModel *contentModel = self.detailModel.postBody[row];
                    contentModel.content = [contentModel.message copy];
                    birdcell.contentModel = contentModel;
                }
            }
            
            birdcell.selectBlock = ^(LogPostBodyModel *selectModel) {
                
                NSInteger index = 0;
                for (int i = 0; i < self.photoArray.count; i++) {
                    MWPhoto *photoModel = self.photoArray[i];
                    if ([selectModel.imgUrl isEqualToString:[photoModel.photoURL absoluteString]]) {
                        index = i;
                        break;
                    }
                }
                
                BOOL displayActionButton = YES;
                BOOL displaySelectionButtons = NO;
                BOOL displayNavArrows = NO;
                BOOL enableGrid = YES;
                BOOL startOnGrid = NO;
                BOOL autoPlayOnAppear = NO;
                
                MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
                browser.displayActionButton = displayActionButton;
                browser.displayNavArrows = displayNavArrows;
                browser.displaySelectionButtons = displaySelectionButtons;
                browser.alwaysShowControls = displaySelectionButtons;
                browser.zoomPhotosToFill = YES;
                browser.enableGrid = enableGrid;
                browser.startOnGrid = startOnGrid;
                browser.enableSwipeToDismiss = NO;
                browser.autoPlayOnAppear = autoPlayOnAppear;
                [browser setCurrentPhotoIndex:index];
                [[UIViewController currentViewController].navigationController pushViewController:browser animated:YES];
                
            };
            
            cell = birdcell;
        }
    } else if (section == 2) {
        
        LogDetailHeadCell *birdcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogDetailHeadCell class]) forIndexPath:indexPath];
        birdcell.dataArray = self.headArray;
        cell = birdcell;

    } else if (section == 3) {
        LogDeatilTalkCell *birdcell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LogDeatilTalkCell class]) forIndexPath:indexPath];
        if (self.dataArray.count > row) {
            birdcell.bodyModel = self.dataArray[row];
        }
        birdcell.huifuBlock = ^(LogDetailTalkModel *bodyModel) {
            self.placeString = [NSString stringWithFormat:@"@%@:", bodyModel.userName];
            self.pid = bodyModel.pid;
            [self talkButtonDidClick:nil];
        };
        cell = birdcell;
    }

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    // 文章详情没有四条要素  但是多了 作者 和 来源
    
    if (section == 0) {
        if (row == 0) {
            return self.detailModel.birdInfo.count ? AutoSize6(94) : 0.0f;
        }
        
        if (row == 1) {
//            return self.detailModel.locale.length ? AutoSize6(94) : 0.0f;
            return self.detailModel.birdInfo.count ? AutoSize6(94) : 0.0f;
        }
        
        if (row == 2) {
//            return self.detailModel.publishTime.length ? AutoSize6(94) : 0.0f;
            return self.detailModel.birdInfo.count ? AutoSize6(94) : 0.0f;
        }
        
        if (row == 3) {
            return self.detailModel.birdInfo.count ? AutoSize6(94) : 0.0f;
        }
    }

    if (section == 1) {
        
        if (self.tid.length) {
            if (self.detailModel.postBody.count > row) {
                return [LogContentCell getHeightWithContentModel:self.detailModel.postBody[row]];
            }
            
        } else if (self.aid.length) {
            
            if (row == 0) {
                return self.contentModel.origina.length ? AutoSize6(80) : 0;
            }

            if (row == (self.contentModel.articleList.count + 1)) {
                return self.contentModel.from.length ? AutoSize6(80) : 0;
            }
            
            if (self.contentModel.articleList.count + 1 > row) {
                return [LogContentCell getHeightWithContentModel:self.contentModel.articleList[row -1]];
            }
        }
    }
    
    if (section == 2) {
        if (self.headArray.count) {
            return [LogDetailHeadCell getHeight:self.dataArray];
        }
    }
    
    if (section == 3) {
        if (self.dataArray.count) {
            return [LogDeatilTalkCell getHeightWithModel:self.dataArray[row]];
        }
    }
    
    return AutoSize6(0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        if (self.detailModel.birdInfo.count ) {
            return AutoSize6(20);
        }
        return 0.01f;
    }
    
    if (section == 1) {
        
        if (self.tid.length) {
            if (self.detailModel.postBody.count ) {
                return AutoSize6(20);
            }
        }
        
        if (self.aid.length) {
            if (self.contentModel.articleList.count) {
                return AutoSize6(20);
            }
        }
        
        return 0.01f;
    }
    
    if (section == 2) {
        return AutoSize6(20);
    }
    
    if (section == 3) {
        if (self.dataArray.count) {
            return AutoSize6(60);
        }
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(60))];
        backView.clipsToBounds = YES;
        backView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(35), AutoSize6(400), AutoSize6(25))];
        
        label1.text = [NSString stringWithFormat:@"已有%@人评论过", self.count];
        label1.textAlignment = NSTextAlignmentLeft;
        label1.textColor = kColorTextColorLightGraya2a2a2;
        label1.font = kFont6(22);
        [backView addSubview:label1];
        
        return backView;
        
    }
    
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section == 0) && (indexPath.row == 0)) {
        BirdDetailController *detail = [[BirdDetailController alloc] init];
        
        LogBirdInfoModel * birdModel = self.detailModel.birdInfo.firstObject;
        detail.cspCode = birdModel.csp_code;
        [self.navigationController pushViewController:detail animated:YES];
    }
}

- (void)netForLogDetail {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [DetailDao getLogDetail:self.tid successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        
        [self netForTalkList];
        [self netforUplist];
        LogDetailModel *detailModel = (LogDetailModel *)responseObject;

        for (LogPostBodyModel *worksModel in detailModel.postBody) {
            MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:worksModel.imgUrl]];
            photo.caption = worksModel.imgTag;
            photo.iconUrl = detailModel.authorHead;
            photo.name = detailModel.author;
            photo.imgExifLen = worksModel.imgExifLen;
            photo.imgExifModel = worksModel.imgExifModel;
            photo.imgExifParameter = worksModel.imgExifParameter;
            photo.shareImg = worksModel.shareImg;
            photo.shareUrl = worksModel.shareUrl;
            photo.shareTitle = worksModel.shareTitle;
            photo.shareSummary = worksModel.shareSummary;
            photo.tid = worksModel.aid;
            photo.uid = detailModel.authorid;
            [self.photoArray addObject:photo];
        }
        
        
        self.collectButton.selected = detailModel.isCollection;
        self.likeButton.selected = detailModel.isUp;
        
        if ([detailModel.authorid isEqualToString:[UserPage sharedInstance].uid]) {
            [self setRightButton];
        }
        
        self.tableView.tableHeaderView = self.headerView;
        self.headerView.detailModel = detailModel;
        self.headerView.height = [self.headerView getHeight];

        self.detailModel = detailModel;
        [self.tableView reloadData];
        
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (void)netForLogContent {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [DetailDao getLogContent:self.aid successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        
        [self netForTalkList];
        [self netforUplist];
        
        LogContentModel *contentModel = (LogContentModel *)responseObject;
        
        for (LogPostBodyModel *worksModel in contentModel.articleList) {
            MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:worksModel.imgUrl]];
            photo.caption = worksModel.imgTag;
            photo.iconUrl = contentModel.head;
            photo.name = contentModel.author;
            photo.imgExifLen = worksModel.imgExifLen;
            photo.imgExifModel = worksModel.imgExifModel;
            photo.imgExifParameter = worksModel.imgExifParameter;
            photo.shareImg = worksModel.shareImg;
            photo.shareUrl = worksModel.shareUrl;
            photo.shareTitle = worksModel.shareTitle;
            photo.shareSummary = worksModel.shareSummary;
            photo.tid = worksModel.aid;
            [self.photoArray addObject:photo];
        }

        
        self.collectButton.selected = contentModel.isCollection;
        self.likeButton.selected = contentModel.isUp;
        
        self.tableView.tableHeaderView = self.headerView;
        self.headerView.contentModel = contentModel;
        self.headerView.height = [self.headerView getHeight];
        
        self.contentModel = contentModel;
        [self.tableView reloadData];
        
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}


- (void)netForTalkList {
    
    @weakify(self);
    [DetailDao getLogDetail:self.tid aid:self.aid page:[NSString stringWithFormat:@"%ld", self.page] successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
        self.page ++;
        
        if (self.tid.length) {
            LogDetailTalkDataModel *dataModel = (LogDetailTalkDataModel *)responseObject;
            self.count = dataModel.count;
            if (dataModel.commentList.count) {
                [self.dataArray addObjectsFromArray: dataModel.commentList];
            } else {
                [self.tableView.mj_footer removeFromSuperview];
                self.tableView.tableFooterView = self.footerView;
            }
        } else if (self.aid.length) {
            LogDetailTalkWordDataModel *dataModel = (LogDetailTalkWordDataModel *)responseObject;
            if (dataModel.data.count) {
                [self.dataArray addObjectsFromArray: dataModel.data];
                self.count = ((LogDetailTalkModel *)self.dataArray.firstObject).aCount;
            } else {
                [self.tableView.mj_footer removeFromSuperview];
                self.tableView.tableFooterView = self.footerView;
            }
        }
    
        [self.tableView reloadData];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
        [self.tableView.mj_footer endRefreshing];
        self.tableView.tableFooterView = self.footerView;


    }];
}

- (void)netforUplist {
    
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [DetailDao getLogUPDetail:self.tid aid:self.aid successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        LogDetailUpDataModel *dataModel = (LogDetailUpDataModel *)responseObject;
        
        self.headArray = [NSMutableArray new];
        
        [self.headArray addObjectsFromArray:dataModel.data];
        [self.tableView reloadData];
        
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

#pragma mark--- UI

- (void)setNavigation {
    if (self.tid.length) {
        if (self.logType == 1) {
            self.title = @"观鸟记录";
        } else {
            self.title = @"日志详情";
        }
    } else {
        self.title = @"文章详情";
    }

    self.page = 1;
    self.dataArray = [NSMutableArray new];
}

- (void)setRightButton {
    
    self.rightButton.title = @"操作";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    
}

- (void)rightButtonAction {
    
    UIActionSheet *actionsheet03 = [[UIActionSheet alloc] initWithTitle:@"操作" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"编辑", @"删除", @"投稿", @"分享",@"举报", nil];
    [actionsheet03 showInView:self.view];
}

// UIActionSheetDelegate实现代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
        if (0 == buttonIndex) {
            
            [AppBaseHud showHudWithLoding:self.view];
            @weakify(self);
            [PublishDao caogaoDetail:self.tid SuccessBlock:^(__kindof AppBaseModel *responseObject) {
                [AppBaseHud hideHud:self.view];
                MinePublishModel *model = (MinePublishModel *)responseObject;
                
                PublishEditViewController *editvc = [[PublishEditViewController alloc] init];
                editvc.minePublishModel = model;
                editvc.tid = self.tid;
                editvc.fromType = 1;
                [[UIViewController currentViewController].navigationController pushViewController:editvc animated:YES];
                
            } failureBlock:^(__kindof AppBaseModel *error) {
                @strongify(self);
                [AppBaseHud showHudWithfail:error.errstr view:self.view];
            }];
        } else if (1 == buttonIndex) {
            
            [AppBaseHud showHudWithLoding:self.view];
            @weakify(self);
            [DetailDao getDeleteDetail:self.tid successBlock:^(__kindof AppBaseModel *responseObject) {
                @strongify(self);
                [AppBaseHud showHudWithSuccessful:@"删除成功" view:self.view block:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                
            } failureBlock:^(__kindof AppBaseModel *error) {
                @strongify(self);
                [AppBaseHud showHudWithfail:error.errstr view:self.view];
            }];
            
          
        } else if (2 == buttonIndex) {
            DasaiTougaoViewController *vc = [[DasaiTougaoViewController alloc] init];
            vc.tid = self.tid;
            [self.navigationController pushViewController:vc animated:YES];
            
        } else if (3 == buttonIndex) {
            
            [AppShareManager shareWithTitle:self.detailModel.shareTitle summary:self.detailModel.shareSummary url:self.detailModel.shareUrl image:self.detailModel.shareImg];
            
        } else if (4 == buttonIndex) {
            [AppBaseHud showHudWithLoding:self.view];
            [DetailDao getDetailReport:self.tid SuccessBlock:^(__kindof AppBaseModel *responseObject) {
                [AppBaseHud showHudWithSuccessful:@"举报成功" view:self.view];
            } failureBlock:^(__kindof AppBaseModel *error) {
                [AppBaseHud showHudWithfail:@"举报失败" view:self.view];
            }];
        }
}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height - AutoSize6(98);
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LogDetailBirdCell class] forCellReuseIdentifier:NSStringFromClass([LogDetailBirdCell class])];
    [self.tableView registerClass:[LogContentCell class] forCellReuseIdentifier:NSStringFromClass([LogContentCell class])];
    [self.tableView registerClass:[LogDeatilTalkCell class] forCellReuseIdentifier:NSStringFromClass([LogDeatilTalkCell class])];
    [self.tableView registerClass:[LogDetailHeadCell class] forCellReuseIdentifier:NSStringFromClass([LogDetailHeadCell class])];
    [self.tableView registerClass:[LogContentSubjectCell class] forCellReuseIdentifier:NSStringFromClass([LogContentSubjectCell class])];

    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForTalkList)];
    
    self.toolView = [self makeToolView];
    
    self.talkView = [self makeTalkView];
}

- (LogDetailHeadView *)headerView {
    if (!_headerView) {
        _headerView = [[LogDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(300))];
    }
    return _headerView;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(400))];
        _footerView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(100), AutoSize6(78), AutoSize6(174), AutoSize6(115))];
        icon.image = [UIImage imageNamed:@"detail_no_talk"];
        icon.contentMode = UIViewContentModeCenter;
        [_footerView addSubview:icon];
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(icon.right + AutoSize6(15), AutoSize6(78), AutoSize6(400), AutoSize6(50))];
        label1.text = @"抢沙发的机会只有一次，";
        label1.textAlignment = NSTextAlignmentLeft;
        label1.textColor = kColorTextColorLightGraya2a2a2;
        label1.font = kFont6(30);
        [_footerView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(icon.right + AutoSize6(15), label1.bottom + AutoSize6(10), AutoSize6(400), AutoSize6(50))];
        label2.text = @"你还在等什么?";
        label2.textAlignment = NSTextAlignmentLeft;
        label2.textColor = kColorTextColorLightGraya2a2a2;
        label2.font = kFont6(30);
        [_footerView addSubview:label2];
    }
    return _footerView;
}


- (UIView *)makeToolView {
    
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - AutoSize6(98), SCREEN_WIDTH, AutoSize6(98))];
    toolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolView];
    [self.view bringSubviewToFront:toolView];
    
    CGFloat width = SCREEN_WIDTH / 4;
    
    [toolView addSubview:[UIFactory buttonWithFrame:CGRectMake(0, 0, width, toolView.height)
                                             target:self
                                              image:@"operat_big_icon_forward"
                                        selectImage:@"operat_big_icon_forward"
                                              title:@"转发"
                                             action:@selector(zhuanfaButtonDidClick:)]];
    
    self.collectButton = [UIFactory buttonWithFrame:CGRectMake(width, 0, width, toolView.height)
                                             target:self
                                              image:@"operat_big_icon_collect"
                                        selectImage:@"operat_big_icon_collected"
                                              title:@"收藏"
                                             action:@selector(collectButtonDidClick:)];
    [toolView addSubview:self.collectButton];
    
    [toolView addSubview:[UIFactory buttonWithFrame:CGRectMake(width * 2, 0, width, toolView.height)
                                             target:self
                                              image:@"operat_big_icon_comment"
                                        selectImage:@"operat_big_icon_comment"
                                              title:@"评论"
                                             action:@selector(talkButtonDidClick:)]];
    
    self.likeButton = [UIFactory buttonWithFrame:CGRectMake(width * 3, 0, width, toolView.height)
                                             target:self
                                              image:@"operat_big_icon_like"
                                        selectImage:@"operat_big_icon_liked"
                                              title:@"赞"
                                             action:@selector(upButtonDidClick:)];
    [toolView addSubview:self.likeButton];
    
    return toolView;
}

- (void)zhuanfaButtonDidClick:(UIButton *)button {
    
    if (self.tid.length) {
        [AppShareManager shareWithTitle:self.detailModel.shareTitle summary:self.detailModel.shareSummary url:self.detailModel.shareUrl image:self.detailModel.shareImg];
    } else if (self.aid.length) {
        [AppShareManager shareWithTitle:self.contentModel.shareTitle summary:self.contentModel.shareSummary url:self.contentModel.shareUrl image:self.contentModel.shareImg];
    }

}

- (void)collectButtonDidClick:(UIButton *)button {
    
    NSString *stringId;
    if (self.aid.length) {
        stringId = self.aid;
    } else if (self.tid.length) {
        stringId = self.tid;
    }
    
    [UserDao userCollect:stringId successBlock:^(__kindof AppBaseModel *responseObject) {
        button.selected = !button.selected;
    } failureBlock:^(__kindof AppBaseModel *error) {
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];

}

- (void)talkButtonDidClick:(UIButton *)button {
    
    self.placeString = button ? @"写一条高能评论": self.placeString;
    self.pid = button ? nil : self.pid;
    
    [self registerForKeyboardNotifications];
    self.toolView.hidden = YES;
    self.talkView.hidden = NO;
    [self.talkTextField becomeFirstResponder];
    self.talkTextField.placeholder = self.placeString;
}

- (void)upButtonDidClick:(UIButton *)button {
    NSString *stringId;
    if (self.aid.length) {
        stringId = self.aid;
    } else if (self.tid.length) {
        stringId = self.tid;
    }
    
    [UserDao userUp:stringId successBlock:^(__kindof AppBaseModel *responseObject) {
        button.selected = !button.selected;
        [AppBaseHud showHudWithSuccessful:@"点赞成功" view:self.view];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillChangeFrameNotification object:nil];
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShown:(NSNotification*)aNotification {
    NSDictionary *info = [aNotification userInfo];
    
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGSize keyboardSize = [value CGRectValue].size;

    //输入框位置动画加载
    [UIView animateWithDuration:duration animations:^{
        
        self.talkView.top = self.view.height - keyboardSize.height + AutoSize6(20);
    }];
    
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    self.toolView.hidden = NO;
    self.talkView.hidden = YES;
}

- (void)sendButtonDidClick {
    [self.talkTextField resignFirstResponder];
    
    NSString *stringId;
    if (self.aid.length) {
        stringId = self.aid;
    } else if (self.tid.length) {
        stringId = self.tid;
    }
    [DiscoverDao talkWithTid:stringId content:self.talkTextField.text pid:self.pid successBlock:^(__kindof AppBaseModel *responseObject) {

    } failureBlock:^(__kindof AppBaseModel *error) {
        
    }];
    self.talkTextField.text = nil;

}


- (UIView *)makeTalkView {
    UIView *talkView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, AutoSize6(102))];
    talkView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:talkView];
    [self.view bringSubviewToFront:talkView];
    
    AppPlaceHolderTextView *textFieled = [[AppPlaceHolderTextView alloc] initWithFrame:CGRectMake(AutoSize6(10), AutoSize6(15), SCREEN_WIDTH - AutoSize6(16) - AutoSize6(150), talkView.height - AutoSize6(32))];
    textFieled.backgroundColor = kColoreDefaultBackgroundColor;
    textFieled.placeholder = self.placeString;
    textFieled.textColor = kColorTextColor333333;
    textFieled.layer.cornerRadius = 5;
    [talkView addSubview:textFieled];
    textFieled.tintColor = UIColorFromRGB(0x999999);
    textFieled.contentInset = UIEdgeInsetsMake(AutoSize6(6), AutoSize6(5), AutoSize6(6), AutoSize6(6));
//    CGRect frame = textFieled.frame;
//    frame.size.width = AutoSize6(20);// 距离左侧的距离
//    UIView *leftview = [[UIView alloc] initWithFrame:frame];
//    textFieled.leftViewMode = UITextFieldViewModeAlways;
//    textFieled.leftView = leftview;
    self.talkTextField = textFieled;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(textFieled.right + AutoSize6(10), textFieled.top, AutoSize6(150) - AutoSize6(20), textFieled.height)];
    [button setBackgroundColor:kColorDefaultColor];
    [talkView addSubview:button];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = kFont6(30);
    button.layer.cornerRadius = 3;
    [button addTarget:self action:@selector(sendButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    
    talkView.hidden = YES;
    return talkView;
}


#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photoArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photoArray.count)
        return [_photoArray objectAtIndex:index];
    return nil;
}
//
//- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
//    if (index < _thumbs.count)
//        return [_thumbs objectAtIndex:index];
//    return nil;
//}

- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
    MWPhoto *photo = [self.photoArray objectAtIndex:index];
    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
    return captionView;
}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}


- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
    
    MWPhoto *photo = self.photoArray[index];
    [photoBrowser.headImageview sd_setImageWithURL:[NSURL URLWithString:photo.iconUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    photoBrowser.nameLabel.text = photo.name;
    photoBrowser.countLabel.text = [NSString stringWithFormat:@"%ld/%ld", index + 1, self.photoArray.count];
    
    photoBrowser.qicaiLabel.text = [NSString stringWithFormat:@"%@  %@", @"器材", photo.imgExifModel];
    photoBrowser.jingtouLabel.text = [NSString stringWithFormat:@"%@  %@", @"镜头", photo.imgExifLen];
    photoBrowser.canshuLabel.text = [NSString stringWithFormat:@"%@  %@", @"参数", photo.imgExifParameter];
    
    
    
    return @" ";
    //    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
}


@end
