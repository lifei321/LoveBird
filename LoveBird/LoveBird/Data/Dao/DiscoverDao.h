//
//  DiscoverDao.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/15.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppHttpManager.h"

@interface DiscoverDao : NSObject

// 社区列表
+ (void)getShequList:(NSInteger)page
             groupId:(NSString *)groupId
              sortId:(NSString *)sortId
            province:(NSString *)province
                city:(NSString *)city
        successBlock:(LFRequestSuccess)successBlock
        failureBlock:(LFRequestFail)failureBlock;

// 社区模块
+ (void)getShequSectionSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 大赛列表
+ (void)getMatchListSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

+ (void)getMatchList:(NSString *)type SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 大赛投稿
+ (void)getMatch:(NSString *)tid matchid:(NSString *)matchid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 大赛详情
+ (void)getMatchDetail:(NSString *)matchid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 大赛记录列表
+ (void)getMatchArctleList:(NSString *)matchid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock ;

// 装备咨询列表
+ (void)getWordList:(NSString *)cid page:(NSString *)page successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 作品列表
+ (void)getWorksList:(NSString *)authorid matchid:(NSString *)matchid  minAid:(NSString *)minAid type:(NSString *)type successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 排行
+ (void)getRankList:(NSString *)matchid  type:(NSString *)type isYear:(NSString *)isYear year:(NSString *)year successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 附近鸟
+ (void)getNearBird:(NSString *)lat  type:(NSString *)lng radius:(NSString *)radius successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 附近鸟
+ (void)getNearBirdMessage:(NSString *)lat  type:(NSString *)lng successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 全局搜索装备咨询
+ (void)getZZList:(NSString *)word successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 全局话题
+ (void)getHuaTiList:(NSString *)word page:(NSInteger)page successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 发评论
+ (void)talkWithTid:(NSString *)tid content:(NSString *)content pid:(NSString *)pid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock ;
@end
