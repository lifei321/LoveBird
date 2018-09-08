//
//  SetDao.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "SetDao.h"
#import "MessageModel.h"
#import "MineLocationModel.h"

@implementation SetDao

// 获取  获取通知（系统消息、评论、关注、赞）列表
+(void)getSetType:(NSString *)type successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(type) forKey:@"type"];
    
    
    [AppHttpManager POST:kAPI_Detail_contentDetail parameters:dic jsonModelName:[MessageDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+(void)getLocation:(NSString *)upid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(upid) forKey:@"upid"];
    
    
    [AppHttpManager POST:kAPI_Set_location parameters:dic jsonModelName:[MineLocationDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
