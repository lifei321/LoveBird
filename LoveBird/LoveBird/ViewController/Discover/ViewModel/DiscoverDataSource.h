//
//  DiscoverDataSource.h
//  LoveBird
//
//  Created by ShanCheli on 2018/1/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BannerModel.h"
#import "DiscoverContentModel.h"

@interface DiscoverDataSource : NSObject

// 轮播图
@property (nonatomic, strong) NSMutableArray *bannerArray;

// 轮播图片数组
@property (nonatomic, strong) NSMutableArray *cycleArray;


// 菜单
@property (nonatomic, strong) NSMutableArray *listArray;

// tabelview
@property (nonatomic, strong) NSMutableArray *dataSourceArray;



@end
