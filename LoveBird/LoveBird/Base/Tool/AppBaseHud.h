//
//  AppBaseHud.h
//  LoveBird
//
//  Created by ShanCheli on 2017/6/21.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD+BWMExtension.h"

typedef void(^AppHudBlock)(void);


@interface AppBaseHud : NSObject

+ (void)showHud:(NSString *)title view:(UIView *)view;

/**
 *  显示提示框
 *
 */
+ (void)showHud:(NSString *)title tipsType:(BWMMBProgressHUDMsgType)tipsType view:(UIView *)view;


/**
 *  显示等待指示器
 */
+ (void)showHudWithLoding:(UIView *)view title:(NSString *)title;

/**
 *  显示等待指示器 -> 正在加载
 */
+ (void)showHudWithLoding:(UIView *)view;

/**
 *   操作成功
 *
 */
+ (void)showHudWithSuccessful:(NSString *)title view:(UIView *)view;

/**
 *   操作成功
 *
 */
+ (void)showHudWithSuccessful:(NSString *)title view:(UIView *)view block:(AppHudBlock)block;

/**
 *   操作失败
 *
 */
+ (void)showHudWithfail:(NSString *)title view:(UIView *)view;

/**
 *   操作失败
 *
 */
+ (void)showHudWithfail:(NSString *)title view:(UIView *)view block:(AppHudBlock)block;

/**
 *   显示进度条
 *
 *  @param title 标题
 *  @param detail 描述文字（标题下面）
 */
+ (MBProgressHUD *)showHubWithProgressTitle:(NSString *)title detail:(NSString *)detail view:(UIView *)view;

/**
 *  隐藏指示器
 */
+ (void)hideHud:(UIView *)view;





@end
