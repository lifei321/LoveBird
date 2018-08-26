//
//  AppLoginManager.m
//  LoveBird
//
//  Created by cheli shan on 2018/8/26.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppLoginManager.h"

@implementation AppLoginManager


+ (void)loginWithPlatform:(AppLoginType)loginType infoBlock:(loginUserInfoBlock)infoBlock {
    UMSocialPlatformType  platformType = UMSocialPlatformType_UnKnown;
    
    if (loginType == AppLoginTypeWeixin) {
        platformType = UMSocialPlatformType_WechatSession;
    } else if (loginType == AppLoginTypeWeibo) {
        platformType = UMSocialPlatformType_Sina;
    } else if (loginType == AppLoginTypeQQ) {
        platformType = UMSocialPlatformType_QQ;
    }
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);

        
        if (infoBlock) {
            infoBlock(result, error);
        }
    }];
}



@end
