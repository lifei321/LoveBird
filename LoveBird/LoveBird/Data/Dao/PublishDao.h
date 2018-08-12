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

// 发布
+ (void)publish:(NSArray *)editModelArray
       birdInfo:(NSMutableArray *)birdArray
           evId:(NSString *)evId
       loaction:(NSString *)location
            lat:(NSString *)lat
            lng:(NSString *)lng
           time:(NSString *)time
         status:(NSString *)status
          title:(NSString *)title
          imgId:(NSString *)imgId
         imgUrl:(NSString *)imgUrl
        matchid:(NSString *)matchid
            tid:(NSString *)tid
   successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 获取生态环境
+ (void)getEVSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 草稿箱
+ (void)getCaogaoSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 草稿发布
+ (void)publishCaogao:(NSString *)tid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock;

// 草稿获取详情
+ (void)caogaoDetail:(NSString *)tid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock ;
@end
