//
//  FindSelectBirdModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindSelectBirdModel.h"

@implementation FindSelectBirdDataModel

@end

@implementation FindSelectBirdModel

+(JSONKeyMapper*)keyMapper {
    
    NSDictionary *dict = @{
                           @"author": @"author",
                           @"bird_img": @"bird_img",
                           @"bird_img_height": @"bird_img_height",
                           @"bird_img_width": @"bird_img_width",
                           @"csp_code": @"csp_code",
                           @"name": @"name",
                           @"name_en": @"name_en",
                           @"name_la": @"name_la",
                           };
    
    return [[JSONKeyMapper alloc] initWithDictionary:dict];
}

+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}

@end
