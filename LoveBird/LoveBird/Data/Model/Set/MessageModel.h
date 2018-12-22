//
//  MessageModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol MessageModel;
@interface MessageDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <MessageModel>*data;


@end

@interface MessageModel : JSONModel

@property (nonatomic, copy) NSString *dateline;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *messageContent;

@property (nonatomic, copy) NSString *messageUid;

@property (nonatomic, copy) NSString *messageUsername;

@end


//dateline        number    @mock=$order(1525145419,1525059019,1524972619,1524886219,1524799819)
//head    发消息用户头像
//messageContent    消息内容    string    @mock=$order('这是消息内容，请查收','这是消息内容，请查收','这是消息内容，请查收','这是消息内容，请查收','这是消息内容，请查收')
//messageUid    发消息用户id    number    @mock=$order(1,1,1,1,1)
//messageUsername    发消息用户名


@interface MessageCountModel:AppBaseModel

@property (nonatomic, assign) NSInteger sysNum;

@property (nonatomic, assign) NSInteger commentNum;


@property (nonatomic, assign) NSInteger followNum;

@property (nonatomic, assign) NSInteger upNum;

@property (nonatomic, assign) NSInteger mailNum;

// 所有的维度数量
@property (nonatomic, copy) NSString *allNum;


@end
