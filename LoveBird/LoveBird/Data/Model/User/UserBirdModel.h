//
//  UserBirdModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@interface UserBirdDataModel : AppBaseModel

@property (nonatomic, strong) NSArray *birdInfo;

@property (nonatomic, assign) NSInteger birdNum;


@end

@interface UserBirdModel : JSONModel

@property (nonatomic, copy) NSString *birdHead;

@property (nonatomic, copy) NSString *cspCode;

@property (nonatomic, copy) NSString *dateline;

@property (nonatomic, copy) NSString *name;


//bird_head    鸟头像    string    @mock= http://bird.obs.myhwclouds.com/birdpic/P00171.jpg
//csp_code    鸟编号
//dateline    时间    string    @mock=1520655475
//name    鸟名    string    @mock=普通翠鸟
@end
