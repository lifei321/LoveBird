//
//  MatchArticleModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/5.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MatchArticleModel.h"


@implementation MatchArticleDataModel
//+ (JSONKeyMapper *)keyMapper {
//    return [[JSONKeyMapper alloc] initWithModelToJSONBlock:^NSString *(NSString *keyName) {
//        return [NSString stringWithFormat:@"data.%@", keyName];
//    }];
//}
@end

@implementation MatchArticleModel
+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}
@end



@implementation MatchArticleGusModel

+ (BOOL)propertyIsOptional:(NSString*)propertyName {
    return YES;
}

@end
