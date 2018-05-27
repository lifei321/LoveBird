//
//  TimeLineTittleView.h
//  LFBaseProject
//
//  Created by ShanCheli on 2018/1/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverContentModel.h"


@protocol FollowButtonDidClickDelegate <NSObject>

- (void)followButtonClickDelegate:(UIButton *)button;

@end

@interface TimeLineTittleView : UIView

@property (nonatomic, strong) DiscoverContentModel *contentModel;

@property (nonatomic, weak) id<FollowButtonDidClickDelegate>followDelegate;

@end
