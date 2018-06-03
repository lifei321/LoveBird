//
//  LogDetailModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"


@protocol LogBirdInfoModel;
@protocol LogPostBodyModel;
@interface LogDetailModel : AppBaseModel

@property (nonatomic, assign) CGFloat imgWidth;

@property (nonatomic, strong) NSArray <LogBirdInfoModel>*birdInfo;

@property (nonatomic, strong) NSArray <LogPostBodyModel>*postBody;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *authorHead;

@property (nonatomic, copy) NSString *authorid;

@property (nonatomic, copy) NSString *coverImgUrl;

@property (nonatomic, assign) CGFloat coverImgHeight;

@property (nonatomic, assign) CGFloat coverImgWidth;

@property (nonatomic, copy) NSString *environment;

@property (nonatomic, assign) BOOL isCollection;

@property (nonatomic, assign) BOOL isFollow;

@property (nonatomic, assign) BOOL isUp;

@property (nonatomic, copy) NSString *lat;

@property (nonatomic, copy) NSString *lng;

@property (nonatomic, copy) NSString *locale;

@property (nonatomic, copy) NSString *observeTime;

@property (nonatomic, copy) NSString *publishTime;

@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, copy) NSString *title;


@end


@interface LogBirdInfoModel : JSONModel

@property (nonatomic, copy) NSString *csp_code;

@property (nonatomic, copy) NSString *genus;

@property (nonatomic, copy) NSString *num;

@end

@interface LogPostBodyModel : JSONModel

@property (nonatomic, copy) NSString *aid;

@property (nonatomic, copy) NSString *imgTag;

@property (nonatomic, assign) CGFloat imgHeight;

@property (nonatomic, assign) CGFloat imgWidth;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, assign) BOOL isImg;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *imgExifModel;

@property (nonatomic, copy) NSString *imgExifLen;

@property (nonatomic, copy) NSString *imgExifParameter;

@end

//
//author    作者    string    @mock=爱鸟网
//authorHead    作者头像    string    @mock=http://bbs.photofans.cn/uc_server/data/avatar/000/48/38/87_avatar_small.jpg
//authorid    作者id    number    @mock=487883
//birdInfo    鸟种信息（数组）    array<object>
//
//coverImgUrl    封面图url    string    @mock=http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg
//coverImgUrlHeight    封面图高度    number    @mock=400
//coverImgUrlWidth    封面图宽度    number    @mock=600
//environment    生态环境
//isCollection    是否已收藏    number    @mock=1
//isFollow    是否已关注作者    number    @mock=1
//isUp    是否已赞    number    @mock=1
//lat    纬度    number    @mock=39.23
//lng    经度    number    @mock=123.16
//locale    观鸟点    string    @mock=北京市
//observeTime    观鸟时间    number    @mock=1524816260
//postBody    观鸟日志文章主体（数组）    array<object>
//
//publishTime    发表时间    number    @mock=1524819860
//shareUrl
//
//
//
//
//csp_code    鸟编号    number    @mock=$order(200000,200001)
//genus    鸟种名称    string    @mock=$order('麻雀','翠鸟')
//num    数量    number    @mock=$order(2,3)
//
//
//
//aid    图片id    number
//imgHeight    图片高度    number    @mock=$order(0,655,0,683,0,1024,0,683,0,649,0,1024,0,683,0,683,0,1024,0,683,0,683,0,1024)
//imgTag    图片标签    string
//imgUrl    图片url    string
//imgWidth    图片宽度    number
//isImg    是否图片    number
//message    文本内容    string    如果是图片isImg=1,则没有文本内容，反正有文本则没有图片







