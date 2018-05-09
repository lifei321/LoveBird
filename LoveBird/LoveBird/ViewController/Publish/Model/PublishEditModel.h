//
//  PublishEditModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "PublishUpModel.h"

@interface PublishEditModel : JSONModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *birdClass;

@property (nonatomic, strong) UIImage *imageSelect;

@property (nonatomic, strong) PublishUpModel *upModel;

// 是否显示添加图片和文字
@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, assign) BOOL isLast;


@end
