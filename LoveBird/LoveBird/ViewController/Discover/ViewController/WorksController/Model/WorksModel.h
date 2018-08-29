//
//  WorksModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol WorksListModel;
@protocol WorksModel;

@interface WorksDataModel : AppBaseModel


@property (nonatomic, strong) NSArray *imgList;


@property (nonatomic, copy) NSString *maxAid;

@end


@interface WorksModel : JSONModel


@property (nonatomic, copy) NSString *aid;

@property (nonatomic, copy) NSString *dateline;

@property (nonatomic, copy) NSString *tags;


@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) CGFloat imgHeight;


@property (nonatomic, assign) CGFloat imgWidth;

@property (nonatomic, copy) NSString *authorid;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *tid;

@property (nonatomic, copy) NSString *imgExifModel;

@property (nonatomic, copy) NSString *imgExifLen;

@property (nonatomic, copy) NSString *imgExifParameter;

@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, copy) NSString *shareTitle;

@property (nonatomic, copy) NSString *shareSummary;

@property (nonatomic, copy) NSString *shareImg;

@end


//aid    作品id
//dateline
//imgHeigh    图片高度
//imgUrl
//imgWidth    图片宽度
