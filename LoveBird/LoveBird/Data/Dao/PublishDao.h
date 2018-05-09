//
//  PublishDao.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppHttpManager.h"
#import "PublishEditModel.h"


@interface PublishDao : NSObject

// 上传图片
+ (void)upLoad:(UIImage *)image successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;


+ (void)publish:(NSArray *)editModelArray successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;


@end
