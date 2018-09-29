//
//  UserPhotoTbleView.m
//  LoveBird
//
//  Created by cheli shan on 2018/9/14.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "UserPhotoTbleView.h"

#import "WorksModel.h"
#import "DiscoverDao.h"
#import "MJRefresh.h"
#import "WorkTableViewCell.h"
#import "UIImage+Addition.h"
#import "MWPhotoBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>



@interface UserPhotoTbleView ()<UITableViewDelegate, UITableViewDataSource, MWPhotoBrowserDelegate>

// 刷新页数
@property (nonatomic, copy) NSString *pageNum;

@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, strong) NSMutableArray *photoArray;



@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;

@end

@implementation UserPhotoTbleView

- (void)dealloc
{
    self.scrollCallback = nil;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        self.tableView.backgroundColor = kColoreDefaultBackgroundColor;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.tableFooterView = [UIView new];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerClass:[WorkTableViewCell class] forCellReuseIdentifier:NSStringFromClass([WorkTableViewCell class])];
        
        if (@available(iOS 11.0, *)) {
            UITableView.appearance.estimatedRowHeight = 0;
            UITableView.appearance.estimatedSectionFooterHeight = 0;
            UITableView.appearance.estimatedSectionHeaderHeight = 0;
        }
        [self addSubview:self.tableView];
        self.isNeedFooter = YES;
        self.isNeedHeader = YES;
        
        _photoArray = [NSMutableArray new];
    }
    return self;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
    [self.tableView reloadData];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview != nil) {
        if (self.isNeedHeader) {
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(netForContentHeader)];
        }
        
        if (self.isNeedFooter) {
            self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(netForContentFooter)];
        }
    }
    [self.tableView.mj_header beginRefreshing];
}

- (void)selectCellAtIndexPath:(NSIndexPath *)indexPath {
    if (self.lastSelectedIndexPath == indexPath) {
        return;
    }
    if (self.lastSelectedIndexPath != nil) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.lastSelectedIndexPath];
        [cell setSelected:NO animated:NO];
    }
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES animated:NO];
    self.lastSelectedIndexPath = indexPath;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollCallback(scrollView);
}

#pragma mark - JXPagingViewListViewDelegate

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
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


- (NSString *)authorId {
    if (_fromMe) {
        return [UserPage sharedInstance].uid;
    }
    
    return _authorId;
}

- (void)netForContentHeader {
    self.pageNum = @"";
    
    [self netForContentWithPageNum:self.pageNum header:YES];
}
- (void)netForContentFooter {
    [self netForContentWithPageNum:self.pageNum header:NO];
}
- (void)netForContentWithPageNum:(NSString *)pageNum header:(BOOL)header {

//    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
//    [[SDImageCache sharedImageCache]clearMemory];

    @weakify(self);
    [DiscoverDao getWorksList:self.authorId matchid:@"" minAid:pageNum type:@"100" successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        WorksDataModel *dataModel = (WorksDataModel *)responseObject;
        self.pageNum = dataModel.maxAid;
        if (header) {
            [self.dataArray removeAllObjects];
            [self.photoArray removeAllObjects];
        }
        NSMutableArray *tempArray = [NSMutableArray new];
        for (NSArray *array in dataModel.imgList) {
            NSArray *modelArray = [WorksModel arrayOfModelsFromDictionaries:array error:nil];
            
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
                photo.uid = worksModel.authorid;
                photo.userName = worksModel.author;
                [self.photoArray addObject:photo];
            }
            
            [tempArray addObject:modelArray];
        }
        
        [self.dataArray addObjectsFromArray:tempArray];
        [self.tableView reloadData];
        [[SDImageCache sharedImageCache]clearMemory];

    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [AppBaseHud showHudWithfail:error.errstr view:self.tableView];
    }];
}

#pragma mark-- tabelView 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WorkTableViewCell class]) forIndexPath:indexPath];
    [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    [[SDImageCache sharedImageCache]clearMemory];

    cell.listArray = self.dataArray[indexPath.row];
    
    @weakify(self);
    cell.selectBlock = ^(WorksModel *selectModel) {
        @strongify(self);

//        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
//        [[SDImageCache sharedImageCache]clearMemory];

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
        if (model.imgWidth > 1) {
            CGFloat imageHeight = (model.imgHeight) * (SCREEN_WIDTH / model.imgWidth);
            return imageHeight + AutoSize6(2);
        }
        
    } else if (listArray.count == 2) {
        WorksModel *model1 = listArray.firstObject;
        WorksModel *model2 = listArray.lastObject;
        
        if (model1.imgWidth > 1) {
            CGFloat width1 = SCREEN_WIDTH * (model1.imgWidth / (model1.imgWidth + model2.imgWidth));
            
            CGFloat imageHeight = (model1.imgHeight) * (width1 / model1.imgWidth);
            return imageHeight + AutoSize6(2);
        }
    }
    
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
