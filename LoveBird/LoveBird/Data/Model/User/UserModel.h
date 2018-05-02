//
//  UserModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@interface UserModel : AppBaseModel

@property (nonatomic, assign) NSInteger gender;

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


//birthday    生日    string    @mock=1976-09-09
//gender    性别 1:男；2：女；0：保密    number    @mock=1
//head    头像url    string    @mock=http://bbs.photofans.cn/uc_server/avatar.php?uid=483887&size=large
//location    地域    string    @mock=北京
//mobile    手机    number    @mock=13311321077
//qq        number    @mock=723300952
//sign    签名    string    @mock=自古英雄如美人，不许人现白头
//uid        string    @mock=483887
//username    昵称    string    @mock=旭伟
//wechat    微信    string    @mock=shuiyu2009
//weibo    微博    string    @mock=mysinablog2017

@end
