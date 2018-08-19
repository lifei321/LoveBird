//
//  LogDetailTalkModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogDetailTalkModel.h"



@implementation LogDetailTalkDataModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONBlock:^NSString *(NSString *keyName) {
        return [NSString stringWithFormat:@"data.%@", keyName];
    }];
}
@end

@implementation LogDetailTalkModel
+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end


@implementation LogDetailTalkWordDataModel


@end



