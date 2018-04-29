//
//  UIView+Frame.h
//  LoveBird
//
//  Created by ShanCheli on 2017/6/21.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)



@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (void)setAlignmentCenterWithSuperview:(UIView *)superview;

@end
