//
//  MineLocationModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/9/8.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@interface MineLocationModel : AppBaseModel

@property (nonatomic, copy) NSString *modelid;

@property (nonatomic, copy) NSString *upid;

@property (nonatomic, copy) NSString *name;


@end

@protocol  MineLocationModel;
@interface MineLocationDataModel : AppBaseModel


@property (nonatomic, strong) NSArray <MineLocationModel>* data;

@end

