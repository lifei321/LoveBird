//
//  RankModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol RankModel;
@interface RankDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <RankModel>*user;


@property (nonatomic, copy) NSString *title;


@property (nonatomic, copy) NSString *titleFirst;

@property (nonatomic, copy) NSString *titleSecond;



@end


@interface RankModel : JSONModel


@property (nonatomic, copy) NSString *articleNum;

@property (nonatomic, copy) NSString *credit;

@property (nonatomic, copy) NSString *genusNum;


@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *username;


@property (nonatomic, copy) NSString *uid;

@property (nonatomic, assign) BOOL isFollow;

@property (nonatomic, assign) NSInteger second;


@end


//
//articleNum    文章数        type==200 有此参数；
//credit    积分    number    type==300 有此参数；
//genusNum    鸟种        type==100 有此参数；
//head    头像    string
//isFollow    是否关注    number    @mock=$order(1,1,1,1,1,1,1,1,1,1)
//uid    用户id    number    @mock=$order(10,9,8,7,6,5,4,3,2,1)
//username    用户名
