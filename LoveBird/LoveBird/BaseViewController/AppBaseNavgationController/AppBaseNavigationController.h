//
//  AppBaseNavigationController.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppBaseNavigationController : UINavigationController

@property (nonatomic, assign) BOOL transparent;

/**
 *  导航栏背景透明度值
 */
@property (nonatomic, assign) CGFloat transparentAlpha;

@property (nonatomic, strong) UIView *alphaView;

@end
