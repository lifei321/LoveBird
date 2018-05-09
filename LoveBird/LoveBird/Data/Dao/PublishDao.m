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

@implementation PublishDao

// 上传图片
+ (void)upLoad:(UIImage *)image successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"483887" forKey:@"uid"];
    
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

+ (void)publish:(NSArray *)editModelArray successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSMutableArray *tempArray = [NSMutableArray new];
    for (PublishEditModel *model in editModelArray) {
        [tempArray addObject:[model toDictionary]];
    }
    [dic setObject:tempArray forKey:@"postList"];
    [dic setObject:@"483887" forKey:@"birdInfo"];
    [dic setObject:@"483887" forKey:@"environmentId"];
    [dic setObject:@"483887" forKey:@"lat"];
    [dic setObject:@"483887" forKey:@"lng"];
    [dic setObject:@"483887" forKey:@"locale"];
    [dic setObject:@"483887" forKey:@"observeTime"];
    [dic setObject:@"483887" forKey:@"status"];
    [dic setObject:@"483887" forKey:@"uid"];
    NSDictionary *params = @{@"articleBody": @[dic]};

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
@end
