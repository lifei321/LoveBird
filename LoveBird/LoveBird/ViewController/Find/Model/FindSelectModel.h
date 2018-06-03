//
//  FindSelectModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/3/17.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol FindSelectModel;

@interface FindSelectDataModel :AppBaseModel

@property (nonatomic, strong) NSMutableArray <FindSelectModel>*data;

@end

@interface FindSelectModel : AppBaseModel

// 作者
@property (nonatomic, strong) NSString *author;

// 鸟编号
@property (nonatomic, strong) NSString *csp_code;

@property (nonatomic, strong) NSString *img;

@property (nonatomic, strong) NSString *imgHeight;

@property (nonatomic, strong) NSString *imgWidth;

@property (nonatomic, strong) NSString *name;


@end


