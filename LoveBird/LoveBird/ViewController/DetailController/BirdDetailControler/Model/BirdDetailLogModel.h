//
//  BirdDetailLogModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/8/14.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol BirdDetailLogModel;
@interface BirdDetailLogDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <BirdDetailLogModel> * data;

@end


@interface BirdDetailLogModel : AppBaseModel

@property (nonatomic, copy) NSString * authorName;

@property (nonatomic, copy) NSString * authorid;

@property (nonatomic, copy) NSString * imgdNum;

@property (nonatomic, copy) NSString * imgUrl;

@property (nonatomic, copy) NSString * point;

@property (nonatomic, copy) NSString * tid;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * dateline;

@property (nonatomic, assign) CGFloat imgWidth;

@property (nonatomic, assign) CGFloat imgHeight;



@end


//authorName    作者    string    @mock=$order('','','','','','')
//authorid    作者id    string    @mock=$order('483887','483887','483887','483887','483887','483887')
//imgNum    图片数量    number    @mock=$order(3,3,3,3,3,3)
//imgUrl    封面图    string    @mock=$order('','','','','','')
//point    观鸟点    string    @mock=$order('北京市海淀区','北京市海淀区','北京市海淀区','北京市海淀区','北京市海淀区','北京市海淀区')
//tid    观鸟日志id    string    @mock=$order('0','1107984','1108044','1108046','1108055','1108060')
//title
