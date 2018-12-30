//
//  MatchDetailController.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController.h"
#import "MatchDetailModel.h"

@interface MatchDetailController : AppBaseTableViewController

@property (nonatomic, copy) NSString *matchid;

@property (nonatomic, strong) MatchDetailModel *detailModel;

@end
