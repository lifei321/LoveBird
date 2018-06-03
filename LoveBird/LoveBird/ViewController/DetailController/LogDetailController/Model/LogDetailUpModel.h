//
//  LogDetailUpModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol LogDetailUpModel;
@interface LogDetailUpDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <LogDetailUpModel>*data;

@end

@interface LogDetailUpModel : JSONModel


@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *dateline;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *userName;

@end




//---点赞者头像    head    string    @mock=$order('http://bbs.photofans.cn/uc_server/avatar.php?uid=483887&size=middle','http://bbs.photofans.cn/uc_server/avatar.php?uid=1&size=middle')
//---点赞时间    dateline    string    @mock=$order('1520000000','1520000000')
//---    uid    string    @mock=$order('483887','1')
//---点赞者用户名    userName
