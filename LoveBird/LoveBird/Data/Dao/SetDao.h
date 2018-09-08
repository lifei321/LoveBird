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
@end
