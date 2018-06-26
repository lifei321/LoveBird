//
//  FindDisplayShapeModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@interface FindDisplayShapeModel : AppBaseModel

@property (nonatomic, strong) NSArray *shape_code;


@end


@interface FindDisplayColorModel : AppBaseModel

@property (nonatomic, strong) NSArray *color_code;

@end


@interface FindDisplayHeadModel : AppBaseModel

@property (nonatomic, strong) NSArray *bill_code;

@end
