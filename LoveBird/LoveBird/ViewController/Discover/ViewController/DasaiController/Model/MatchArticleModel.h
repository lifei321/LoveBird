//
//  MatchArticleModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/5.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol MatchArticleModel;
@interface MatchArticleDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <MatchArticleModel>*user;

@end


@protocol MatchArticleGusModel;
@interface MatchArticleModel : JSONModel

@property (nonatomic, strong) NSArray <MatchArticleGusModel>*genus;


@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *authorid;

@property (nonatomic, copy) NSString *dateline;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *locale;

@property (nonatomic, copy) NSString *tid;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) CGFloat imgHeight ;

@property (nonatomic, assign) CGFloat imgWidth;


@end

@interface MatchArticleGusModel : JSONModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *number;

@end


//author    作者    string    @mock=$order('渔民视角','渔民视角','CD境由心生','幽州摄伯','十八平')
//authorid    作者id    string    @mock=$order('428273','428273','491479','464151','120997')
//dateline    时间    string    @mock=$order('1525224292','1525224168','1525209690','1525180800','1525164586')
//genus    鸟信息（数组）    array<object>
//
//head    作者头像    string    @mock=$order('http://bbs.photofans.cn/uc_server/avatar.php?uid=428273&size=middle','http://bbs.photofans.cn/uc_server/avatar.php?uid=428273&size=middle','http://bbs.photofans.cn/uc_server/avatar.php?uid=491479&size=middle','http://bbs.photofans.cn/uc_server/avatar.php?uid=464151&size=middle','http://bbs.photofans.cn/uc_server/avatar.php?uid=120997&size=middle')
//imgHeight    封面图高度    number    @mock=$order(400,400,400,400,400)
//imgUrl    封面图url    string    @mock=$order('http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg')
//imgWidth    封面图宽度    number    @mock=$order(600,600,600,600,600)
//locale    观鸟点    string    @mock=$order('若尔盖大草原','若尔盖大草原','若尔盖大草原','若尔盖大草原','若尔盖大草原')
//tid


//name    鸟名    string    @mock=$order('小山雀','栗腹文鸟')
//number    数量    number    @mock=$order(3,2)
