//
//  AppBaseTextField.h
//  LoveBird
//
//  Created by ShanCheli on 2017/11/17.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppBaseTextField : UITextField<UITextFieldDelegate>


/**
 *  是否透明
 */
@property (nonatomic, assign) BOOL isTransparent;

/**
 *  设置右侧 icon
 *
 *  @param image icon的图片
 *  @param addTarget 调用action方法的对象
 *  @param action 点击icon所调用的方法
 */
- (void)setRightImage:(UIImage *)image addTarget:(id)addTarget action:(SEL)action;

/**
 *  限制长度
 */
@property (nonatomic, assign) int limitLenght;

/**
 *  是否显示清理按钮, 默认 yes
 */
@property (nonatomic, assign) BOOL isDisplayCleanButton;

/**
 *  清空 button
 */
@property (nonatomic, strong) UIButton *clearButton;

@end
