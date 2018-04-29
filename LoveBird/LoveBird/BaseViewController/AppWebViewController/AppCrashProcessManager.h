//
//  ProcessCrashManager.h
//  cardloan
//
//  Created by lzh on 2017/1/5.
//  Copyright © 2017年 renxin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 集中处理crash问题的类
 */
@interface AppCrashProcessManager : NSObject

/**
 处理crash，最好在程序启动的时候调用
 */
+ (void)progressCrash;

/**
 处理WKContentView的crash
 [WKContentView isSecureTextEntry]: unrecognized selector sent to instance 0x101bd5000
 */
+ (void)progressWKContentViewCrash;

@end
