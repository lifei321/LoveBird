//
//  UserFriendModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@interface UserFriendListModel : AppBaseModel

@property (nonatomic, strong) NSArray *data;

@end

@interface UserFriendModel : AppBaseModel

@property (nonatomic, copy) NSString *author;

@property (nonatomic, copy) NSString *authorid;

@property (nonatomic, copy) NSString *commentNum;

@property (nonatomic, copy) NSString *dateline;

@property (nonatomic, copy) NSString *imgHeight;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *imgWidth;

@property (nonatomic, copy) NSString *shareUrl;

@property (nonatomic, copy) NSString *subject;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, assign) BOOL isCollection;

@property (nonatomic, assign) BOOL isUp;

@property (nonatomic, assign) BOOL isFollow;

@property (nonatomic, assign) NSInteger upNum;

@property (nonatomic, copy) NSString *tid;



//
//author    作者名    string    @mock=$order('幽州摄伯','幽州摄伯','画龙点镜','CD境由心生','翠微山下')
//authorid    作者id    string    @mock=$order('464151','464151','383841','491479','380307')
//commentNum    评论数    number    @mock=$order(10,10,10,10,10)
//dateline    发表时间
//head    作者头像    string    @mock=$order('http://bbs.photofans.cn/uc_server/avatar.php?uid=464151&size=middle','http://bbs.photofans.cn/uc_server/avatar.php?uid=464151&size=middle','http://bbs.photofans.cn/uc_server/avatar.php?uid=383841&size=middle','http://bbs.photofans.cn/uc_server/avatar.php?uid=491479&size=middle','http://bbs.photofans.cn/uc_server/avatar.php?uid=380307&size=middle')
//imgHeight    封面图高度    number    @mock=$order(731,731,731,731,731)
//imgUrl    封面图url    string    @mock=$order('http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg')
//imgWidth    封面图宽度    number    @mock=$order(1300,1300,1300,1300,1300)
//isCollection    是否已收藏    number    @mock=$order(0,0,0,0,0)
//isUp    是否赞    number    @mock=$order(0,0,0,0,0)
//is_follow    作者是否已关注    number    @mock=$order(1,1,1,1,1)
//shareUrl    分享地址    string    @mock=$order('http://www.photofans.cn','http://www.photofans.cn','http://www.photofans.cn','http://www.photofans.cn','http://www.photofans.cn')
//subject    标题    string    @mock=$order('祝大家元宵节快乐——螺纹鸭','那年的不老屯的鵟','双鹤春鸣-----祝元宵节快乐！','朱鹮——亲昵','祝正月十五元宵节快乐------绿翅鸭')
//summary    简介    string    @mock=$order('祝大家元宵节快乐——螺纹鸭','那年的不老屯的鵟','双鹤春鸣-----祝元宵节快乐！','朱鹮——亲昵','祝正月十五元宵节快乐------绿翅鸭')
//upNum    赞数    number    @mock=$order(23,23,23,23,23)

@end
