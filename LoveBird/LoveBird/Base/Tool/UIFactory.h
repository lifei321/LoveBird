//
//  UIFactory.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/12.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFactory : NSObject


+ (UILabel *)labelWithFont:(CGFloat)fontSize textColor:(UIColor *)color;
+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;
+ (UIButton *)buttonWithImage:(UIImage *)image target:(id)target selector:(SEL)selector;


///返回lable宽度  width 最大宽度
+ (CGSize)sizeWithLabel:(UILabel *)label width:(CGFloat)width;

@end
