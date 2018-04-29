//
//  AppPush.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/17.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppPush : NSObject


+ (AppPush *)sharedAppPush;


//设置推送基本信息
- (void)setPush ;

//注册成功 保存devicetoken
- (void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken ;

//恢复SDK运行
- (void)resume;

// 收到推送消息
- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

@end

