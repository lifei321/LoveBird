//
//  TimeLineCell.h
//  LFBaseProject
//
//  Created by ShanCheli on 2018/1/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineLayoutModel.h"

@class TimeLineCell;
@protocol TimeLineClickDelegate <NSObject>

- (void)timeLine:(TimeLineCell *)timeLineCell didClickDelegate:(UIButton *)button;

@end

@interface TimeLineCell : UITableViewCell

@property (nonatomic, strong) TimeLineLayoutModel *cellLayoutModel;

@property (nonatomic, weak) id<TimeLineClickDelegate>timeLineCellDelegate;

@end
