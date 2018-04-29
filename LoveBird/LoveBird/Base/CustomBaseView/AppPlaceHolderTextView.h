//
//  AppPlaceHolderTextView.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  自定义的有placeHolder的TextView
 */
@interface AppPlaceHolderTextView : UITextView


/**
 * 背景图片
 */
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 * 默认文本
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 * 默认文本颜色。default 是 grayColor
 */
@property (nonatomic, strong) UIColor *placeholderColor;



/**
 *  字数
 */
@property (nonatomic, strong) UILabel *wordCoutLabel;

/**
 *  超过字数提醒
 */
@property (nonatomic, strong) UILabel *wordMoreLabel;

//字数限制
@property (nonatomic, assign) NSInteger limitCount;



@end
