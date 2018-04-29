//
//  AppTextField.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppTextField : UITextField<UITextFieldDelegate>

/**
 *  是否透明
 */
@property (nonatomic, assign) BOOL isTransparent;

/**
 *  设置右侧 icon
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


@end
