//
//  UserFollowModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol UserFollowModel;
@interface UserFollowListModel : AppBaseModel

@property (nonatomic, strong) NSArray <UserFollowModel>*data;

@end

@interface UserFollowModel : AppBaseModel

// 头像
@property (nonatomic, copy) NSString *head;

// 被关注用户id
@property (nonatomic, copy) NSString *uid;

// 被关注用户昵称
@property (nonatomic, copy) NSString *username;

// 是否关注
@property (nonatomic, assign) BOOL isFollow;

@end
