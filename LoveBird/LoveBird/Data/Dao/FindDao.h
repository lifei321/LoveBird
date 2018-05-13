//
//  FindDao.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppHttpManager.h"

@interface FindDao : NSObject

// 关键字查鸟
+ (void)getBird:(NSString *)text genus:(NSString *)genus successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;



@end
