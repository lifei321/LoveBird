//
//  BodyBirdViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/4/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BodyBirdViewController.h"
#import "BodyBirdModel.h"
#import "BodyBirdCell.h"

@interface BodyBirdViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dataArrayOne;

@property (nonatomic, strong) NSArray *dataArrayTwo;

@property (nonatomic, strong) NSArray *dataArrayThree;

@property (nonatomic, strong) NSArray *dataArrayFoure;

@property (nonatomic, strong) NSArray *titleArray;

@property (strong, nonatomic) UICollectionView *collectionView;


@end

@implementation BodyBirdViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    
    [self setCollectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_type == BodyBirdTypeOne) {
        return _dataArrayOne.count;
    } else if (_type == BodyBirdTypeTwo) {
        return _dataArrayTwo.count;
    } else if (_type == BodyBirdTypeThree) {
        return _dataArrayThree.count;
    } else if (_type == BodyBirdTypeFour) {
        return _dataArrayFoure.count;
    }
    return 0;
}


//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    DiscoverHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DiscoverHeaderCell class]) forIndexPath:indexPath];
//    cell.model = _viewModel.listArray[indexPath.row];
//    return cell;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    

}

- (void)setCollectionView {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.itemSize = CGSizeMake(AutoSize(36), AutoSize(56));
    flowLayout.minimumInteritemSpacing = AutoSize(30);
    flowLayout.minimumLineSpacing = AutoSize(5);
    flowLayout.sectionInset = UIEdgeInsetsMake(AutoSize(10), AutoSize(25), AutoSize(10), AutoSize(25));
    ///header 和footer 的高度
    flowLayout.headerReferenceSize = CGSizeZero;
    flowLayout.footerReferenceSize = CGSizeZero;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, AutoSize(175), self.view.width, AutoSize(137)) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.scrollEnabled = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    [_collectionView registerClass:[BodyBirdCell class] forCellWithReuseIdentifier:NSStringFromClass([BodyBirdCell class])];
}



- (void)setData {
    
    _titleArray = @[@"嘴头之比？", ];
    
    // 1  0：all； 401：≤1\3； 402：≤1\1； 403：≤2\1 ；404：>2\1 405：>3\1
    BodyBirdModel *model11 = [[BodyBirdModel alloc] initWithString:@"step_1_1" imageId:@"401" title:@"≤1\3"];
    BodyBirdModel *model12 = [[BodyBirdModel alloc] initWithString:@"step_1_2" imageId:@"402" title:@"≤1\1"];
    BodyBirdModel *model13 = [[BodyBirdModel alloc] initWithString:@"step_1_3" imageId:@"403" title:@"≤2\1"];
    BodyBirdModel *model14 = [[BodyBirdModel alloc] initWithString:@"step_1_4" imageId:@"404" title:@">2\1"];
    BodyBirdModel *model15 = [[BodyBirdModel alloc] initWithString:@"step_1_5" imageId:@"405" title:@">3\1"];
    self.dataArrayOne = @[model11, model12, model13, model14, model15];

    BodyBirdModel *model21 = [[BodyBirdModel alloc] initWithString:@"step_1_1" imageId:@"401" title:@"≤1\3"];
    BodyBirdModel *model22 = [[BodyBirdModel alloc] initWithString:@"step_1_2" imageId:@"402" title:@"≤1\1"];
    BodyBirdModel *model23 = [[BodyBirdModel alloc] initWithString:@"step_1_3" imageId:@"403" title:@"≤2\1"];
    BodyBirdModel *model24 = [[BodyBirdModel alloc] initWithString:@"step_1_4" imageId:@"404" title:@">2\1"];
    BodyBirdModel *model25 = [[BodyBirdModel alloc] initWithString:@"step_1_5" imageId:@"405" title:@">3\1"];
    self.dataArrayTwo = @[model11, model12, model13, model14, model15];
    
    BodyBirdModel *model31 = [[BodyBirdModel alloc] initWithString:@"step_1_1" imageId:@"401" title:@"≤1\3"];
    BodyBirdModel *model32 = [[BodyBirdModel alloc] initWithString:@"step_1_2" imageId:@"402" title:@"≤1\1"];
    BodyBirdModel *model33 = [[BodyBirdModel alloc] initWithString:@"step_1_3" imageId:@"403" title:@"≤2\1"];
    BodyBirdModel *model34 = [[BodyBirdModel alloc] initWithString:@"step_1_4" imageId:@"404" title:@">2\1"];
    BodyBirdModel *model35 = [[BodyBirdModel alloc] initWithString:@"step_1_5" imageId:@"405" title:@">3\1"];
    self.dataArrayOne = @[model11, model12, model13, model14, model15];
    
    BodyBirdModel *model41 = [[BodyBirdModel alloc] initWithString:@"step_1_1" imageId:@"401" title:@"≤1\3"];
    BodyBirdModel *model42 = [[BodyBirdModel alloc] initWithString:@"step_1_2" imageId:@"402" title:@"≤1\1"];
    BodyBirdModel *model43 = [[BodyBirdModel alloc] initWithString:@"step_1_3" imageId:@"403" title:@"≤2\1"];
    BodyBirdModel *model44 = [[BodyBirdModel alloc] initWithString:@"step_1_4" imageId:@"404" title:@">2\1"];
    BodyBirdModel *model45 = [[BodyBirdModel alloc] initWithString:@"step_1_5" imageId:@"405" title:@">3\1"];
    self.dataArrayOne = @[model11, model12, model13, model14, model15];
    
}

@end
