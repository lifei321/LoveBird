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
#import "GuideModel.h"
#import "FindzhinengModel.h"

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

// 颜色
+ (void)getBirdDisplayColor:(NSString *)text shape:(NSString *)shape successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(text) forKey:@"length_code"];
    [dic setObject:EMPTY_STRING_IF_NIL(shape) forKey:@"shape_code"];

    
    
    [AppHttpManager POST:kAPI_Find_Bird_displaycolor parameters:dic jsonModelName:[FindDisplayColorModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


// 鸟头
+ (void)getBirdDisplayHead:(NSString *)text shape:(NSString *)shape color:(NSString *)color successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(text) forKey:@"length_code"];
    [dic setObject:EMPTY_STRING_IF_NIL(shape) forKey:@"shape_code"];
    [dic setObject:EMPTY_STRING_IF_NIL(color) forKey:@"color_code"];

    [AppHttpManager POST:kAPI_Find_Bird_displayhead parameters:dic jsonModelName:[FindDisplayHeadModel class] success:^(__kindof AppBaseModel *responseObject) {
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
+ (void)getBirdClass:(NSInteger)type
              family:(NSString *)family
             subject:(NSString *)subject
        successBlock:(LFRequestSuccess)successBlock
        failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(family) forKey:@"family"];
    [dic setObject:EMPTY_STRING_IF_NIL(subject) forKey:@"subject"];

    NSString *url;
    if (type == 1) {
        url = kAPI_Find_Bird_subject;
    } else if (type == 2) {
        url = kAPI_Find_Bird_family;
    } else if (type == 3) {
        url = kAPI_Find_Bird_genus;
    }
    
    [AppHttpManager POST:url parameters:dic jsonModelName:[ClassifyDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 鸟岛列表
+ (void)getGuide:(NSString *)pageNum successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(pageNum) forKey:@"page"];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    
    [AppHttpManager POST:kAPI_Find_Bird_travelList parameters:dic jsonModelName:[GuideDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 搜索鸟种
+ (void)getBirdWord:(NSString *)word successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL(word) forKey:@"keywords"];
    
    [AppHttpManager POST:kAPI_Find_Search_bird parameters:dic jsonModelName:[FindSelectBirdDataModel class] success:^(__kindof AppBaseModel *responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(__kindof AppBaseModel *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// 图片查鸟
+ (void)getBirdImage:(UIImage *)image successBlock:(LFRequestSuccess)successBlock failureBlock:(LFRequestFail)failureBlock {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    [dic setObject:EMPTY_STRING_IF_NIL([UserPage sharedInstance].userModel.uid) forKey:@"uid"];
    
    NSData *data = UIImageJPEGRepresentation(image, (CGFloat)0.3);//.jpg
    NSDictionary *fileDic = @{@"file": data,
                              @"fileName":@"file_bird",
                              };
    [AppHttpManager POST:kAPI_Find_Search_image_bird
              parameters:dic
               fileArray:@[fileDic]
           jsonModelName:[FindzhinengDataModel class]
                 success:^(__kindof AppBaseModel *responseObject) {
                     if (successBlock) {
                         successBlock(responseObject);
                     }
                 } uploadProgress:^(NSProgress *progress) {
                     
                 } failure:^(__kindof AppBaseModel *error) {
                     if (failureBlock) {
                         failureBlock(error);
                     }
                 }];
}

@end
