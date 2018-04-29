//
//  AppRoutine.h
//  LoveBird
//
//  Created by ShanCheli on 2017/6/22.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppRoutine : NSObject

+ (AppRoutine *)sharedRoutine;

- (void)applaunched;

//设置导航栏和状态栏风格
- (void)setNavBarStyle;

@end
