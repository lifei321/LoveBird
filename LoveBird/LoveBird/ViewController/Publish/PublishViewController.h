//
//  PublishViewController.h
//  LoveBird
//
//  Created by ShanCheli on 2018/1/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController.h"

@interface PublishViewController : AppBaseTableViewController

// 当保存草稿时候，提交此参数status=4
@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *tid;

@property (nonatomic, copy) NSString *matchid;



@end
