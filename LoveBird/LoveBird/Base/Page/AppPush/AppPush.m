//
//  AppPush.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/17.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppPush.h"
#import <GTSDK/GeTuiSdk.h>
#import "NotificationModel.h"
#import "JSONKit.h"
#import "AppAlertView.h"

// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppPush ()<GeTuiSdkDelegate>

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
- (void)setPush {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

    // 通过个推平台分配的appId、 appKey 、appSecret 启动SDK，注：该方法需要在主线程中调用
    [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppKey appSecret:kGtAppSecret delegate:(id<GeTuiSdkDelegate>)self];
    
    // 注册 APNS
    [[AppPush sharedAppPush] registerPush];
}



#pragma mark--  远程通知注册
- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // 真机上才处理Token，模拟器上生成的Token在后台会报错
#if !(TARGET_IPHONE_SIMULATOR)
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (token.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:token forKey:kDeviceToken];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 向个推服务器注册deviceToken
        [GeTuiSdk registerDeviceToken:token];
        
        //上传
        [self appRegisteredWithPushToken];
    }
#endif
}

#pragma mark--   恢复SDK运行  支持APP 后台刷新数据，
- (void)resume {
    [GeTuiSdk resume];
}


#pragma mark- 接收到推送消息
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // 将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    
    [self processRemoteNotification:userInfo];
}

#pragma mark--- GTSDK代理

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    
    //个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>>[GexinSdk error]:%@\n\n", [error localizedDescription]);
}

/** SDK收到透传消息回调 */  // App 在前台运行时 收到推送消息
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    
    if (!offLine) { //如果是离线消息，不处理
        NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:payloadData options:NSJSONReadingMutableContainers error:nil];
        if (payload) {
            NSDictionary *userInfo = @{@"payload" : payload};
            
            //拼接好userInfo
            [self processRemoteNotification:userInfo];
            
            //统计推送到达量
            NotificationModel *model = [[NotificationModel alloc] initWithDictionary:payload error:nil];
            NSDictionary *extraDict;
            if (model && [model.extradata isKindOfClass:[NSString class]]) {//为空不执行
                extraDict = [model.extradata objectFromJSONString];;
            }
        }
    }
}



#pragma mark-- 对通知消息的处理

/**
 *   处理userInfo
 */
- (NSDictionary *)handleUserInfo:(NSDictionary *)userInfo {
    
    NSMutableDictionary *resultInfo = [NSMutableDictionary dictionary];
    if (userInfo[@"payload"]) {
        NSDictionary *payloadDic = userInfo[@"payload"];
        
        if ([payloadDic isKindOfClass:[NSString class]]) {
            NSData *data = [userInfo[@"payload"] dataUsingEncoding:NSUTF8StringEncoding];
            payloadDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            if (payloadDic != nil) {
                resultInfo[@"payload"] = payloadDic;
            }
        }
    }
    return [resultInfo copy];
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
    
    if (![model.extradata isKindOfClass:[NSString class]]) {
        return;
    }
    
    NSDictionary *extraDict = [model.extradata objectFromJSONString];
    BOOL atLaunch = ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) ? NO : YES;
    if (atLaunch) { //后台切前台直接route
        
        [self routeViewControllerWithAction:model.action extraData:extraDict];
    } else { //当前app是打开的，弹窗
        
        AppAlertView *alertView = [[AppAlertView alloc] initWithTitle:model.title message:model.message cancelButtonTitle:@"关闭" otherButtonTitles:@"查看", nil];
        
        alertView.onDismissBlock = ^(NSInteger index) {
            if (index == alertView.firstOtherButtonIndex) {
                [self routeViewControllerWithAction:model.action extraData:extraDict];
            }
        };
        [alertView show];
    }
}

/**
 *  不同的action跳转到不同的VC
 *
 *  @param action    跳转的参数：1，2，3，4
 *  @param extradata 额外参数
 */
- (void)routeViewControllerWithAction:(NSString *)action extraData:(NSDictionary *)extradata {
    
}


#pragma mark- 向服务器上传token
- (void)appRegisteredWithPushToken {
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
    
    //上传token
    
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

@end
