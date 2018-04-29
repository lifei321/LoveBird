//
//  DiscoverDataSource.m
//  LoveBird
//
//  Created by ShanCheli on 2018/1/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "DiscoverDataSource.h"
#import "DiscoverListModel.h"

@implementation DiscoverDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        _bannerArray = [NSMutableArray new];
        _cycleArray = [NSMutableArray new];
        _dataSourceArray = [NSMutableArray new];
        
    }
    return self;
}

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray new];
        
        DiscoverListModel *model1 = [[DiscoverListModel alloc] init];
        model1.text = @"附近";
        model1.imageString = @"nearby";
        [_listArray addObject:model1];
        
        DiscoverListModel *model2 = [[DiscoverListModel alloc] init];
        model2.text = @"社区";
        model2.imageString = @"Community";
        [_listArray addObject:model2];
        
        DiscoverListModel *model3 = [[DiscoverListModel alloc] init];
        model3.text = @"达人";
        model3.imageString = @"intelligent";
        [_listArray addObject:model3];
        
        DiscoverListModel *model4 = [[DiscoverListModel alloc] init];
        model4.text = @"作品";
        model4.imageString = @"works";
        [_listArray addObject:model4];
        
        DiscoverListModel *model5 = [[DiscoverListModel alloc] init];
        model5.text = @"资讯";
        model5.imageString = @"information";
        [_listArray addObject:model5];
        
        DiscoverListModel *model6 = [[DiscoverListModel alloc] init];
        model6.text = @"装备";
        model6.imageString = @"equipment";
        [_listArray addObject:model6];
        
        DiscoverListModel *model7 = [[DiscoverListModel alloc] init];
        model7.text = @"大赛";
        model7.imageString = @"competition";
        [_listArray addObject:model7];
        
        DiscoverListModel *model8 = [[DiscoverListModel alloc] init];
        model8.text = @"排行";
        model8.imageString = @"rankings";
        [_listArray addObject:model8];
        
    }
    return _listArray;
}

- (void)setBannerArray:(NSMutableArray *)bannerArray {
    _bannerArray = [bannerArray copy];
    for (BannerModel *model in bannerArray) {
        [self.cycleArray addObject:model.img];
    }
}

@end
