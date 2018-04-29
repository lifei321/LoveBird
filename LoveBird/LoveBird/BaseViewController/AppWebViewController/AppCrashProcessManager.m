//
//  ProcessCrashManager.m
//  cardloan
//
//  Created by lzh on 2017/1/5.
//  Copyright © 2017年 renxin. All rights reserved.
//

#import "AppCrashProcessManager.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation AppCrashProcessManager

/**
 处理crash，最好在程序启动的时候调用
 */
+ (void)progressCrash {
    [self progressWKContentViewCrash];
}

/**
 处理WKContentView的crash
 [WKContentView isSecureTextEntry]: unrecognized selector sent to instance 0x101bd5000
 */
+ (void)progressWKContentViewCrash {
    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)) {
        const char *className = @"WKContentView".UTF8String;
        Class WKContentViewClass = objc_getClass(className);
        SEL isSecureTextEntry = NSSelectorFromString(@"isSecureTextEntry");
        SEL secureTextEntry = NSSelectorFromString(@"secureTextEntry");
        BOOL addIsSecureTextEntry = class_addMethod(WKContentViewClass, isSecureTextEntry, (IMP)isSecureTextEntryIMP, "B@:");
        BOOL addSecureTextEntry = class_addMethod(WKContentViewClass, secureTextEntry, (IMP)secureTextEntryIMP, "B@:");
        if (!addIsSecureTextEntry || !addSecureTextEntry) {
            NSLog(@"WKContentView-Crash->修复失败");
        }
    }
}

/**
 实现WKContentView对象isSecureTextEntry方法
 @return NO
 */
BOOL isSecureTextEntryIMP(id sender, SEL cmd) {
    return NO;
}

/**
 实现WKContentView对象secureTextEntry方法
 @return NO
 */
BOOL secureTextEntryIMP(id sender, SEL cmd) {
    return NO;
}

@end
