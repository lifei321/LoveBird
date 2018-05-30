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


// 获取日志评论列表
+ (void)getLogDetail:(NSString *)tid page:(NSString *)page successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;
@end
