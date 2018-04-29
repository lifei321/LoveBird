//
//  AppBaseModel.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/3.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface AppBaseModel : JSONModel

/**
 *  返回对象
 *
 *  @param errcode  返回码
 *  @param errstr   错误信息
 */
- (instancetype)initWithCode:(NSInteger)errcode errstr:(NSString *)errstr;

/**
 *  返回码
 */
@property (nonatomic, assign) NSInteger errcode;

/**
 *  错误信息
 */
@property (nonatomic, strong) NSString *errstr;

/**
 *  方便的从 APPBaseModel 转成 NSError
 */
- (NSError *)error;


@end
