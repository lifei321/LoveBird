//
//  LogDetailModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogDetailModel.h"

@implementation LogDetailModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONBlock:^NSString *(NSString *keyName) {
        return [NSString stringWithFormat:@"data.%@", keyName];
    }];
}
@end


@implementation LogBirdInfoModel

+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}


@end


@implementation LogPostBodyModel

+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}


@end

@implementation LogAdArticleModel

+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}


@end


@implementation LogExtendArticleModel

+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}


@end

