//
//  PublishUpModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishUpModel.h"

@implementation PublishUpModel

+(JSONKeyMapper*)keyMapper {
    
    NSDictionary *dict = @{
                           @"data.aid": @"aid",
                           @"data.imgUrl": @"imgUrl"
                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}

@end
