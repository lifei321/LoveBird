//
//  RankTableViewCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankModel.h"

@interface RankTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *cellType;

@property (nonatomic, strong) RankModel *rankModel;

@end
