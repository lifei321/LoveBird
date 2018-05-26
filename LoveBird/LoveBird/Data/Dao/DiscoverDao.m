//
//  DiscoverDao.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/15.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "DiscoverDao.h"
#import "ShequModel.h"
#import "MatchModel.h"
#import "DiscoverContentModel.h"



@implementation DiscoverDao

// 社区列表
+ (void)getShequList:(NSInteger)page successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[NSString stringWithFormat:@"%ld", (long)page] forKey:@"page"];
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

// 社区模块
+ (void)getShequSectionSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"483887" forKey:@"uid"];
    
    [AppHttpManager POST:kAPI_Discover_ShequSection parameters:dic jsonModelName:[ShequDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 大赛列表
+ (void)getMatchListSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    [AppHttpManager POST:kAPI_Discover_MatchList parameters:nil jsonModelName:[MatchListModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 装备咨询列表
+ (void)getWordList:(NSString *)cid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"483887" forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(cid) forKey:@"cid"];

    [AppHttpManager POST:kAPI_Discover_articleList parameters:dic jsonModelName:[DiscoverContentDataModel class] success:^(__kindof AppBaseModel *responseObject) {
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
