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


@interface ClassifyModel : JSONModel

@property (nonatomic, copy) NSString *nameBgImg;

@property (nonatomic, copy) NSString *subject;

@property (nonatomic, copy) NSString *family;

@property (nonatomic, copy) NSString *genus;



@end
