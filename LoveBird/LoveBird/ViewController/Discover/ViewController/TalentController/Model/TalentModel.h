//
//  TalentModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/3/4.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"


@protocol TalentModel;

@interface TalentDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <TalentModel>*data;

@end

@interface TalentModel : AppBaseModel

// 头像url
@property (nonatomic, copy) NSString *head;

// 达人名
@property (nonatomic, copy) NSString *master;


@property (nonatomic, copy) NSString *msaterid;

// 达人级别
@property (nonatomic, copy) NSString *masterlv;

// 是否关注
@property (nonatomic, assign) BOOL is_follow;


@property (nonatomic, strong) NSArray *medalUrl;


@end
