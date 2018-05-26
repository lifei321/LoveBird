//
//  UserBirdModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "UserBirdModel.h"

@implementation UserBirdDataModel

+(JSONKeyMapper*)keyMapper {
    
    NSDictionary *dict = @{
                           @"data.birdInfo": @"birdInfo",
                           @"data.birdNum": @"birdNum"
                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}

@end

@implementation UserBirdModel
+(JSONKeyMapper*)keyMapper {
    
    NSDictionary *dict = @{
                           @"bird_head": @"birdHead",
                           @"dateline": @"dateline",
                           @"csp_code": @"cspCode",
                           @"name": @"name",
                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}

@end
