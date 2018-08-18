//
//  LogDetailBirdCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/29.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogDetailModel.h"

@interface LogDetailBirdCell : UITableViewCell

@property (nonatomic, strong) NSArray *birdArray;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *time;

// 环境
@property (nonatomic, copy) NSString *evHuanjing;


@end
