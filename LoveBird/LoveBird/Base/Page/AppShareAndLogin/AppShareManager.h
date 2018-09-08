//
//  AppShareManager.h
//  LoveBird
//
//  Created by cheli shan on 2018/8/26.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, AppShareType) {
    AppShareTypeWechat = 0,
    AppShareTypeWeibo = 1,
    AppShareTypeQQ = 2,
};

@interface AppShareManager : NSObject

+ (void)registerManager;

// 仅支持iOS9以上系统，iOS8及以下系统不会回调
+ (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;

// 支持目前所有iOS系统
+ (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;


+ (void)shareWithTitle:(NSString *)title summary:(NSString *)summary url:(NSString *)url image:(NSString *)imageUrl;

+ (void)shareWithTitle:(NSString *)title
               summary:(NSString *)summary
                   url:(NSString *)url
                 image:(NSString *)imageUrl
             shareType:(AppShareType)type;

@end
