//
//  ShequZuzhiModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/19.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol ShequZuzhiModel;
@interface ShequZuzhiDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <ShequZuzhiModel>*group;

@property (nonatomic, strong) NSArray <ShequZuzhiModel>*sort;

@end


@interface ShequZuzhiModel : AppBaseModel

@property (nonatomic, copy) NSString *birdId;

@property (nonatomic, copy) NSString *name;

@end


//group    观鸟组织（数组）    array<object>
//id        string    @mock=$order('1','2','3')
//name        string    @mock=$order('林鸟','水鸟','猛禽')
//sort    鸟分类（数组）    array<object>
//id        string    @mock=$order('3','1','2')
//name
