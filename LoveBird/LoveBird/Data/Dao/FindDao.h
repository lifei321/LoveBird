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

// 体型查鸟
+ (void)getBirdBillCode:(NSString *)bill
                  color:(NSString *)color
                 length:(NSString *)length
                  shape:(NSString *)shape
                   page:(NSString *)page
           successBlock:(LFRequestSuccess)successBlock
           failureBlock:(LFRequestFail)failureBlock;

// 体型可选项
+ (void)getBirdDisplayShape:(NSString *)text successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 类别查鸟
+ (void)getBirdClass:(NSInteger)type
              family:(NSString *)family
             subject:(NSString *)subject
        successBlock:(LFRequestSuccess)successBlock
        failureBlock:(LFRequestFail)failureBlock;

// 鸟岛列表
+ (void)getGuide:(NSString *)pageNum successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;


@end
