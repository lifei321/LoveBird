//
//  LogDetailTalkModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol LogDetailTalkModel;
@interface LogDetailTalkDataModel : AppBaseModel

@property (nonatomic, copy) NSString *count;

@property (nonatomic, strong) NSArray <LogDetailTalkModel>*commentList;


@end

@interface LogDetailTalkModel : JSONModel

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *dateline;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) BOOL isUp;


@end

//commentList        array<object>
//
//count    总评论数
//
//
//content    评论内容    string
//dateline    评论时间    string
//head    评论者头像    string
//uid    评论者id    string
//userName    评论者用户名    string
