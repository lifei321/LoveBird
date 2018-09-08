//
//  MineLocationModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/9/8.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineLocationModel.h"

@implementation MineLocationModel

+(JSONKeyMapper*)keyMapper {
    
    NSDictionary *dict = @{
                           @"name": @"name",
                           @"upid": @"upid",
                           @"id": @"modelid",

                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}


@end


@implementation MineLocationDataModel

@end
