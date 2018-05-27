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
#import "ZhuangbeiModel.h"
#import "WorksModel.h"
#import "RankModel.h"



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

    [AppHttpManager POST:kAPI_Discover_articleList parameters:dic jsonModelName:[ZhuangbeiDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 作品列表
+ (void)getWorksList:(NSString *)authorid matchid:(NSString *)matchid  minAid:(NSString *)minAid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"483887" forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(authorid) forKey:@"authorid"];
    [dic setObject:EMPTY_STRING_IF_NIL(matchid) forKey:@"matchid"];
    [dic setObject:EMPTY_STRING_IF_NIL(minAid) forKey:@"minAid"];

    
    [AppHttpManager POST:kAPI_Article_zuopinList parameters:dic jsonModelName:[WorksDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 排行
+ (void)getRankList:(NSString *)matchid  type:(NSString *)type successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"483887" forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(matchid) forKey:@"matchid"];
    [dic setObject:EMPTY_STRING_IF_NIL(type) forKey:@"type"];
    
    
    [AppHttpManager POST:kAPI_Article_rankingList parameters:dic jsonModelName:[RankDataModel class] success:^(__kindof AppBaseModel *responseObject) {
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
