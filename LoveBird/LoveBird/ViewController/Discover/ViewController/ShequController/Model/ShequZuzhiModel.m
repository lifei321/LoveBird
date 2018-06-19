//
//  ShequZuzhiModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/19.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ShequZuzhiModel.h"

@implementation ShequZuzhiModel

+(JSONKeyMapper*)keyMapper {
    
    NSDictionary *dict = @{
                           @"id": @"birdId",
                           @"name": @"name"
                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}

@end


@implementation ShequZuzhiDataModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONBlock:^NSString *(NSString *keyName) {
        return [NSString stringWithFormat:@"data.%@", keyName];
    }];
}
@end
