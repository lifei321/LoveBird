//
//  WorkTableViewCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorksModel.h"

typedef void(^WorkSelectBlock)(WorksModel *selectModel);

@interface WorkTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *listArray;

@property (nonatomic, strong) WorkSelectBlock selectBlock;


@end
