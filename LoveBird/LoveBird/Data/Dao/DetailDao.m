//
//  DetailDao.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "DetailDao.h"
#import "LogDetailModel.h"
#import "LogDetailTalkModel.h"
#import "BirdDetailModel.h"
#import "LogDetailUpModel.h"
#import "LogContentModel.h"


@implementation DetailDao

// 获取日志详情
+ (void)getLogDetail:(NSString *)tid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(tid) forKey:@"tid"];
    
    
    [AppHttpManager POST:kAPI_Detail_birdArticle parameters:dic jsonModelName:[LogDetailModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 获取文章详情
+ (void)getLogContent:(NSString *)aid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(aid) forKey:@"aid"];
    
    
    [AppHttpManager POST:kAPI_Detail_contentDetail parameters:dic jsonModelName:[LogContentModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 获取日志评论列表
+ (void)getLogDetail:(NSString *)tid aid:(NSString *)aid page:(NSString *)page successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(tid) forKey:@"tid"];
    [dic setObject:EMPTY_STRING_IF_NIL(page) forKey:@"page"];
    [dic setObject:EMPTY_STRING_IF_NIL(aid) forKey:@"aid"];

    
    [AppHttpManager POST:kAPI_Detail_talkList parameters:dic jsonModelName:[LogDetailTalkDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 获取日志点赞列表
+ (void)getLogUPDetail:(NSString *)tid aid:(NSString *)aid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(tid) forKey:@"tid"];
    [dic setObject:EMPTY_STRING_IF_NIL(aid) forKey:@"aid"];

    
    [AppHttpManager POST:kAPI_Detail_uplist parameters:dic jsonModelName:[LogDetailUpDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 鸟种详情
+ (void)getBirdDetail:(NSString *)code successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(code) forKey:@"csp_code"];
    
    
    [AppHttpManager POST:kAPI_Detail_BirdDetail parameters:dic jsonModelName:[BirdDetailModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 删除日志
+ (void)getDeleteDetail:(NSString *)tid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(tid) forKey:@"tid"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.token) forKey:@"token"];

    
    [AppHttpManager POST:kAPI_Detail_DeleteBirdDetail parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
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
