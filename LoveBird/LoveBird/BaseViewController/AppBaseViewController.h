//
//  AppBaseViewController.h
//  LoveBird
//
//  Created by ShanCheli on 2017/6/21.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBaseBarButtonItem.h"


/**
 *  控制器 block
 */
typedef void(^viewControllerActionBlock)(UIViewController *viewController, NSObject *userInfo);


@interface AppBaseViewController : UIViewController


/**
 *  左按钮
 */
@property (nonatomic, strong) ZBaseBarButtonItem *leftButton;

/**
 *  右按钮
 */
@property (nonatomic, strong) ZBaseBarButtonItem *rightButton;


/**
 *  点击背景去除焦点
 */
@property (nonatomic, assign) BOOL bEnableTapToResignFirstResponder;

/**
 *  http 请求
 */
@property (nonatomic, strong) NSMutableArray *operationArray;

/**
 *  判断是否presentingViewController 过来的
 *
 *  @return BOOL
 */
- (BOOL)isModal;

/**
 *  控制器回调
 */
@property (nonatomic, strong) viewControllerActionBlock viewControllerActionBlock;


/**
 *  是否不监听网络
 */
@property (nonatomic, assign) BOOL isNotMontorNetWork;


#pragma mark 自定义导航栏

/**
 *  返回图片
 */
@property (nonatomic, strong) UIImage *backImage;

/**
 *  自定义导航栏
 */
@property (nonatomic, strong) UINavigationBar *navigationBar;

@property (nonatomic, strong) UINavigationItem *navigationBarItem;

/**
 *  是否使用自定义导航栏
 */
@property (nonatomic, assign) BOOL isCustomNavigation;

/**
 *  是否透明
 */
@property (nonatomic, assign) BOOL isNavigationTransparent;


#pragma mark------------------- 方法动作

// 设置导航栏颜色
- (void)setNavigationBarColor:(UIColor *)color;

// 设置title颜色
- (void)setNavigationBarTitleColor:(UIColor *)color;

// 设置title字体大小
- (void)setNavigationBarFont:(UIFont *)font;

/**
 *  左侧按钮事件
 */
- (void)leftButtonAction;

/**
 *  右按钮事件
 */
- (void)rightButtonAction;

// 网络不可用时
- (void) netWorkUnavailable;

// 网络可用时
- (void) netWorkAvailable;



- (void)setViewControllerActionBlock:(viewControllerActionBlock)viewControllerActionBlock;


/**
 *  网络错误页面
 *
 */
- (void)showNetErrorView:(dispatch_block_t)retryBlock;

/**
 *  没有数据的空页面
 */
- (void)showNoDataView;

/**
 *  没有消息的空页面
 */
- (void)showNoMessage;

/**
 *  系统错误
 */
- (void)showServerError;

/**
 *  自定义空页面
 *
 */
- (void)createEmptyViewWith:(NSString*)text
                      image:(UIImage *)image
                     offset:(CGPoint)offset
                  retryText:(NSString *)retryTitle
                 retryBlock:(dispatch_block_t)retryBlock;

- (void)createEmptyViewWith:(NSString*)text
                  textColor:(UIColor *)textColor
                      image:(UIImage *)image
                     offset:(CGPoint)offset
                     space :(CGFloat)space
                  retryText:(NSString *)retryTitle
                 retryBlock:(dispatch_block_t)retryBlock;


/**
 *  移除空页面
 */

- (void)removeEmptyView;

/**
 *  隐藏键盘
 */
- (void)hideKeyboard;

// 是否是root控制器
- (BOOL)isRootViewController;
@end
