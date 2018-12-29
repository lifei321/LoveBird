//
//  UserModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

typedef void(^UserModelBlock)(void);

@class UserModel;
@interface UserPage : NSObject


@property (nonatomic, strong) UserModel *userModel;

@property (nonatomic, assign) BOOL isLogin;


@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *token;



// 发布用
@property (nonatomic, copy) NSString *lng;

@property (nonatomic, copy) NSString *lat;

@property (nonatomic, copy) NSString *locale;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *SubLocality;

@property (nonatomic, copy) NSString *street;



+ (UserPage *)sharedInstance;

+ (void)setUid:(NSString *)uid;

+ (void)setToken:(NSString *)token;

+ (void)logoutBlock:(UserModelBlock)block;

+ (void)gotoLoinBlock:(UserModelBlock)block;

+ (void)gotoLoin;
@end

@interface UserModel : AppBaseModel

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *sign;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *wechat;

@property (nonatomic, copy) NSString *weibo;

@property (nonatomic, copy) NSString *articleNum;

@property (nonatomic, copy) NSString *birdspeciesNum;

@property (nonatomic, copy) NSString *credit;

@property (nonatomic, copy) NSString *fansNum;

@property (nonatomic, copy) NSString *followNum;

@property (nonatomic, assign) BOOL hasCollection;

@property (nonatomic, assign) BOOL hasFriends;

@property (nonatomic, assign) BOOL hasMessage;

@property (nonatomic, assign) BOOL isFollow;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *honor;

@property (nonatomic, copy) NSString *zuzhi;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *aboutUrl;

@property (nonatomic, copy) NSString *helpUrl;

@property (nonatomic, copy) NSString *feedbackUrl;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *QRcodeUrl;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *gid;
@property (nonatomic, copy) NSString *group;


// 分享文章的url
@property (nonatomic, copy) NSString *shareUrl;

// 分享文章的url
@property (nonatomic, copy) NSString *shareImg;

// 分享文章的url
@property (nonatomic, copy) NSString *shareSummary;

// 分享文章的url
@property (nonatomic, copy) NSString *shareTitle;

// 推送开关
@property (nonatomic, copy) NSString *system;

@property (nonatomic, copy) NSString *follow;

@property (nonatomic, copy) NSString *comment;




//articleNum    日志数    number    @mock=24
//birdspeciesNum    鸟种数    number    @mock=289
//credit    积分    number    @mock=56782
//fansNum    粉丝数    number    @mock=268
//followNum    关注数    number    @mock=344
//hasCollection    是否有收藏文章    number    @mock=1看别人时无此项
//hasFriends    是否有好友圈文章    number    @mock=1看别人时无此项
//hasMessage    是否有消息    number    @mock=1看别人时无此项
//head    头像
//isFollow    该用户是否被关注    number    @mock=1
//level    用户级别    number    @mock=4
//location    地域    string    @mock=北京
//qq
//sign    签名    string    @mock=自古英雄如美人，不许人现白头
//uid    uid    number    @mock=483887
//username    用户名    string    @mock=旭伟
//wechat    微信号    string    @mock=shuiyu2009
//weibo    微博号    string    @mock=mysinablog2017

@end
