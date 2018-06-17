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

@implementation PublishDao

// 上传图片
+ (void)upLoad:(UIImage *)image successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    
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
           time:(NSString *)time
         status:(NSString *)status
          title:(NSString *)title
   successBlock:(LFRequestSuccess)successBlock
   failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSMutableDictionary *params = [NSMutableDictionary new];

    [dic setObject:[JSONModel arrayOfDictionariesFromModels:editModelArray] forKey:@"postList"];
    [params setObject:[@[dic] JSONString]forKey:@"articleBody"];

    [birdArray removeLastObject];
    [params setObject:[[JSONModel arrayOfDictionariesFromModels:birdArray] JSONString]forKey:@"birdInfo"];
    [params setObject:EMPTY_STRING_IF_NIL(evId) forKey:@"environmentId"];
    [params setObject:@"483887" forKey:@"lat"];
    [params setObject:@"483887" forKey:@"lng"];
    [params setObject:@"483887" forKey:@"locale"];
    [params setObject:EMPTY_STRING_IF_NIL(time) forKey:@"observeTime"];
    [params setObject:EMPTY_STRING_IF_NIL(status) forKey:@"status"];
    [params setObject:EMPTY_STRING_IF_NIL(title) forKey:@"title"];
    [params setObject:@"483887" forKey:@"uid"];

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

@end
