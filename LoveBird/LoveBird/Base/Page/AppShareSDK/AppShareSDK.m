////
////  AppShareSDK.m
////  LoveBird
////
////  Created by ShanCheli on 2018/1/24.
////  Copyright © 2018年 shancheli. All rights reserved.
////
//
//#import "AppShareSDK.h"
//
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
////腾讯开放平台（对应QQ和QQ空间）SDK头文件
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//
////微信SDK头文件
//#import "WXApi.h"
//
////新浪微博SDK头文件<
////新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加”-ObjC”
//#import "WeiboSDK.h"
//
//
//@implementation AppShareSDK
//
//
//#pragma mark- 第三方登录和分享
//
///**初始化ShareSDK应用
//
// @ activePlatforms
// 使用的分享平台集合
// @ importHandler (onImport)
// 导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
// @ configurationHandler (onConfiguration)
// 配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
// */
//+ (void)registShareSDK {
//
//    [ShareSDK registerActivePlatforms:@[
//                                        @(SSDKPlatformTypeSinaWeibo),
//                                        @(SSDKPlatformTypeWechat),
//                                        @(SSDKPlatformTypeQQ),
//                                        ]
//                             onImport:^(SSDKPlatformType platformType) {
//
//                                 switch (platformType) {
//                                     case SSDKPlatformTypeWechat:
//                                         [ShareSDKConnector connectWeChat:[WXApi class]];
//                                         break;
//                                     case SSDKPlatformTypeQQ:
//                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                                         break;
//                                     case SSDKPlatformTypeSinaWeibo:
//                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                                         break;
//                                     default:
//                                         break;
//                                 }
//                             }
//                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//
//                          switch (platformType) {
//
//                              case SSDKPlatformTypeSinaWeibo:
//                                  //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                                  [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                                                            appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                                                          redirectUri:@"http://www.sharesdk.cn"
//                                                             authType:SSDKAuthTypeBoth];
//                                  break;
//                              case SSDKPlatformTypeWechat:
//                                  [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
//                                                        appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
//                                  break;
//                              case SSDKPlatformTypeQQ:
//                                  [appInfo SSDKSetupQQByAppId:@"100371282"
//                                                       appKey:@"aed9b0303e3ed1e27bae87c33761161d"
//                                                     authType:SSDKAuthTypeBoth];
//                                  break;
//                              default: break;
//                          }
//                      }];
//}
//
//
//#pragma mark- 分享到某个平台
//
//+ (void)shareWithPlatformType:(AppSharePlatformType)platformType {
//
//    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
//    NSArray* imageArray = @[[UIImage imageNamed:@"shareImg.png"]];
//
//    if (imageArray) {
//
//        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//        [shareParams SSDKSetupShareParamsByText:@"分享内容"
//                                         images:imageArray
//                                            url:[NSURL URLWithString:@"http://mob.com"]
//                                          title:@"分享标题"
//                                           type:SSDKContentTypeAuto];
//
//        //2、分享（可以弹出我们的分享菜单和编辑界面）
//        //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
//        [ShareSDK share:[self getType:platformType]
//             parameters:shareParams
//         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//
//           switch (state) {
//               case SSDKResponseStateSuccess: {
//                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                       message:nil
//                                                                      delegate:nil
//                                                             cancelButtonTitle:@"确定"
//                                                             otherButtonTitles:nil];
//                   [alertView show];
//                   break;
//               }
//               case SSDKResponseStateFail: {
//                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                   message:[NSString stringWithFormat:@"%@",error]
//                                                                  delegate:nil
//                                                         cancelButtonTitle:@"OK"
//                                                         otherButtonTitles:nil, nil];
//                   [alert show];
//                   break;
//               }
//               default: break;
//           }
//       }];
//    }
//}
//
////状态类型转换
//+ (SSDKPlatformType)getType:(AppSharePlatformType)platformType {
//
//    SSDKPlatformType shareType = SSDKPlatformTypeUnknown;
//    if (platformType == AppSharePlatformTypeWXSession) {
//        shareType = SSDKPlatformSubTypeWechatSession;
//
//    } else if (platformType == AppSharePlatformTypeWXTimeLine) {
//        shareType = SSDKPlatformSubTypeWechatTimeline;
//
//    } else if (platformType == AppSharePlatformTypeQQFriend) {
//        shareType = SSDKPlatformSubTypeQQFriend;
//
//    } else if (platformType == AppSharePlatformTypeQQZone) {
//        shareType = SSDKPlatformSubTypeQZone;
//
//    } else if (platformType == AppSharePlatformTypeWB) {
//        shareType = SSDKPlatformTypeSinaWeibo;
//
//    } else if (platformType == AppSharePlatformTypeWX) {
//        shareType = SSDKPlatformTypeWechat;
//
//    } else if (platformType == AppSharePlatformTypeQQ) {
//        shareType = SSDKPlatformTypeQQ;
//    }
//
//    return shareType;
//}
//
//#pragma mark- 第三方登录
//+ (void)shareWithPlatformType:(AppSharePlatformType)platformType
//                 successBlock:(AppLoginSuccessBlock)successBlock
//                 failureBlock:(AppLoginFailureBlock)failureBlock {
//
//    [ShareSDK getUserInfo:[self getType:platformType]
//           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
//
//         if (state == SSDKResponseStateSuccess) {
//
//             if (successBlock) {
//                 successBlock(user.uid, user.nickname, user.icon);
//             }
//         } else {
//             if (failureBlock) {
//                 failureBlock();
//             }
//         }
//     }];
//}
//
//
//@end
