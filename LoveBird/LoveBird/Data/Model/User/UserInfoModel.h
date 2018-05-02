//
//  UserInfoModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@interface UserInfoModel : AppBaseModel

@property (nonatomic, copy) NSString *credit;

@property (nonatomic, assign) BOOL hasCollection;

@property (nonatomic, assign) BOOL hasFriends;

@property (nonatomic, assign) BOOL hasMessage;

@property (nonatomic, assign) BOOL isFollow;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, assign) NSInteger followNum;

@property (nonatomic, assign) NSInteger fansNum;

@property (nonatomic, assign) NSInteger articleNum;

@property (nonatomic, assign) NSInteger birdspeciesNum;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *sign;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *wechat;

@property (nonatomic, copy) NSString *weibo;


@end



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
