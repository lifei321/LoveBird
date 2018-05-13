//
//  FindDao.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindDao.h"
#import "FindSelectBirdModel.h"

@implementation FindDao

+ (void)getBird:(NSString *)text genus:(NSString *)genus successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(genus) forKey:@"genus"];
    [dic setObject:EMPTY_STRING_IF_NIL(text) forKey:@"keywords"];

    [AppHttpManager POST:kAPI_Find_Bird_SearchBird parameters:dic jsonModelName:[FindSelectBirdDataModel class] success:^(__kindof AppBaseModel *responseObject) {
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
