//
//  AppShareSDK.h
//  LoveBird
//
//  Created by ShanCheli on 2018/1/24.
//  Copyright © 2018年 shancheli. All rights reserved.
//

/**
 *  平台类型
 */
typedef NS_ENUM(NSUInteger, AppSharePlatformType){
    AppSharePlatformTypeWXSession = 1,
    AppSharePlatformTypeWXTimeLine = 2,

    AppSharePlatformTypeQQFriend = 3,
    AppSharePlatformTypeQQZone = 4,

    AppSharePlatformTypeWB = 5,
    AppSharePlatformTypeWX = 6,
    AppSharePlatformTypeQQ = 7,

};

typedef void(^AppLoginSuccessBlock)(NSString *uid, NSString *nickName, NSString *icon);
typedef void(^AppLoginFailureBlock)();
#import <Foundation/Foundation.h>

@interface AppShareSDK : NSObject

//注册shareSDK
+ (void)registShareSDK;

//分享到某个平台
+ (void)shareWithPlatformType:(AppSharePlatformType)platformType
                 successBlock:(AppLoginSuccessBlock)successBlock
                 failureBlock:(AppLoginFailureBlock)failureBlock;

@end
