//
//  LogContentCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/29.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogDetailModel.h"

typedef void(^WorkSelectBlock)(LogPostBodyModel *selectModel);

@interface LogContentCell : UITableViewCell

@property (nonatomic, strong) LogPostBodyModel *contentModel;

+ (CGFloat)getHeightWithContentModel:(LogPostBodyModel *)model ;

@property (nonatomic, strong) WorkSelectBlock selectBlock;


@end
