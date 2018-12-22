//
//  GlobelMessage.m
//  LoveBird
//
//  Created by 十八子飞 on 2018/12/22.
//  Copyright © 2018 shancheli. All rights reserved.
//

#import "GlobelMessage.h"

@implementation GlobelMessage


+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONBlock:^NSString *(NSString *keyName) {
        return [NSString stringWithFormat:@"data.%@", keyName];
    }];
}


@end
