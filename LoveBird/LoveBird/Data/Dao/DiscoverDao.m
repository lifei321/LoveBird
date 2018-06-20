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
#import "MatchDetailModel.h"
#import "MatchArticleModel.h"
#import "MapDiscoverModel.h"
#import "ShequZuzhiModel.h"



@implementation DiscoverDao

// 社区列表
+ (void)getShequList:(NSInteger)page
             groupId:(NSString *)groupId
              sortId:(NSString *)sortId
        successBlock:(LFRequestSuccess)successBlock
        failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[NSString stringWithFormat:@"%ld", (long)page] forKey:@"page"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(groupId) forKey:@"groupId"];
    [dic setObject:EMPTY_STRING_IF_NIL(sortId) forKey:@"sortId"];

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
    
    [AppHttpManager POST:kAPI_Discover_ShequSection parameters:dic jsonModelName:[ShequZuzhiDataModel class] success:^(__kindof AppBaseModel *responseObject) {
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

// 大赛详情
+ (void)getMatchDetail:(NSString *)matchid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(matchid) forKey:@"matchid"];
    
    [AppHttpManager POST:kAPI_Discover_MatchDetail parameters:dic jsonModelName:[MatchDetailModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 大赛记录列表
+ (void)getMatchArctleList:(NSString *)matchid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(matchid) forKey:@"matchid"];
    
    [AppHttpManager POST:kAPI_Discover_MatchArticleList parameters:dic jsonModelName:[MatchArticleDataModel class] success:^(__kindof AppBaseModel *responseObject) {
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
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
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
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
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
+ (void)getRankList:(NSString *)matchid  type:(NSString *)type isYear:(NSString *)isYear successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(matchid) forKey:@"matchid"];
    [dic setObject:EMPTY_STRING_IF_NIL(type) forKey:@"type"];
    [dic setObject:EMPTY_STRING_IF_NIL(isYear) forKey:@"isYear"];

    
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


// 附近鸟
+ (void)getNearBird:(NSString *)lat  type:(NSString *)lng radius:(NSString *)radius successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(lat) forKey:@"lat"];
    [dic setObject:EMPTY_STRING_IF_NIL(lng) forKey:@"lng"];
    [dic setObject:EMPTY_STRING_IF_NIL(radius) forKey:@"raidus"];
    
    [AppHttpManager POST:kAPI_Discover_map parameters:dic jsonModelName:[MapDiscoverDataModel class] success:^(__kindof AppBaseModel *responseObject) {
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
