//
//  DiscoverHeaderView.h
//  LoveBird
//
//  Created by ShanCheli on 2018/1/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface DiscoverHeaderView : UIView

// 轮播图
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

// 菜单
@property (strong, nonatomic) UICollectionView *collectionView;


@end
