//
//  MinePublishModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/8/12.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MinePublishModel.h"

@implementation MinePublishModel


+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONBlock:^NSString *(NSString *keyName) {
        return [NSString stringWithFormat:@"data.%@", keyName];
    }];
}


@end

@implementation MinePublishBodyModel
+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}

@end
