//
//  MineLocationViewController.h
//  LoveBird
//
//  Created by cheli shan on 2018/9/8.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController.h"

typedef void(^locationBlock)(NSString *sheng, NSString *shi);

@interface MineLocationViewController : AppBaseTableViewController

@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, copy) NSString * shengString;

@property (nonatomic, copy) NSString * shiString;

@property (nonatomic, copy) NSString * upid;


@property (nonatomic, copy) locationBlock block;


@end
