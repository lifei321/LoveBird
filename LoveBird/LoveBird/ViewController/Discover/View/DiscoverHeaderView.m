//
//  DiscoverHeaderView.m
//  LoveBird
//
//  Created by ShanCheli on 2018/1/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "DiscoverHeaderView.h"
#import "DiscoverHeaderCell.h"


@interface DiscoverHeaderView()

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;


@end

@implementation DiscoverHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kColoreDefaultBackgroundColor;
        
        [self addSubview:self.cycleScrollView];
        
        [self addSubview:self.collectionView];

    }
    return self;
}

- (SDCycleScrollView *)cycleScrollView {
    
    if (_cycleScrollView == nil) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize(170)) delegate:nil placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _cycleScrollView;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.flowLayout.itemSize = CGSizeMake(AutoSize(36), AutoSize(56));
        self.flowLayout.minimumInteritemSpacing = AutoSize(30);
        self.flowLayout.minimumLineSpacing = AutoSize(15);
        self.flowLayout.sectionInset = UIEdgeInsetsMake(AutoSize(10), AutoSize(25), AutoSize(10), AutoSize(25));
        ///header 和footer 的高度
        self.flowLayout.headerReferenceSize = CGSizeZero;
        self.flowLayout.footerReferenceSize = CGSizeZero;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, AutoSize(175), self.width, AutoSize(150)) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[DiscoverHeaderCell class] forCellWithReuseIdentifier:NSStringFromClass([DiscoverHeaderCell class])];
    }
    return _collectionView;
}


@end
