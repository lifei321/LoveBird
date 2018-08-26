//
//  AppShareManager.m
//  LoveBird
//
//  Created by cheli shan on 2018/8/26.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppShareManager.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>


@implementation AppShareManager

+ (void)registerManager {
    // U-Share 平台设置
    
    [UMConfigure initWithAppkey:@"5b613040f43e484357000078" channel:@"App Store"];
    [self configUSharePlatforms];
    [self confitUShareSettings];
}



+ (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    return result;
}

+ (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    return result;
}



+ (void)confitUShareSettings {
    
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

+ (void)configUSharePlatforms {
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx988504985563166d" appSecret:@"2b5729d594dd118410d1ee4c0adbec37" redirectURL:@"http://www.birdfans.com"];
    
    /*
     * 移除相应平台的分享，如微信收藏
     */
//    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://www.birdfans.com"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"477812063"  appSecret:@"ec319751c64ba3e286c23e4d935a8160" redirectURL:@"http://sns.whalecloud.com"];
}

@end
