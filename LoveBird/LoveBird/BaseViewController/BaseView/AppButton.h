//
//  AppButton.h
//  LoveBird
//
//  Created by ShanCheli on 2017/6/21.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  按钮类型
 */
typedef NS_ENUM(NSInteger, AppButtonStyle) {
    
    /**
     *  默认色
     */
    AppButtonStyleDefault,
    
    /**
     *  黄色
     */
    AppButtonStyleYellow,
    
    /**
     *  蓝色
     */
    AppButtonStyleBlue,
    /**
     *  灰色
     */
    AppButtonStyleGray,
    /**
     *  橙色带边框
     */
    AppButtonStyleOrangeBound,
    /**
     *  带灰色边框
     */
    AppButtonStyleGrayBound,
    /**
     *  none
     */
    AppButtonStyleNone
};


@interface AppButton : UIButton

- (void)resetApperentStyle:(AppButtonStyle)style;

- (instancetype)initWithFrame:(CGRect)frame style:(AppButtonStyle)style;


@end
