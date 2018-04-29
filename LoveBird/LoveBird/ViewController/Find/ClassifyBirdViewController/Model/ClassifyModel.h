//
//  ClassifyModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/3/18.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol ClassifyModel;

@interface ClassifyDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <ClassifyModel> *data;

@end


@interface ClassifyModel : AppBaseModel

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *family;



@end
