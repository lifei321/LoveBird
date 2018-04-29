//
//  AppButton.m
//  LoveBird
//
//  Created by ShanCheli on 2017/6/21.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppButton.h"


@implementation AppButton



- (instancetype)initWithFrame:(CGRect)frame {
    self = [self initWithFrame:frame style:AppButtonStyleBlue];
    
    if (self) {
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(AppButtonStyle)style {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = KColorButtonBackground;
        self.titleLabel.font = kFont(15.);
        [self setTitleColor:kColorButtonTextColor forState:UIControlStateNormal];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3.0;
        
        [self resetButtonStyle:style];
    }
    
    return self;
}

- (void)resetApperentStyle:(AppButtonStyle)style {
    [self resetButtonStyle:style];
}

- (void)resetButtonStyle:(AppButtonStyle)style {
    switch (style) {
            
        case AppButtonStyleDefault:
        {
            [self setBackgroundImage:nil forState:UIControlStateNormal];
            [self setBackgroundImage:nil forState:UIControlStateHighlighted];
            self.backgroundColor = kColorDefaultColor;
        }
            break;

        case AppButtonStyleYellow:
        {
            [self setBackgroundImage:[UIImage imageNamed:@"buttonYellow"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"buttonyellow_high"] forState:UIControlStateHighlighted];
        }
            break;
            
        case AppButtonStyleGray:
        {
            [self setBackgroundImage:[UIImage imageNamed:@"buttongray"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"buttongray_high"] forState:UIControlStateHighlighted];
            [self setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        }
            break;
            
        case AppButtonStyleOrangeBound:
        {
            self.backgroundColor = [UIColor clearColor];
            [self setBackgroundImage:[UIImage imageNamed:@"button_orange_bound"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"button_orange_bound"] forState:UIControlStateHighlighted];
            [self setTitleColor:kColorTextColorOrangeED7338 forState:UIControlStateNormal];
            [self setTitleColor:kColorTextColorOrangeED7338 forState:UIControlStateHighlighted];
        }
            break;
            
        case AppButtonStyleGrayBound:
        {
            self.backgroundColor = [UIColor clearColor];
            [self setBackgroundImage:[UIImage imageNamed:@"button_gray_bound"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"button_gray_bound_hightlight"] forState:UIControlStateHighlighted];
            [self setTitleColor:kColorTextColor7D7D7D forState:UIControlStateNormal];
            [self setTitleColor:kColorTextColor7D7D7D forState:UIControlStateHighlighted];
        }
            break;
            
        case AppButtonStyleBlue:
        {
            [self setBackgroundImage:[UIImage imageNamed:@"buttonBlue"] forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:@"buttonblue_high"] forState:UIControlStateHighlighted];
            [self setTitleColor:kColorButtonTextColor forState:UIControlStateNormal];
        }
            break;
        case AppButtonStyleNone:
        {
            [self setBackgroundImage:nil forState:UIControlStateNormal];
            [self setBackgroundImage:nil forState:UIControlStateHighlighted];
            [self setTitleColor:kColorButtonTextColor forState:UIControlStateNormal];
        }
            break;
            
        default:
        {
            self.backgroundColor = KColorButtonBackground;
            [self setTitleColor:kColorButtonTextColor forState:UIControlStateNormal];
        }
            break;
    }
}


@end
