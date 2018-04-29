//
//  BJXYHTTPManager.h
//  cardloan
//
//  Created by lzh on 2017/9/7.
//  Copyright © 2017年 renxin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "AppBaseModel.h"
#import "UIDevice+LFAddition.h"
#import "NSDictionary+NTBasicAdditions.h"
#import <JSONKit_NoWarning/JSONKit.h>

// 增加带有 task 的 bloc, 用来判断网络请求
typedef void(^BJXYRequestTaskFail)(NSError *error, NSURLSessionDataTask *task);
typedef void(^BJXYRequestSuccess)(id responseObject);
typedef void(^BJXYRequestProgress)(NSProgress *progress);

// 带model的回调
typedef void(^BJXYRequestModelSuccess)(AppBaseModel *responseObject);
typedef void(^BJXYRequestModelFail)(AppBaseModel *error);
typedef void(^BdRequestProgress)(NSProgress *progress);

// 重新发起网络请求
typedef void(^BJXYRestartRequest)();

// 自定义拦截错误回调block
typedef void(^BJXYResponseErrorHandler)(AppBaseModel *error, BJXYRequestModelFail failblock, BJXYRestartRequest restart);
typedef void(^BJXYNetworkFailHandler)(NSDictionary *errorDict);

typedef NS_ENUM (NSInteger, BJXYRetCode) {

    BJXYRetCodeSuccess = 0,                 //成功返回码
    BJXYRetCodeAuthInvalid = -4,            // 用户登陆失效
    BJXYRetCodeNoNetwork = -1009,          // 无网络连接
    BJXYRetCodeParameterError = -9999,     // 参数错误
    BJXYRetCodeNetError = -99998,           //网络错误码
    BJXYRetCodeJsonParseError = -99999,     //JSON解析失败
};

/**
 组装一个完整的url

 @param PATH like：@"/user/login"
 @return aURL
 */
#define BN_API_USER_SERVER_VERSION(PATH) [NSString stringWithFormat:@"%@/%@%@", [BJXYHTTPManager sharedClient].apiUserServer, [BJXYHTTPManager sharedClient].apiVersion, PATH]

/**
 组装一个完整的url， 使用自定义的版本号

 @param PATH like：@"/user/login"
 @param VERSION like：@"2.4"
 @return aURL
 */
#define BN_API_CUSTOM_SERVER_VERSION(PATH, VERSION) [NSString stringWithFormat:@"%@%@%@", [BJXYHTTPManager sharedClient].apiUserServer, VERSION, PATH]

@interface BJXYHTTPManager : AFHTTPSessionManager

/**
 *  单例
 */
+ (BJXYHTTPManager *)sharedClient;

/**
 服务器地址， like：@"http://www.baidu.com"
 */
@property (nonatomic, copy) NSString *apiUserServer;

/**
 服务器版本号， like：@"2.4"
 */
@property (nonatomic, copy) NSString *apiVersion;

/**
 *  加密秘钥
 */
@property (nonatomic, copy) NSString *serverEncryptSignKey;

/**
 *  自定义 UA
 */
@property (nonatomic, copy) NSString *appUserAgent;

/**
 通用参数字典，每次网络请求会带上此字典中的参数
 */
@property (nonatomic, strong) NSMutableDictionary *generalParaDict;

/**
 可以自定义errorString，key为错误码，value为errorString
 默认会有以下四个文案，可以自行替换文案：
 @(-1009) : @"网络异常，请检查网络",
 @(-99998) : @"对不起,服务器故障,请稍后重试",
 @(-99999) : @"json解析失败",
 @(-4) : @"请重新登录",
 */
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSString *> *errorStringDict;

/**
 网络请求成功，但是服务器返回错误，例 -4重新登陆
 自定义错误回调，key为@(-4)，value：BJXYResponseErrorHandler 类型的block
 */
@property (nonatomic, strong) NSMutableDictionary<NSNumber *, BJXYResponseErrorHandler> *responseErrorHandlDict;

/**
 网络错误回调，-500等 用于打点
 */
@property (nonatomic, copy) BJXYNetworkFailHandler networkErrorHandle;

/**
 GET请求
 *  @param url            url地址
 *  @param parameters     普通参数
 *  @param jsonModelName  使用 jsonModel解析的文件名,留空则不解析
 *  @param success        成功
 *  @param failure        失败
 */
+ (NSURLSessionDataTask *)GET:(NSString *)url
                   parameters:(NSDictionary *)parameters
                jsonModelName:(Class)jsonModelName
                      success:(BJXYRequestModelSuccess)success
                      failure:(BJXYRequestModelFail)failure;

/**
 POST请求
 *  @param url            url地址
 *  @param parameters     普通参数
 *  @param jsonModelName  使用 jsonModel解析的文件名,留空则不解析
 *  @param fileArray      文件数组，默认为nil,
 *
 *  如需要上传图片,则需传递一个数组,格式如下
 *
 *    [
 *       {
 *           "file": "文件data",
 *           "fileName": "文件域名字"
 *       }
 *
 *    ]
 *
 *  @param success        成功
 *  @param failure        失败
 *
 *  @return NSURLSessionDataTask NSURLSessionDataTask对象
 */
+ (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(NSDictionary *)parameters
                     fileArray:(NSArray *)fileArray
                 jsonModelName:(Class)jsonModelName
                       success:(BJXYRequestModelSuccess)success
                uploadProgress:(BJXYRequestProgress)uploadProgress
                       failure:(BJXYRequestModelFail)failure;

/**
 *  设置 cookie
 *
 *  @param key   cookie的键
 *  @param value cookie的值
 */
+ (void)setCookie:(NSString *)key value:(NSString *)value;

/**
 *  设备参数
 *
 *  @return 包含设备参数的dictionary
 */
+ (NSMutableDictionary *)requestDeviceParameters;

/**
 *  设置  公共 cookie
 */
+ (void)setAppCookie;

/**
 *  单独处理网络异常情况，供其他直接调用
 *
 *  @param failure failure
 */
+ (void)failure:(NSError *)error failure:(BJXYRequestModelFail)failure;
@end
