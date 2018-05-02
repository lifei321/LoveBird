//
//  UserDao.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppHttpManager.h"

//100：系统消息；200:评论；300：关注；400：赞
typedef NS_ENUM(NSInteger,UserMessageType) {
    UserMessageTypeSystem = 100,
    UserMessageTypeTalk = 200,
    UserMessageTypeFollow = 300,
    UserMessageTypeUp = 400,
};


@interface UserDao : NSObject

// 获取推送消息
+ (void)userMessageType:(UserMessageType)type successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 关注
+ (void)userFollow:(NSString *)fid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 关注列表
+ (void)userFollowList:(NSString *)uid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 用户个人信息
+ (void)userPersonInfo:(NSString *)uid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 我的朋友圈 文章列表
+ (void)userContenSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 我的收藏列表
+ (void)userCollectList:(NSInteger)pageNum successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 我的日志列表
+ (void)userLogList:(NSInteger)pageNum
            matchId:(NSString *)matchId
                fid:(NSString *)fid
       successBlock:(LFRequestSuccess)successBlock
       failureBlock:(LFRequestFail)failureBlock;

// 我的鸟种列表
+ (void)userBirdList:(NSInteger)pageNum
                 fid:(NSString *)fid
        successBlock:(LFRequestSuccess)successBlock
        failureBlock:(LFRequestFail)failureBlock;

// 相册列表
+ (void)userPhotoList:(NSString *)uid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 粉丝列表
+ (void)userFansList:(NSString *)uid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 我的个人信息
+ (void)userMyInfoSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;




@end
