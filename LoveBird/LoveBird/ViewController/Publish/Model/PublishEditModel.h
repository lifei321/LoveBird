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

@property (nonatomic, copy) NSString *birdClass;

@property (nonatomic, assign) BOOL isImg;

@property (nonatomic, assign) BOOL isNewAid;

@property (nonatomic, copy) NSString *aid;

@property (nonatomic, copy) NSString *imgUrl;

// 文本内容
@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *tag;



// 是否显示添加图片和文字
@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, assign) BOOL isLast;


@end
