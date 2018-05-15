//
//  ShequModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/15.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol ShequModel;
@interface ShequDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <ShequModel>*data;

@end

@interface ShequModel : AppBaseModel

@property (nonatomic, copy) NSString * author;

@property (nonatomic, copy) NSString * authorid;

@property (nonatomic, copy) NSString * authorlv;

@property (nonatomic, copy) NSString * commentNum;

@property (nonatomic, copy) NSString * datelien;

@property (nonatomic, copy) NSString * head;

@property (nonatomic, copy) NSString * imgHeight;

@property (nonatomic, copy) NSString * imgWidth;

@property (nonatomic, copy) NSString * imgUrl;

@property (nonatomic, assign) BOOL  isCollection;

@property (nonatomic, assign) BOOL  isUp;

@property (nonatomic, assign) BOOL  is_follow;

@property (nonatomic, copy) NSString * shareUrl;

@property (nonatomic, copy) NSString * subject;

@property (nonatomic, copy) NSString * summary;

@property (nonatomic, copy) NSString * upNum;


//author    作者名    string
//authorid    作者id    string
//authorlv    作者级别    number
//commentNum    评论数    number
//datelien    时间
//head    作者头像url    string
//imgHeight    封面图高度    number
//imgUrl    封面图url    string
//imgWidth    封面图宽度    number
//isCollection    用户是否已收藏    number    @mock=$order(0,0,0,0,0,0,0,0,0,0)
//isUp    用户是否已赞    number    @mock=$order(0,0,0,0,0,0,0,0,0,0)
//is_follow    是否已关注作者        1:已关注；0：未关注
//shareUrl    分享地址    string
//subject    标题    string
//summary    简介    string
//upNum    赞数    number

@end
