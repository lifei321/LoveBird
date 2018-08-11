//
//  UIFactory.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/12.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory


+ (UILabel *)labelWithFont:(CGFloat)fontSize textColor:(UIColor *)color {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 20)];
    
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Helvetica-Light" size:fontSize];
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.6f;
    
    if (color) {
        label.textColor = color;
    }
    
    return label;
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                       target:(id)target
                     selector:(SEL)selector {
    return
    [self buttonWithTitle:title fontSize:18 target:target selector:selector];
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                     fontSize:(CGFloat)fontSize
                       target:(id)target
                     selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.exclusiveTouch = YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    button.titleLabel.font = font;
    CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName : font}];
    button.frame = CGRectMake(0, 0, textSize.width, fontSize + 5);
    [button addTarget:target
               action:selector
     forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithImage:(UIImage *)image
                       target:(id)target
                     selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.exclusiveTouch = YES;
    [button setImage:image forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    
    if (selector) {
        [button addTarget:target
                   action:selector
         forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}


//返回label 宽度
+ (CGSize)sizeWithLabel:(UILabel *)label width:(CGFloat)width {
    
    label.adjustsFontSizeToFitWidth  = NO;
    CGSize maximumLabelSize = [label.text boundingRectWithSize:CGSizeMake(width, label.height)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:label.font}
                                                       context:nil].size;
    
    return maximumLabelSize;
}


+ (UIButton *)buttonWithFrame:(CGRect)frame
                       target:(id)target
                        image:(NSString *)image
                  selectImage:(NSString *)selectImage
                        title:(NSString *)title
                       action:(SEL)action {
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x7f7f7f) forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x7f7f7f) forState:UIControlStateSelected];
    button.titleLabel.font = kFont6(25);
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, -AutoSize(5), 0.0, 0.0)];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


@end
