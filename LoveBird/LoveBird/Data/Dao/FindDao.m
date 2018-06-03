//
//  FindDao.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindDao.h"
#import "FindSelectBirdModel.h"
#import "FindDisplayShapeModel.h"
#import "ClassifyModel.h"

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


// 体型查鸟
+ (void)getBirdBillCode:(NSString *)bill
                  color:(NSString *)color
                 length:(NSString *)length
                  shape:(NSString *)shape
                   page:(NSString *)page
           successBlock:(LFRequestSuccess)successBlock
           failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(bill) forKey:@"bill_code"];
    [dic setObject:EMPTY_STRING_IF_NIL(color) forKey:@"color_code"];
    [dic setObject:EMPTY_STRING_IF_NIL(length) forKey:@"length_code"];
    [dic setObject:EMPTY_STRING_IF_NIL(page) forKey:@"page"];
    [dic setObject:EMPTY_STRING_IF_NIL(shape) forKey:@"shape_code"];

    [AppHttpManager POST:kAPI_Find_Bird_shape parameters:dic jsonModelName:[FindSelectBirdDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
}

// 体型可选项
+ (void)getBirdDisplayShape:(NSString *)text successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(text) forKey:@"length_code"];
    
    [AppHttpManager POST:kAPI_Find_Bird_displayshape parameters:dic jsonModelName:[FindDisplayShapeModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 类别查鸟
+ (void)getBirdClassSuccessBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    
    [AppHttpManager POST:kAPI_Find_Bird_subject parameters:dic jsonModelName:[ClassifyDataModel class] success:^(__kindof AppBaseModel *responseObject) {
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
