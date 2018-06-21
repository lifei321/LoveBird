//
//  FindBodyResultController.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController.h"
#import "FindSelectBirdModel.h"

@interface FindBodyResultController : AppBaseTableViewController

@property (nonatomic, strong) FindSelectBirdDataModel *dataModel;

@property (nonatomic, copy) NSString *word;

@end
