//
//  DiscoverContentModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/3/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol DiscoverContentModel;

@interface DiscoverContentDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <DiscoverContentModel>*data;

@end

@interface DiscoverContentModel : JSONModel

// 作者
@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *authorid;

// 评论数
@property (nonatomic, copy) NSString *commentNum;

// 发表时间
@property (nonatomic, copy) NSString *dateline;

// 作者头像
@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) CGFloat imgHeight;

// 封面图
@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) CGFloat imgWidth;

// 是否收藏
@property (nonatomic, assign) BOOL isCollection;

// 是否关注作者
@property (nonatomic, assign) BOOL is_follow;

// 是否点赞
@property (nonatomic, assign) BOOL isUp;

// 文章标题
@property (nonatomic, copy) NSString *subject;

// 文章简介
@property (nonatomic, copy) NSString *summary;

// 点赞数量
@property (nonatomic, copy) NSString *upNum;

@property (nonatomic, copy) NSString *aid;

@property (nonatomic, copy) NSString *tid;

@property (nonatomic, copy) NSString *webView;

@property (nonatomic, assign) NSInteger article_status;


// 分享文章的url
@property (nonatomic, copy) NSString *shareUrl;

// 分享文章的url
@property (nonatomic, copy) NSString *shareImg;

// 分享文章的url
@property (nonatomic, copy) NSString *shareSummary;

// 分享文章的url
@property (nonatomic, copy) NSString *shareTitle;


@end
