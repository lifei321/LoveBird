//
//  PublishDao.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishDao.h"
#import "AppApi.h"
#import "PublishUpModel.h"
#import <JSONKit_NoWarning/JSONKit.h>
#import "PublishEVModel.h"
#import "MineCaogaoModel.h"
#import "MinePublishModel.h"

@implementation PublishDao

// 上传图片
+ (void)upLoad:(UIImage *)image successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    
    NSData *data = UIImageJPEGRepresentation(image, (CGFloat)1.0);//.jpg
    NSDictionary *fileDic = @{@"file": data,
                              @"fileName":@"file_bird",
                              };

    
    [AppHttpManager POST:kAPI_Publish_UpLoad
              parameters:dic
               fileArray:@[fileDic]
           jsonModelName:[PublishUpModel class]
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
            pid:(NSString *)pid
   successBlock:(LFRequestSuccess)successBlock
   failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSMutableDictionary *params = [NSMutableDictionary new];

    [dic setObject:[JSONModel arrayOfDictionariesFromModels:editModelArray] forKey:@"postList"];
    [dic setObject:EMPTY_STRING_IF_NIL(pid) forKey:@"pid"];
    [params setObject:[@[dic] JSONString]forKey:@"articleBody"];

    [birdArray removeLastObject];
    [params setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [params setObject:[[JSONModel arrayOfDictionariesFromModels:birdArray] JSONString]forKey:@"birdInfo"];
    [params setObject:EMPTY_STRING_IF_NIL(evId) forKey:@"environmentId"];
    [params setObject:EMPTY_STRING_IF_NIL(lat) forKey:@"lat"];
    [params setObject:EMPTY_STRING_IF_NIL(lng) forKey:@"lng"];
    [params setObject:EMPTY_STRING_IF_NIL(location) forKey:@"locale"];
    [params setObject:EMPTY_STRING_IF_NIL(time) forKey:@"observeTime"];
    [params setObject:EMPTY_STRING_IF_NIL(status) forKey:@"status"];
    [params setObject:EMPTY_STRING_IF_NIL(title) forKey:@"title"];
    [params setObject:EMPTY_STRING_IF_NIL(imgId) forKey:@"imgId"];
    [params setObject:EMPTY_STRING_IF_NIL(imgUrl) forKey:@"imgUrl"];
    [params setObject:EMPTY_STRING_IF_NIL(matchid) forKey:@"matchid"];
    [params setObject:EMPTY_STRING_IF_NIL(tid) forKey:@"tid"];


    [AppHttpManager POST:kAPI_Publish_Publish parameters:params jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


// 获取生态环境
+ (void)getEVSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    [AppHttpManager GET:kAPI_Publish_GetEV parameters:dic jsonModelName:[PublishEVDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 草稿箱
+ (void)getCaogaoSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];

    [AppHttpManager POST:kAPI_Detail_caogaoxiang parameters:dic jsonModelName:[MineCaogaoDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


// 草稿发布
+ (void)publishCaogao:(NSString *)tid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(tid) forKey:@"tid"];
    [dic setObject:EMPTY_STRING_IF_NIL(@"1") forKey:@"isDirect"];


    [AppHttpManager POST:kAPI_Detail_caogaopublish parameters:dic jsonModelName:[AppBaseModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 草稿获取详情
+ (void)caogaoDetail:(NSString *)tid SuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].uid) forKey:@"uid"];
    [dic setObject:EMPTY_STRING_IF_NIL(tid) forKey:@"tid"];
    
    
    [AppHttpManager POST:kAPI_Detail_caogaoDetail parameters:dic jsonModelName:[MinePublishModel class] success:^(__kindof AppBaseModel *responseObject) {
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
