//
//  AppDelegate.m
//  LoveBird
//
//  Created by ShanCheli on 2017/6/21.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppDelegate.h"
#import "AppGuideManager.h"
#import "AppRoutine.h"

#import "AppTabBarController.h"

#import "AppPush.h"


// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:kFirstLouchString];
    
    //配置启动项
    [[AppRoutine sharedRoutine] applaunched];
    
    //推送设置
    [[AppPush sharedAppPush] setPush];
    
    //引导页
    [[AppGuideManager shareManager] showGuideView];
    
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark--- 设置根控制器
- (void)setRootViewControllerForWindow {
    
    self.window.rootViewController = [[AppTabBarController alloc] init];
}



#pragma mark--- 注册推送

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken  {
    
    //保存devicetoken
    [[AppPush sharedAppPush] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

/** 用户通知(推送)回调 _IOS 8.0以上使用 */
/** 已登记用户通知 */
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // 注册远程通知（推送）
    [application registerForRemoteNotifications];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    NSLog(@"\n>>>[DeviceToken Error]:%@\n\n", error.description);
}


#pragma mark--   支持 APP 后台刷新数据，
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    /// Background Fetch 恢复SDK 运行
    [[AppPush sharedAppPush] resume];

    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


#pragma mark-- 接受到推送消息
//  在iOS 10 以前，处理 APNs 通知点击事件
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // 将收到的APNs信息传给个推统计
    [[AppPush sharedAppPush] didReceiveRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [[AppPush sharedAppPush] didReceiveRemoteNotification:userInfo];
}

#pragma mark-- iOS10 收到推送消息 点击统计

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//  iOS 10: 点击通知进入App时触发，在该方法内统计有效用户点击数
//  对于iOS 10 及以后版本，处理 APNs 通知点击
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    // 将收到的APNs信息传给个推统计
    [[AppPush sharedAppPush] didReceiveRemoteNotification:response.notification.request.content.userInfo];

    completionHandler();
}

#endif



@end
