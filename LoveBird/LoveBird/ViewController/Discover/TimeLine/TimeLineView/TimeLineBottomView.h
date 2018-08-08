//
//  TimeLineBottomView.h
//  LoveBird
//
//  Created by cheli shan on 2018/3/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverContentModel.h"
#import "ZhuangbeiModel.h"

@protocol TimeLineToolClickDelegate <NSObject>

- (void)timeLineToolClickDelegate:(UIButton *)button;

@end

@interface TimeLineBottomView : UIView

@property (nonatomic, strong) DiscoverContentModel *contentModel;

//  装备 咨询
@property (nonatomic, strong) ZhuangbeiModel *zhuangbeiModel;


@property (nonatomic, weak) id<TimeLineToolClickDelegate>timeLineToolDelegate;

@end
