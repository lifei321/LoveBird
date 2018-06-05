//
//  ShequModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/15.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ShequModel.h"

@implementation ShequLogModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONBlock:^NSString *(NSString *keyName) {
        return [NSString stringWithFormat:@"data.%@", keyName];
    }];
}

+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}

@end

@implementation ShequDataModel


+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end


@implementation ShequModel


+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}

@end
