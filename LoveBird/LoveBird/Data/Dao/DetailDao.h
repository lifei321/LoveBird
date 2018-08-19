//
//  DetailDao.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppHttpManager.h"

@interface DetailDao : NSObject

// 获取日志详情
+ (void)getLogDetail:(NSString *)tid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 获取文章详情
+ (void)getLogContent:(NSString *)aid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;


// 获取日志评论列表
+ (void)getLogDetail:(NSString *)tid aid:(NSString *)aid page:(NSString *)page successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;


// 获取日志点赞列表
+ (void)getLogUPDetail:(NSString *)tid aid:(NSString *)aid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock ;


// 鸟种详情
+ (void)getBirdDetail:(NSString *)code successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 删除日志
+ (void)getDeleteDetail:(NSString *)tid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 观鸟记录
+ (void)getDetailLog:(NSString *)cspCode successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;


// 举报
+ (void)getDetailReportSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;
@end
