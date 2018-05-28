//
//  DetailDao.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "DetailDao.h"
#import "LogDetailModel.h"


@implementation DetailDao

// 获取日志详情
+ (void)getLogDetail:(NSString *)tid successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:@"483887" forKey:@"uid"];
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

@end
