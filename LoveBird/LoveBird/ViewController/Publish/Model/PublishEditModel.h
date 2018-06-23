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

// 是否是新上传的图片
@property (nonatomic, assign) BOOL isNewAid;

// 图片的id
@property (nonatomic, copy) NSString *aid;

// 图片的地址
@property (nonatomic, copy) NSString *imgUrl;

// 文本内容
@property (nonatomic, copy) NSString *message;

// 是否是图片格式的cell  no是文字格式的cell
@property (nonatomic, assign) BOOL isImg;

// 鸟种编号
@property (nonatomic, copy) NSString *csp_code;

// 图片标签
@property (nonatomic, copy) NSString *imgTag;


/**********************************/
//自定义字段

@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, assign) BOOL isLast;


// 是  添加图片和文字形式的cell
@property (nonatomic, assign) BOOL isAddShowTextAndImageView;

// 是加号形式的cell
@property (nonatomic, assign) BOOL isAddType;

@end
