//
//  MessageModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageDataModel

@end


@implementation MessageModel

+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}

@end



@implementation MessageCountModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONBlock:^NSString *(NSString *keyName) {
        return [NSString stringWithFormat:@"data.%@", keyName];
    }];
}


@end
