//
//  GuideCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/18.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuideModel.h"

@interface GuideCell : UITableViewCell

@property (nonatomic, strong) GuideModel *model;

+ (CGFloat)getHeight:(GuideModel *)model;

@end
