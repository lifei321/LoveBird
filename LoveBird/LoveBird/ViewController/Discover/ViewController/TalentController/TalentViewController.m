//
//  TalentViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/4.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "TalentViewController.h"
#import "TalentCollectionViewCell.h"
#import "TalentModel.h"
#import "AppHttpManager.h"


@interface TalentViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, FollowButtonDidClickDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation TalentViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"达人";
    [self.navigationController wr_setNavBarTintColor:[UIColor whiteColor]];
    [self.navigationController wr_setNavBarTitleColor:[UIColor blackColor]];
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleDefault];

    [self.view addSubview:self.collectionView];
    [self netForData];
}


- (void)netForData {
    
    NSDictionary *dic = @{
                          @"cmd":@"masterList",
                          };
    @weakify(self);
    [AppHttpManager GET:kAPI_Discover_Talent parameters:dic jsonModelName:[TalentDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);

        TalentDataModel *dataModel = (TalentDataModel *)responseObject;
        self.sourceArray = [dataModel.data mutableCopy];
        [self.collectionView reloadData];

    } failure:^(__kindof AppBaseModel *error) {

    }];
}

- (void)followButtonClickDelegate:(UIButton *)button {
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _sourceArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TalentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TalentCollectionViewCell class]) forIndexPath:indexPath];
    cell.talentModel = _sourceArray[indexPath.row];
    return cell;
}



- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        CGFloat width = (SCREEN_WIDTH - AutoSize(20)) / 3;
        self.flowLayout.itemSize = CGSizeMake(width, width * 10 / 7);
        self.flowLayout.minimumInteritemSpacing = AutoSize(1);
        self.flowLayout.minimumLineSpacing = AutoSize(5);
        self.flowLayout.sectionInset = UIEdgeInsetsMake(AutoSize(7), AutoSize(5), AutoSize(30), AutoSize(5));
        
        ///header 和footer 的高度
        self.flowLayout.headerReferenceSize = CGSizeZero;
        self.flowLayout.footerReferenceSize = CGSizeZero;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TalentCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TalentCollectionViewCell class])];
        _collectionView.backgroundColor = kColoreDefaultBackgroundColor;

    }
    return _collectionView;
}


- (NSMutableArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = [NSMutableArray new];
    }
    return _sourceArray;
}







@end
