//
//  AppMacro.h
//  LoveBird
//
//  Created by ShanCheli on 2017/6/21.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseMacro.h"
#import "AppStyleMacro.h"
#import "AppApi.h"
#import "AppNotificationMacro.h"


// 当前taberController
#define kTabBarController                   [[UIApplication sharedApplication].delegate window].rootViewController

// 当前NavigationController
#define KNavigationController               ((UINavigationController *)((UITabBarController *)kTabBarController).selectedViewController)

// 当前ViewController
#define kViewController                     ((UIViewController *)[KNavigationController.viewControllers lastObject])


//NSString  nil --> @""
#define EMPTY_STRING_IF_NIL(a)              (((a)==nil)?@"":(a))


// 指示器等待时间
#define kAfterSecond                        1.5


// AppStore appID
#define kAppID                              @"1069785400"

#define APPSTORE_URL                        @"itms-apps://itunes.apple.com/app/id"


//监听网络的 网址
#define kNetworkAddress                     @"www.baidu.com"

//基础网址
#define kAPI_USER_SERVER                    @"http://bbs.photofans.cn/source/birdapi"



#define kGtAppId                            @""    //个推id
#define kGtAppKey                           @""    //个推key
#define kGtAppSecret                        @""    //个推秘钥
