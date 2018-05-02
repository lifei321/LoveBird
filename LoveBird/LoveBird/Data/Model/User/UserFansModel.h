//
//  UserFansModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@interface UserFansListModel : JSONModel

@property (nonatomic, strong) NSArray *data;

@end

@interface UserFansModel : AppBaseModel

@property (nonatomic, copy) NSString *birdHead;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, assign) BOOL isFollow;


//head    粉丝头像    string    @mock=http://bbs.photofans.cn/uc_server/avatar.php?uid=1&size=middle
//isFollow    是否被关注
//uid    粉丝uid    string    @mock=1
//username    粉丝用户名    string    @mock=暗盒

@end
