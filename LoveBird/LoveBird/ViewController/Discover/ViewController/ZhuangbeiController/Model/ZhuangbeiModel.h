//
//  ZhuangbeiModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol ZhuangbeiModel;

@interface ZhuangbeiDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <ZhuangbeiModel>*data;

@end

@interface ZhuangbeiModel : JSONModel

// 作者
@property (nonatomic, copy) NSString *aid;

// 评论数
@property (nonatomic, copy) NSString *commentNum;


@property (nonatomic, assign) CGFloat imgHeight;

// 封面图
@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) CGFloat imgWidth;

// 是否收藏
@property (nonatomic, assign) BOOL isCollection;

// 是否点赞
@property (nonatomic, assign) BOOL isUp;

// 文章简介
@property (nonatomic, copy) NSString *summary;

// 点赞数量
@property (nonatomic, copy) NSString *upNum;

@property (nonatomic, copy) NSString *title;

// 分享文章的url
@property (nonatomic, copy) NSString *shareUrl;

// 分享文章的url
@property (nonatomic, copy) NSString *shareImg;

// 分享文章的url
@property (nonatomic, copy) NSString *shareSummary;

// 分享文章的url
@property (nonatomic, copy) NSString *shareTitle;


@end





//aid    文章id    string    @mock=$order('4','3')
//commentNum    评论数    number    @mock=$order(10,10)
//img    封面图url    string    @mock=$order('http://www.fansimg.com/portal/201803/12/093759i2whrhms77mo7umw.jpg','http://www.fansimg.com/portal/201803/14/151655kkqpuwwk22wtp988.png')
//imgHeight    封面图高度    number    @mock=$order(462,462)
//imgWidth    封面图宽度    number    @mock=$order(720,720)
//isCollection    是否已收藏    number    @mock=$order(1,1)
//isUp    是否已赞    number    @mock=$order(1,1)
//shareUrl    分享url    string    @mock=$order('http://www.photofans.cn','http://www.photofans.cn')
//summary    文章简介    string    @mock=$order('','我的装备文章测试……我的装备文章测试我的装备文章测试……我的装备文章测试我的装备文章测试……我的装备文章测试')
//title    标题    string    @mock=$order('爱鸟网装备频道测试2','我的装备文章测试')
//upNum
