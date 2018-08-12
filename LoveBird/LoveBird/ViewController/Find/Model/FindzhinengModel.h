//
//  FindzhinengModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/8/12.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol FindzhinengModel;
@interface FindzhinengDataModel :AppBaseModel

@property (nonatomic, strong) NSMutableArray <FindzhinengModel>*data;

@end

@interface FindzhinengModel : AppBaseModel

// 鸟编号
@property (nonatomic, strong) NSString *csp_code;

@property (nonatomic, strong) NSString *imgUrl;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *name_la;

@property (nonatomic, strong) NSString *score;


@end
