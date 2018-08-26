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
#import <UShareUI/UShareUI.h>


@implementation AppShareManager

+ (void)registerManager {
    // U-Share 平台设置
    
    [UMConfigure initWithAppkey:@"5b613040f43e484357000078" channel:@"App Store"];
    
    
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



+ (BOOL)openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    return result;
}

+ (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    return result;
}

+ (void)shareWithTitle:(NSString *)title summary:(NSString *)summary url:(NSString *)url image:(NSString *)imageUrl {
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_Sina)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建图片内容对象
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:summary thumImage:imageUrl];
        
        shareObject.webpageUrl = url;
                
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[UIViewController currentViewController] completion:^(id data, NSError *error) {
            if (error) {
                [[[AppShareManager alloc] init] alertWithError:error];
            }
        }];
    }];
}

 - (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share complete"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}


@end
