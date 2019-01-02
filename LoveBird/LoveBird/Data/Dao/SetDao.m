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
#import "GlobelMessage.h"

@implementation SetDao

// 获取  获取通知（系统消息、评论、关注、赞）列表
+(void)getSetType:(NSString *)type successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(type) forKey:@"type"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].token) forKey:@"token"];
    
    [AppHttpManager POST:kAPI_Set_MessageDetail parameters:dic jsonModelName:[MessageDataModel class] success:^(__kindof AppBaseModel *responseObject) {
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
         failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].token) forKey:@"token"];
    [dic setObject:EMPTY_STRING_IF_NIL(province) forKey:@"province"];
    [dic setObject:EMPTY_STRING_IF_NIL(city) forKey:@"city"];
    [dic setObject:EMPTY_STRING_IF_NIL(gender) forKey:@"gender"];
    [dic setObject:EMPTY_STRING_IF_NIL(wechat) forKey:@"wechat"];
    [dic setObject:EMPTY_STRING_IF_NIL(weibo) forKey:@"weibo"];
    [dic setObject:EMPTY_STRING_IF_NIL(qq) forKey:@"qq"];
    [dic setObject:EMPTY_STRING_IF_NIL(gid) forKey:@"gid"];
    [dic setObject:EMPTY_STRING_IF_NIL(birthday) forKey:@"birthday"];
    [dic setObject:EMPTY_STRING_IF_NIL(sign) forKey:@"sign"];

    
    [AppHttpManager POST:kAPI_Set_finish parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)uploadHeadIcon:(UIImage *)image successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].token) forKey:@"token"];

    NSData *data = UIImageJPEGRepresentation(image, (CGFloat)1.0);//.jpg
    NSDictionary *fileDic = @{@"file": data,
                              @"fileName":@"file_head",
                              };
    
    
    [AppHttpManager POST:kAPI_Set_finishHeadiCON
              parameters:dic
               fileArray:@[fileDic]
           jsonModelName:[AppBaseModel class]
                 success:^(__kindof AppBaseModel *responseObject) {
                     if (successBlock) {
                         successBlock(responseObject);
                     }
                 } uploadProgress:nil
                 failure:^(__kindof AppBaseModel *error) {
                     if (failureBlock) {
                         failureBlock(error);
                     }
                 }];
}

+(void)getMessageSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    
    [AppHttpManager POST:kAPI_Set_Message parameters:dic jsonModelName:[MessageCountModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+(void)getGlobelSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [AppHttpManager POST:kAPI_GET_GLOBLE_DATA parameters:dic jsonModelName:[GlobelMessage class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+(void)setDeviceToken:(NSString *)token SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(token) forKey:@"device_tokens"];

    [AppHttpManager POST:kAPI_PUSH_TOKEN parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+(void)setPush:(NSString *)system talk:(NSString *)talk follow:(NSString *)follow SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].token) forKey:@"token"];
    [dic setObject:EMPTY_STRING_IF_NIL(system) forKey:@"system"];
    [dic setObject:EMPTY_STRING_IF_NIL(talk) forKey:@"comment"];
    [dic setObject:EMPTY_STRING_IF_NIL(follow) forKey:@"follow"];

    [AppHttpManager POST:kAPI_PUSH_SETTING parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
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
