//
//  UIViewController+Utils.h
//  cardloan
//
//  Created by zhuayi on 16/6/1.
//  Copyright © 2016年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

///最上层的VC
- (UIViewController *)topViewController;
- (UIViewController *)topViewController:(UIViewController *)rootViewController;


/**
 *  当前控制器
 */
+ (UIViewController *)currentViewController;


@end
