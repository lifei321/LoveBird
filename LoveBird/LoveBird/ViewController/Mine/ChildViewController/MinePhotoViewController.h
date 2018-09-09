//
//  MinePhotoViewController.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/23.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController.h"

@interface MinePhotoViewController : AppBaseTableViewController

@property (nonatomic, copy) NSString *taid;

@property (nonatomic, copy) NSString *authorId;

@property (nonatomic, assign) BOOL fromMe;

@end
