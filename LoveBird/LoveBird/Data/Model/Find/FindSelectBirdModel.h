//
//  FindSelectBirdModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol FindSelectBirdModel;
@interface FindSelectBirdDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <FindSelectBirdModel>*data;

@end

@interface FindSelectBirdModel : JSONModel

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *bird_img;

@property (nonatomic, copy) NSString *bird_img_height;

@property (nonatomic, copy) NSString *bird_img_width;

@property (nonatomic, copy) NSString *csp_code;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *name_en;

@property (nonatomic, copy) NSString *name_la;

// 是否是 选择
@property (nonatomic, assign) BOOL isSelect;

// 数量
@property (nonatomic, assign) NSInteger num;

@end
