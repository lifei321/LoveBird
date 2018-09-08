//
//  WorksViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "WorksViewController.h"
#import "WorksModel.h"
#import "DiscoverDao.h"
#import <MJRefresh/MJRefresh.h>
#import "WorkTableViewCell.h"
#import "UIImage+Addition.h"
#import "MWPhotoBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface WorksViewController ()<UITableViewDelegate, UITableViewDataSource, MWPhotoBrowserDelegate>

// 刷新页数
@property (nonatomic, copy) NSString *minId;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) NSMutableArray *photoArray;

@end

@implementation WorksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.minId = @"";
    self.type = @"100";
    
    _dataArray = [NSMutableArray new];
    _photoArray = [NSMutableArray new];

    [self setNavigation];
    
    // 设置UI
    [self setTableView];
    
    [self netForContentHeader];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (self.from.length) {
        self.tableView.frame = self.view.bounds;
    }
}

- (void)netForContentHeader {
    self.minId = @"";
    
    [self netForContentWithPageNum:self.minId header:YES];
}
- (void)netForContentFooter {
    [self netForContentWithPageNum:self.minId header:NO];
}
- (void)netForContentWithPageNum:(NSString *)minid header:(BOOL)header {
    
    if ([self.minId isEqualToString:@"0"]) {
        [self.tableView.mj_footer endRefreshing];
        return;
    }
    @weakify(self);
    [DiscoverDao getWorksList:self.authorId matchid:self.matchid minAid:minid type:self.type successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        if (header) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
        WorksDataModel *dataModel = (WorksDataModel *)responseObject;
        self.minId = dataModel.maxAid;
        if (header) {
            [self.dataArray removeAllObjects];
            [self.photoArray removeAllObjects];
        }
        if (dataModel.imgList.count) {
            NSMutableArray *tempArray = [NSMutableArray new];
            for (NSArray *array in dataModel.imgList) {
                NSArray *modelArray = [WorksModel arrayOfModelsFromDictionaries:array error:nil];
                [tempArray addObject:modelArray];
                
                for (WorksModel *worksModel in modelArray) {
                    MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:worksModel.imgUrl]];
                    photo.caption = worksModel.tags;
                    photo.iconUrl = worksModel.head;
                    photo.name = worksModel.author;
                    photo.imgExifLen = worksModel.imgExifLen;
                    photo.imgExifModel = worksModel.imgExifModel;
                    photo.imgExifParameter = worksModel.imgExifParameter;
                    photo.shareImg = worksModel.shareImg;
                    photo.shareUrl = worksModel.shareUrl;
                    photo.shareTitle = worksModel.shareTitle;
                    photo.shareSummary = worksModel.shareSummary;
                    photo.tid = worksModel.tid;
                    [self.photoArray addObject:photo];
                }
            }
            [self.dataArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
        }
        
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
    WorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WorkTableViewCell class]) forIndexPath:indexPath];
    
    cell.listArray = self.dataArray[indexPath.row];
    
    cell.selectBlock = ^(WorksModel *selectModel) {
        
        
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
    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray *listArray = self.dataArray[indexPath.row];
    if (listArray.count == 1) {
        WorksModel *model = listArray.firstObject;
        CGFloat imageHeight = (model.imgHeight) * (SCREEN_WIDTH / model.imgWidth);
        return imageHeight + 1;
        
    } else if (listArray.count == 2) {
        WorksModel *model1 = listArray.firstObject;
        WorksModel *model2 = listArray.lastObject;
        
        CGFloat width1 = SCREEN_WIDTH * (model1.imgWidth / (model1.imgWidth + model2.imgWidth));
        
        CGFloat imageHeight = (model1.imgHeight) * (width1 / model1.imgWidth);
        return imageHeight + 1;
    }
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.from.length) {
        return 0.01f;
    }
    return AutoSize6(20);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    WorkTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    if (cell.selectBlock) {
//        cell.selectBlock(cell.)
//    }
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


- (void)buttonDidClick:(UIButton *)button {
    if (button == self.selectButton) {
        return;
    }
    
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    self.type = [NSString stringWithFormat:@"%ld", self.selectButton.tag];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setNavigation {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AutoSize6(270), AutoSize6(68))];
    titleView.layer.borderColor = kColorDefaultColor.CGColor;
    titleView.layer.borderWidth = 1;
    titleView.layer.cornerRadius = 5;
    titleView.clipsToBounds = YES;
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleView.width / 2, titleView.height)];
    [leftButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
    [leftButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setTitle:@"精品" forState:UIControlStateNormal];
    [leftButton setTitle:@"精品" forState:UIControlStateSelected];
    leftButton.titleLabel.font = kFont6(24);
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.selected = YES;
    self.selectButton = leftButton;
    leftButton.tag = 100;
    [titleView addSubview:leftButton];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(leftButton.right, 0, titleView.width / 2, titleView.height)];
    [rightButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
    [rightButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"最新" forState:UIControlStateNormal];
    [rightButton setTitle:@"最新" forState:UIControlStateSelected];
    rightButton.titleLabel.font = kFont6(24);
    rightButton.tag = 200;

    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleView addSubview:rightButton];
    
    self.navigationItem.titleView = titleView;
    
    
}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[WorkTableViewCell class] forCellReuseIdentifier:NSStringFromClass([WorkTableViewCell class])];
    
    //默认【下拉刷新】
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForContentHeader)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForContentFooter)];
}

@end
