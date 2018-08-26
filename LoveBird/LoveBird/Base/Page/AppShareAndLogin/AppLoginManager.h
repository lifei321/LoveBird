//
//  AppLoginManager.h
//  LoveBird
//
//  Created by cheli shan on 2018/8/26.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>

typedef NS_ENUM(NSInteger, AppLoginType) {
    AppLoginTypeWeixin = 1,
    AppLoginTypeWeibo,
    AppLoginTypeQQ,
};

typedef void(^loginUserInfoBlock)(id result, NSError *error);

@interface AppLoginManager : NSObject

+ (void)loginWithPlatform:(AppLoginType)loginType infoBlock:(loginUserInfoBlock)infoBlock ;

@end
