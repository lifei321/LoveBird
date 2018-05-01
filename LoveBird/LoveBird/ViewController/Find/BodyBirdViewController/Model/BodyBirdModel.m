//
//  BodyBirdModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/4/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BodyBirdModel.h"

@implementation BodyBirdModel

- (instancetype)initWithString:(NSString *)imageString imageId:(NSString *)imageId title:(NSString *)title {
    BodyBirdModel *model = [[BodyBirdModel alloc] init];
    model.imageString = imageString;
    model.imageId = imageId;
    model.title = title;
    
    return model;
}

@end
