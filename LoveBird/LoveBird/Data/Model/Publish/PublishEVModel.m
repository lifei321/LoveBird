//
//  PublishEVModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishEVModel.h"

@implementation PublishEVDataModel

@end

@implementation PublishEVModel

+(JSONKeyMapper*)keyMapper {
    
    NSDictionary *dict = @{
                           @"id": @"evId",
                           @"name": @"name"
                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}

@end
