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

#import "DiscoverContentModel.h"

@implementation DiscoverDao

// 社区列表
+ (void)getShequList:(NSInteger)page
             groupId:(NSString *)groupId
              sortId:(NSString *)sortId
            province:(NSString *)province
                city:(NSString *)city
        successBlock:(LFRequestSuccess)successBlock
        failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:[NSString stringWithFormat:@"%ld", (long)page] forKey:@"page"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(groupId) forKey:@"groupId"];
    [dic setObject:EMPTY_STRING_IF_NIL(sortId) forKey:@"sortId"];
    [dic setObject:EMPTY_STRING_IF_NIL(province) forKey:@"province"];
    [dic setObject:EMPTY_STRING_IF_NIL(city) forKey:@"city"];

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
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];

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

+ (void)getMatchList:(NSString *)type SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(@"join") forKey:@"type"];

    [AppHttpManager POST:kAPI_Discover_MatchList parameters:dic jsonModelName:[MatchListModel class] success:^(__kindof AppBaseModel *responseObject) {
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

// 大赛投稿
+ (void)getMatch:(NSString *)tid matchid:(NSString *)matchid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(tid) forKey:@"tid"];
    [dic setObject:EMPTY_STRING_IF_NIL(matchid) forKey:@"matchid"];

    [AppHttpManager POST:kAPI_Discover_tougaodasai parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
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
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];

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
+ (void)getMatchArctleList:(NSString *)matchid page:(NSInteger)page SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(matchid) forKey:@"matchid"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:[NSString stringWithFormat:@"%ld", (long)page] forKey:@"page"];

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
+ (void)getWordList:(NSString *)cid page:(NSString *)page successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(cid) forKey:@"cid"];
    [dic setObject:EMPTY_STRING_IF_NIL(page) forKey:@"page"];

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

// 全局搜索装备咨询
+ (void)getZZList:(NSString *)word successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(word) forKey:@"keywords"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];

    [AppHttpManager POST:kAPI_Discover_Search_article parameters:dic jsonModelName:[ZhuangbeiDataModel class] success:^(__kindof AppBaseModel *responseObject) {
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
+ (void)getWorksList:(NSString *)authorid matchid:(NSString *)matchid  minAid:(NSString *)minAid type:(NSString *)type successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(authorid) forKey:@"authorid"];
    [dic setObject:EMPTY_STRING_IF_NIL(matchid) forKey:@"matchid"];
    [dic setObject:EMPTY_STRING_IF_NIL(minAid) forKey:@"minAid"];
    [dic setObject:EMPTY_STRING_IF_NIL(type) forKey:@"type"];

    
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
+ (void)getRankList:(NSString *)matchid  type:(NSString *)type isYear:(NSString *)isYear year:(NSString *)year successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(matchid) forKey:@"matchid"];
    [dic setObject:EMPTY_STRING_IF_NIL(type) forKey:@"type"];
    [dic setObject:EMPTY_STRING_IF_NIL(isYear) forKey:@"isYear"];
    [dic setObject:EMPTY_STRING_IF_NIL(year) forKey:@"year"];

    
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

// 附近鸟
+ (void)getNearBirdMessage:(NSString *)lat  type:(NSString *)lng successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(lat) forKey:@"lat"];
    [dic setObject:EMPTY_STRING_IF_NIL(lng) forKey:@"lng"];
    
    [AppHttpManager POST:kAPI_Discover_mapMessage parameters:dic jsonModelName:[MapDiscoverGpsModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 全局话题
+ (void)getHuaTiList:(NSString *)word page:(NSInteger)page successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSString *pagestr = [NSString stringWithFormat:@"%ld", page];
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(word) forKey:@"keywords"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(pagestr) forKey:@"page"];

    [AppHttpManager POST:kAPI_Discover_Search_birdarticle parameters:dic jsonModelName:[DiscoverContentDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}



// 发评论
+ (void)talkWithTid:(NSString *)tid content:(NSString *)content pid:(NSString *)pid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(tid) forKey:@"tid"];
    [dic setObject:EMPTY_STRING_IF_NIL(content) forKey:@"comment"];
    
    if (pid.length) {
        [dic setObject:EMPTY_STRING_IF_NIL(pid) forKey:@"pid"];
    }

    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    

    [AppHttpManager POST:kAPI_User_comment parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
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
