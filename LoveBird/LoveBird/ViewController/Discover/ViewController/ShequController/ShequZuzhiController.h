//
//  ShequZuzhiController.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/19.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController.h"
#import "ShequZuzhiModel.h"

@interface ShequZuzhiController : AppBaseTableViewController

@property (nonatomic, strong) ShequZuzhiDataModel *dataModel;

@property (nonatomic, copy) NSString *groupId;

@property (nonatomic, copy) NSString *sortId;

// 选中的组织
@property (nonatomic,strong) ShequZuzhiModel *zuzhiModel;

// 来源 1 社区        2 完善信息
@property (nonatomic, assign) NSInteger fromType;


@end
