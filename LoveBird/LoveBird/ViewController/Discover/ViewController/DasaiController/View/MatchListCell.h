//
//  MatchListCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/20.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseTableViewCell.h"
#import "MatchModel.h"

@interface MatchListCell : AppBaseTableViewCell

@property (nonatomic, strong) void(^matchClickBlock)(MatchListCell *cell);

@property (nonatomic, strong) MatchModel *matchModel;

@end
