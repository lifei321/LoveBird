//
//  LogContentModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"
#import "LogDetailModel.h"


@protocol LogExtendArticleModel;

@class LogAdArticleModel;


@protocol LogPostBodyModel;
@interface LogContentModel : AppBaseModel

@property (nonatomic, strong) NSArray <LogPostBodyModel>*articleList;


@property (nonatomic, copy) NSString *authorid;

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *origina;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL isEditor;

@property (nonatomic, assign) BOOL isFollow;

@property (nonatomic, assign) BOOL isUp;

@property (nonatomic, assign) BOOL isCollection;




@property (nonatomic, copy) NSString *dateline;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *editWebVIew;

@property (nonatomic, copy) NSString *coverImgUrl;

@property (nonatomic, copy) NSString *editor;

@property (nonatomic, copy) NSString *from;

@property (nonatomic, assign) CGFloat coverImgHeight;

@property (nonatomic, assign) CGFloat coverImgWidth;



// 分享文章的url
@property (nonatomic, copy) NSString *shareUrl;

// 分享文章的url
@property (nonatomic, copy) NSString *shareImg;

// 分享文章的url
@property (nonatomic, copy) NSString *shareSummary;

// 分享文章的url
@property (nonatomic, copy) NSString *shareTitle;



@property (nonatomic, strong) NSArray <LogExtendArticleModel>*extendArticle;


@property (nonatomic, strong) LogAdArticleModel *adArticle;


@end


//---作者id    authorid
//---作者    author    string    @mock=
//---文章正文list    articleList    array<object>
//
//---是否可编辑    isEditor    number    如果用户是编辑，当点击操作按钮时，有三个操作项：编辑，删除，分享。其他用户只用分享功能；
//---分享url    shareUrl    string    @mock=http://bbs.photofans.cn
//---是否已关注作者    isFollow    number    @mock=1
//---是否赞    isUp    number    @mock=1
//---标题    title    string    @mock=
//---发表时间    dateline    number    @mock=1523697227
//---作者头像    head    string    @mock=http://bbs.photofans.cn/uc_server/data/avatar/000/48/38/87_avatar_small.jpg
//---点击编辑跳转webView地址    editWebVIew
