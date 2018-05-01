//
//  BodyBirdModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/4/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BodyBirdModel : JSONModel

@property (nonatomic, copy) NSString *imageString;

@property (nonatomic, copy) NSString *imageId;

@property (nonatomic, copy) NSString *title;

- (instancetype)initWithString:(NSString *)imageString imageId:(NSString *)imageId title:(NSString *)title;

@end
