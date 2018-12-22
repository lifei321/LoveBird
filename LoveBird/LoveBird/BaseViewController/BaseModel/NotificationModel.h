//
//  NotificationModel.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/17.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@interface NotificationModel : AppBaseModel

///**
// *  标题
// */
//@property (nonatomic, copy) NSString *title;
//
///**
// *  消息内容
// */
//@property (nonatomic, copy) NSString *message;
//
///**
// *  附带参数 里面包括跳转需要的参数
// */
//@property (nonatomic, copy) NSString *extradata;
//
///**
// *  执行的操作
// */
//@property (nonatomic, copy) NSString *action;
//
//
///**
// *  message id
// */
//@property (nonatomic, copy) NSString *msgId;

// 跳转动作
@property (nonatomic, copy) NSString *view_status;

// 帖子id
@property (nonatomic, copy) NSString *pushId;

@end
