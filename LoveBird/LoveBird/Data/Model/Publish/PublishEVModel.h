//
//  PublishEVModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol PublishEVModel;
@interface PublishEVDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <PublishEVModel>*data;

@end


@interface PublishEVModel : AppBaseModel

@property (nonatomic, copy) NSString *evId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *imgUrl;


@end
