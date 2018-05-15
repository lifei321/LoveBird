//
//  DiscoverDao.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/15.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "DiscoverDao.h"
#import "ShequModel.h"

@implementation DiscoverDao

// 社区列表
+ (void)getShequList:(NSInteger)page successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[NSString stringWithFormat:@"%ld", page] forKey:@"page"];
    [dic setObject:@"483887" forKey:@"uid"];

    [AppHttpManager POST:kAPI_Discover_ShequList parameters:dic jsonModelName:[ShequDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
