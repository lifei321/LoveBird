//
//  PublishEditViewController.h
//  LoveBird
//
//  Created by cheli shan on 2018/8/12.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController.h"
#import "MinePublishModel.h"

@interface PublishEditViewController : AppBaseTableViewController


// 当保存草稿时候，提交此参数status=4
@property (nonatomic, copy) NSString *status;

// 草稿
@property (nonatomic, copy) NSString *tid;

@property (nonatomic, copy) NSString *matchid;


// 鸟种 类型
@property (nonatomic, strong) NSMutableArray *birdInfoArray;


@property (nonatomic, strong) MinePublishModel *minePublishModel;

@end
