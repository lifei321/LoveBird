//
//  LogDeatilTalkCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogDetailTalkModel.h"


@interface LogDeatilTalkCell : UITableViewCell

@property (nonatomic, strong)  void(^huifuBlock)(LogDetailTalkModel *bodyModel);


@property (nonatomic, strong) LogDetailTalkModel *bodyModel;


+ (CGFloat)getHeightWithModel:(LogDetailTalkModel *)model ;

@end
