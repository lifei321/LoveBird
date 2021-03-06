//
//  AppRoutine.m
//  LoveBird
//
//  Created by ShanCheli on 2017/6/22.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppRoutine.h"
#import <UIKit/UIKit.h>
#import "IQKeyboardManager.h"
#import "BJXYHTTPManager.h"
#import "AppCrashProcessManager.h"
#import <AddressBookUI/AddressBookUI.h>
#import "AddressBookPage.h"
//#import "AppShareSDK.h"
#import "AppShareManager.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface AppRoutine()<BMKGeneralDelegate>


@end

@implementation AppRoutine


+ (AppRoutine *)sharedRoutine {
    static AppRoutine *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (void)applaunched {
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
//    // tabbar push返回的时候 位置有偏移
//    NSString *version = [UIDevice currentDevice].systemVersion;
//    if (version.doubleValue >= 12.1) {
//        [UITabBar appearance].translucent = NO;
//    }

    //配置网络请求
    [self configNetwork];
    
    //监听网络状态变化
    [self setNetWorkReachability];
    
    //获取广告业数据
    [self getAdvWindowData];
    
    //设置导航栏
    [self setNavBarStyle];
    
    //键盘
    [self setKeyBoard];
    
    //第三方登录和分享
    [AppShareManager registerManager];
    
    //获取通讯录
    [AddressBookPage starUpload];

    //处理 WKWebview crash
    [AppCrashProcessManager progressCrash];
    
    // 初始化百度地图
    [self initBaiduMap];
    
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}

- (void)setNavBarStyle {
    
    // 设置导航栏默认的背景颜色
//    [WRNavigationBar wr_setDefaultNavBarBarTintColor:[UIColor blueColor]];
    
    // 设置导航栏默认的背景颜色 这种设置方式push的时候有问题
//    [UIColor wr_setDefaultNavBarBackgroundImage:[UIImage imageNamed:@"nav_blue"]];

    // 设置导航栏所有按钮的默认颜色
//    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor whiteColor]];

    // 设置导航栏标题默认颜色
//    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor whiteColor]];

    // 统一设置状态栏样式
//    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
//    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}


#pragma mark- 监测网络状态
- (void)setNetWorkReachability {
    
    [AFNetworkReachabilityManager managerForDomain:kNetworkAddress];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if ((status == AFNetworkReachabilityStatusNotReachable) || (status == AFNetworkReachabilityStatusUnknown)) {
            //网络不可用
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetWorkUnavailableNotification object:nil];
        } else {
            //网络可用
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetWorkAvailableNotification object:nil];
        }
    }];
}


#pragma mark-  键盘事件
- (void)setKeyBoard {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;
    manager.toolbarDoneBarButtonItemText = @"确定";
    manager.shouldShowToolbarPlaceholder = YES;
}

/**
 配置网络库
 */
- (void)configNetwork {
    
    BJXYHTTPManager *httpManager = [BJXYHTTPManager sharedClient];
    httpManager.apiUserServer = kAPI_USER_SERVER;
//    httpManager.apiVersion = kAPI_API_VERSION;
    
//    [httpManager.generalParaDict setObject:kchannelId forKey:@"channel"];
//    [httpManager.generalParaDict setObject:kPuhui_APP_UA forKey:@"ua"];
    
//    httpManager.serverEncryptSignKey = kServerEncryptSignKey;
//    httpManager.appUserAgent = kAppUserAgent;
    
    httpManager.networkErrorHandle = ^(NSDictionary *errorDict) {
        NSLog(@"%@", errorDict);
    };
    
    NSMutableDictionary<NSNumber *, BJXYResponseErrorHandler> *responseErrorHandlDict = httpManager.responseErrorHandlDict;
    [responseErrorHandlDict setObject:^(AppBaseModel *error, BJXYRequestModelFail failblock, BJXYRestartRequest restart){
        
        NSLog(@"%@", error);
        
    } forKey:@(BJXYRetCodeAuthInvalid)];
}


#pragma mark-  获取广告页数据
- (void)getAdvWindowData {
    
}

#pragma mark-- 初始化百度地图
- (void)initBaiduMap {
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [mapManager start:@"DK1mRYFYj6SGlw4GGThp6KVGOxLQXYfM" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
}

@end
