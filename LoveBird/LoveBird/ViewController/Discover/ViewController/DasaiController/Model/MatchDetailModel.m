//
//  MatchDetailModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/5.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MatchDetailModel.h"

@implementation MatchDetailModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONBlock:^NSString *(NSString *keyName) {
        return [NSString stringWithFormat:@"data.%@", keyName];
    }];
}
@end
