//
//  MineBirdLeftBackView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/26.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineBirdLeftBackView.h"

@implementation MineBirdLeftBackView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kColorViewBackground;

    }
    return self;
}


- (void)setIsLeft:(BOOL)isLeft {
    _isLeft = isLeft;
    
    if (isLeft) {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(AutoSize6(84), AutoSize6(84))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;

    } else {
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(AutoSize6(84), AutoSize6(84))];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = self.height - AutoSize6(40);

    CGFloat left = self.isLeft ?  (self.width - width / 2): (- width / 2);
    
    // 获取图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /**
     画实心圆
     */
    CGRect frame = CGRectMake(left, AutoSize6(20), width, width);

    [kColorViewBackground set];

    //填充当前矩形区域
    CGContextFillRect(ctx, rect);
    //以矩形frame为依据画一个圆
    CGContextAddEllipseInRect(ctx, frame);
    //填充当前绘画区域内的颜色
    [[UIColor whiteColor] set];
    //填充(沿着矩形内围填充出指定大小的圆)
    CGContextFillPath(ctx);
}


@end
