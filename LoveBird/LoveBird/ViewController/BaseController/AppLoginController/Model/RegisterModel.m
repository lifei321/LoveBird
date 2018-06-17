//
//  RegisterModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/18.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "RegisterModel.h"

@implementation RegisterDataModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONBlock:^NSString *(NSString *keyName) {
        return [NSString stringWithFormat:@"data.%@", keyName];
    }];
}
@end


@implementation RegisterModel
+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end
