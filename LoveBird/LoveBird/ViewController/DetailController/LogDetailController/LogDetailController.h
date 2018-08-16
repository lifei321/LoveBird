//
//  LogDetailController.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController.h"

@interface LogDetailController : AppBaseTableViewController

// 帖子的id
@property (nonatomic, copy) NSString *tid;

// 文章id
@property (nonatomic, copy) NSString *aid;

// 1 观鸟记录
@property (nonatomic, assign) NSInteger logType;


@end
