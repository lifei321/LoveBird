//
//  AppPush.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/17.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppPush.h"
#import <UMPush/UMessage.h>
#import "NotificationModel.h"
#import "JSONKit.h"
#import "AppAlertView.h"

// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif


#import "LogDetailController.h"
#import "MatchDetailController.h"
#import "SetDao.h"
#import "UserInfoViewController.h"

@interface AppPush ()

@end

@implementation AppPush

+ (AppPush *)sharedAppPush {
    static AppPush *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}



#pragma mark-- 注册
- (void)setPushWithLaunchOptions:(NSDictionary * __nullable)launchOptions {
    
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        } else {
            
        }
    }];
    
    // 注册 APNS
    [[AppPush sharedAppPush] registerPush];
}



#pragma mark--  远程通知注册
- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                             stringByReplacingOccurrencesOfString: @">" withString: @""]
                                             stringByReplacingOccurrencesOfString: @" " withString: @""]);
    
    // 真机上才处理Token，模拟器上生成的Token在后台会报错
#if !(TARGET_IPHONE_SIMULATOR)
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (token.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:kDeviceToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 向个推服务器注册deviceToken
        [UMessage registerDeviceToken:deviceToken];
        
        //上传
        [self appRegisteredWithPushToken];
    }
    

#endif
}


#pragma mark- 接收到推送消息
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    
    [self processRemoteNotification:userInfo];
}


#pragma mark-- 对通知消息的处理

/**
 *   处理userInfo
 */
- (NSDictionary *)handleUserInfo:(NSDictionary *)userInfo {
    
    NSMutableDictionary *resultInfo;
    if ([userInfo objectForKey:@"aps"]) {
        NSDictionary *apsInfo = userInfo[@"aps"];
        if ([apsInfo isKindOfClass:[NSDictionary class]] && [apsInfo objectForKey:@"appGo"]) {
            NSString *payloadDic = [apsInfo objectForKey:@"appGo"];
            NSData *jsonData = [payloadDic dataUsingEncoding:NSUTF8StringEncoding];
            NSError *err;
            resultInfo = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
            if (resultInfo && !err) {
                return resultInfo;
            }
        }
    }
    return [NSMutableDictionary dictionary];
}

/**
 *  处理推送通知
 */
- (void)processRemoteNotification:(NSDictionary *)dict {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    id alertObject = [self handleUserInfo:dict];
    NotificationModel *model = [[NotificationModel alloc] initWithDictionary:alertObject error:nil];
    
    if (!model) {//为空不执行
        return;
    }
    
    
    BOOL atLaunch = ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) ? NO : YES;
    if (atLaunch) { //后台切前台直接route
        
        [self routeViewControllerWithNotifyModel:model];
    }
}

#pragma mark- 向服务器上传token
- (void)appRegisteredWithPushToken {
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    
    //上传token
    NSLog(@"token----  %@", token);
    
    if ([UserPage sharedInstance].isLogin) {
        [SetDao setDeviceToken:token SuccessBlock:nil failureBlock:nil];
    }
    
}


#pragma mark-  注册 APNs

- (void)registerPush {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = (id<UNUserNotificationCenterDelegate>)self;
        
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
#else // Xcode 7编译会调用
        
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
        
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    }
    //    else {
    //
    //        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
    //                                                                       UIRemoteNotificationTypeSound |
    //                                                                       UIRemoteNotificationTypeBadge);
    //        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    //    }
}





/**
 *  不同的action跳转到不同的VC
 */
- (void)routeViewControllerWithNotifyModel:(NotificationModel *)model {

    if (model.view_status.integerValue == 100) {
        // 日志详情
        LogDetailController *logDetailVC = [[LogDetailController alloc] init];
        logDetailVC.tid = model.pushId;
        [[UIViewController currentViewController].navigationController pushViewController:logDetailVC animated:YES];
        
    } else if (model.view_status.integerValue == 200) {
        // 文章详情
        LogDetailController *logDetailVC = [[LogDetailController alloc] init];
        logDetailVC.aid = model.pushId;
        [[UIViewController currentViewController].navigationController pushViewController:logDetailVC animated:YES];
        
    } else if (model.view_status.integerValue == 300) {
        // 大赛详情
        MatchDetailController *logDetailVC = [[MatchDetailController alloc] init];
        logDetailVC.matchid = model.pushId;
        [[UIViewController currentViewController].navigationController pushViewController:logDetailVC animated:YES];
        
    } else if (model.view_status.integerValue == 400) {
        // webview
        AppWebViewController *webvc = [[AppWebViewController alloc] init];
        webvc.startupUrlString = model.pushId;
        [[UIViewController currentViewController].navigationController pushViewController:webvc animated:YES];
    } else if (model.view_status.integerValue == 500) {
        UserInfoViewController *uservc = [[UserInfoViewController alloc] init];
        uservc.uid = model.pushId;
        [[UIViewController currentViewController].navigationController pushViewController:uservc animated:YES];

    }
    
}


@end
