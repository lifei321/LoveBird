//
//  SetDao.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppHttpManager.h"


@interface SetDao : NSObject

// 获取  获取通知（系统消息、评论、关注、赞）列表
+(void)getSetType:(NSString *)type successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;


+(void)getLocation:(NSString *)upid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;



+ (void)finishMessage:(NSString *)province
                 city:(NSString *)city
               gender:(NSString *)gender
               wechat:(NSString *)wechat
                weibo:(NSString *)weibo
                   qq:(NSString *)qq
                  gid:(NSString *)gid
             birthday:(NSString *)birthday
                 sign:(NSString *)sign
         successBlock:(LFRequestSuccess)successBlock
         failureBlock:(LFRequestFail)failureBlock;


+ (void)uploadHeadIcon:(UIImage *)image successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;


+(void)getMessageSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

+(void)getGlobelSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

+(void)setDeviceToken:(NSString *)token SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

+(void)setPushSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;
@end

