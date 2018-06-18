//
//  FindResultCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindSelectBirdModel.h"
#import "MapDiscoverModel.h"

@interface FindResultCell : UITableViewCell

@property (nonatomic, strong) FindSelectBirdModel *birdModel;

@property (nonatomic, strong) MapDiscoverInfoModel *infoModel;

@end
