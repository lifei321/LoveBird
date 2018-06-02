//
//  BirdDetailModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailModel.h"

@implementation BirdDetailModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONBlock:^NSString *(NSString *keyName) {
        return [NSString stringWithFormat:@"data.%@", keyName];
    }];
}
@end


@implementation BirdDetailImageModel


@end

@implementation BirdDetailSongModel


@end


@implementation BirdDetailVedioModel


@end
