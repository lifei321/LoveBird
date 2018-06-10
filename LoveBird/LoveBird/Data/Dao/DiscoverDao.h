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
+ (void)getShequList:(NSInteger)page successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 社区模块
+ (void)getShequSectionSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 大赛列表
+ (void)getMatchListSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 大赛详情
+ (void)getMatchDetail:(NSString *)matchid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 大赛记录列表
+ (void)getMatchArctleList:(NSString *)matchid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock ;

// 装备咨询列表
+ (void)getWordList:(NSString *)cid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 作品列表
+ (void)getWorksList:(NSString *)authorid matchid:(NSString *)matchid  minAid:(NSString *)minAid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 排行
+ (void)getRankList:(NSString *)matchid  type:(NSString *)type successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;
@end
