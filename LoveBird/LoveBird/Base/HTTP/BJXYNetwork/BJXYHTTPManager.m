//
//  BJXYHTTPManager.m
//  cardloan
//
//  Created by lzh on 2017/9/7.
//  Copyright © 2017年 renxin. All rights reserved.
//

#import "BJXYHTTPManager.h"

static BJXYHTTPManager *httpManagersharedClient = nil;

@implementation BJXYHTTPManager

+ (BJXYHTTPManager *)sharedClient {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        httpManagersharedClient = [self manager];
        httpManagersharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        httpManagersharedClient.securityPolicy.allowInvalidCertificates = YES;
        httpManagersharedClient.securityPolicy.validatesDomainName = YES;
        httpManagersharedClient.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions: NSJSONReadingAllowFragments];
        httpManagersharedClient.requestSerializer.HTTPShouldHandleCookies = YES;
        [httpManagersharedClient.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [httpManagersharedClient.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        httpManagersharedClient.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/javascript",nil];

        [BJXYHTTPManager setAppCookie];
        
    });
    return httpManagersharedClient;
}

#pragma mark - 带转换模型的get和post方法
+ (NSURLSessionDataTask *)GET:(NSString *)url
                   parameters:(NSDictionary *)parameters
                jsonModelName:(Class)jsonModelName
                      success:(BJXYRequestModelSuccess)success
                      failure:(BJXYRequestModelFail)failure {

    NSMutableDictionary *data = [self requestDeviceParameters];
    [data addEntriesFromDictionary:parameters];
    
    //重新登陆，会多一个sign参数
    if (data[@"sign"]) [data removeObjectForKey:@"sign"];
    
    // // 添加通用参数，自定义如ua，channel参数
    if ([self sharedClient].generalParaDict) {
        [data addEntriesFromDictionary:[self sharedClient].generalParaDict];
    }
    
    // 加密
    [data serializeDictToOauth1:[self sharedClient].serverEncryptSignKey appendDict:@{@"ut":@((NSInteger)[[NSDate date] timeIntervalSince1970])}];
    
    if ([self sharedClient].appUserAgent) {
        [[self sharedClient].requestSerializer setValue:[self sharedClient].appUserAgent forHTTPHeaderField:@"User-Agent"];
    }
    
    return [self GET:url parameters:data success:^(id responseObject) {
        
        [self success:jsonModelName responseObject:responseObject success:^(id responseObject) {
            
            success(responseObject);
            
        } failure:^(AppBaseModel *error) {
            
            BJXYResponseErrorHandler responseErrorHandler = [[self sharedClient].responseErrorHandlDict objectForKey:@(error.errcode)];
            if (responseErrorHandler) {
                
                BJXYRestartRequest restart = ^(){
                    [self GET:url parameters:data jsonModelName:jsonModelName success:success failure:failure];
                };
                responseErrorHandler(error, failure, restart);
            } else {
                failure((AppBaseModel *)error);
            }
        }];
        
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        // 网络错误上报
        if ([self sharedClient].networkErrorHandle) {
            NSDictionary *netErrorDict = [self getNetworkError:error dataTask:task];
            if (netErrorDict) {
                [self sharedClient].networkErrorHandle(netErrorDict);
            }
        }
        
        [self failure:error failure:^(AppBaseModel *error) {
            failure((AppBaseModel *)error);
        }];
    }];
}


+ (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(NSDictionary *)parameters
                     fileArray:(NSArray *)fileArray
                 jsonModelName:(Class)jsonModelName
                       success:(BJXYRequestModelSuccess)success
                uploadProgress:(BJXYRequestProgress)uploadProgress
                       failure:(BJXYRequestModelFail)failure {
    
    NSMutableDictionary *data = [self requestDeviceParameters];
    [data addEntriesFromDictionary:parameters];
    
    //重新登陆，会多一个sign参数
    if (data[@"sign"]) [data removeObjectForKey:@"sign"];
    
    // // 添加通用参数，自定义如ua，channel参数
    if ([self sharedClient].generalParaDict) {
        [data addEntriesFromDictionary:[self sharedClient].generalParaDict];
    }
    
    // 加密
    [data serializeDictToOauth1:[self sharedClient].serverEncryptSignKey appendDict:@{@"ut":@((NSInteger)[[NSDate date] timeIntervalSince1970])}];
    
    if ([self sharedClient].appUserAgent) {
        [[self sharedClient].requestSerializer setValue:[self sharedClient].appUserAgent forHTTPHeaderField:@"User-Agent"];
    }
    
    return [self POST:url parameters:data fileArray:fileArray success:^(id responseObject) {
        
        [self success:jsonModelName responseObject:responseObject success:^(id responseObject) {
            success(responseObject);
            
        } failure:^(AppBaseModel *error) {
            
            BJXYResponseErrorHandler responseErrorHandler = [[self sharedClient].responseErrorHandlDict objectForKey:@(error.errcode)];
            if (responseErrorHandler) {
                BJXYRestartRequest restart = ^(){
                    [self GET:url parameters:data jsonModelName:jsonModelName success:success failure:failure];
                };
                responseErrorHandler(error, failure, restart);
            } else {
                failure((AppBaseModel *)error);
            }
        }];
    } progress:^(NSProgress *progress) {
        if (uploadProgress) {
            uploadProgress(progress);
        }
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        // 网络错误上报
        if ([self sharedClient].networkErrorHandle) {
            NSDictionary *netErrorDict = [self getNetworkError:error dataTask:task];
            if (netErrorDict) {
                [self sharedClient].networkErrorHandle(netErrorDict);
            }
        }
        [self failure:error failure:^(AppBaseModel *error) {
            failure((AppBaseModel *)error);
        }];
    }];
}

#pragma mark - 基础get和post方法
+ (NSURLSessionDataTask *)GET:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(BJXYRequestSuccess)success
                      failure:(BJXYRequestTaskFail)failure {
    
    AFHTTPSessionManager *manager = [BJXYHTTPManager sharedClient];
    
    NSURLSessionDataTask *operation = [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error, task);
        }
    }];

    return operation;
}

+ (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(NSDictionary *)parameters
                     fileArray:(NSArray *)fileArray
                       success:(BJXYRequestSuccess)success
                      progress:(BJXYRequestProgress)progress
                       failure:(BJXYRequestTaskFail)failure {
    AFHTTPSessionManager *manager = [BJXYHTTPManager sharedClient];
    
    NSURLSessionDataTask *operation = [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (fileArray) {
            for (NSDictionary *dict in fileArray) {
                NSData *data = [dict objectForKey:@"file"];
                NSString *fileName = @"";
                
                if (data) {
                    if ([dict objectForKey:@"fileName"]) {
                        fileName = [dict objectForKey:@"fileName"];
                    }
                    
                    [formData appendPartWithFileData:data name:fileName fileName:fileName mimeType:@"image/jpg/file"];
                }
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error, task);
        }
    }];
    
    return operation;
}

/**
 *  设置  公共 cookie
 */
+ (void)setAppCookie {
    // 逻辑 cookie
    NSMutableDictionary *logicCookie = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [logicCookie setObject:APP_VERSION forKey:@"app_version"];
    [logicCookie setObject:CurrentSystemVersion forKey:@"os_version"];
    [logicCookie setObject:CurrentLanguage forKey:@"language"];
    [logicCookie setObject:[[UIDevice currentDevice] lf_deviceId] forKey:@"mac_id"];
    [logicCookie setObject:@"ios" forKey:@"plat"];
    
    for (NSString *key in logicCookie) {
        [BJXYHTTPManager setCookie:key value:[logicCookie objectForKey:key]];
    }
}

/**
 *  设置 cookie
 */
+ (void)setCookie:(NSString *)key value:(NSString *)value  {
    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
    
    [cookieDic setObject:key forKey:NSHTTPCookieName];
    [cookieDic setValue:value forKey:NSHTTPCookieValue];
    
    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieDic];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
}

/**
 将网络请求回来的数据转为模型

 @param jsonModelName 模型类名
 @param responseObject id对象
 @param success 转换成功
 @param failure 转换失败
 */
+ (void)success:(Class)jsonModelName responseObject:(id)responseObject
        success:(BJXYRequestModelSuccess)success
        failure:(BJXYRequestModelFail)failure {
    
    if ([responseObject isKindOfClass:[NSData class]]) {
        //objectFromJSONData
        responseObject = [((NSData *)responseObject) objectFromJSONData];
    }
    
    if (jsonModelName == nil) {
        success(responseObject);
        return;
    }
    
    NSError *error = nil;
    AppBaseModel *model = nil;
    
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        
        model = [self creatErrorBaseModel:BJXYRetCodeJsonParseError];
        failure(model);
        return;
    }
    
    // 先判断errcode < 0 的判断
    if ([responseObject objectForKey:@"msg"] && [[responseObject objectForKey:@"code"] integerValue] < 0) {
        
        @try {
            model = [[AppBaseModel alloc] initWithDictionary:responseObject error:&error];
            
            if (error) {
                model = [self creatErrorBaseModel:BJXYRetCodeJsonParseError];
            }
            
        } @catch (NSException *exception) {
            model = [self creatErrorBaseModel:BJXYRetCodeAuthInvalid];
        } @finally {
            failure(model);
        }
        
        return;
    }
    
    @try {
        model = [[jsonModelName alloc] initWithDictionary:responseObject error:&error];
        
        if (error) {
            model = [self creatErrorBaseModel:BJXYRetCodeJsonParseError];
        }
        
    } @catch (NSException *exception) {
        
        NSLog(@"---服务端返回的数据类型与模型不符---%@", exception);
        // 子类的自定义与服务端返回的数据类型可能不符导致jsonmodel 解析失败
        model = [self creatErrorBaseModel:BJXYRetCodeJsonParseError];
    } @finally {
        
        if (model.errcode >= 0) {
            success(model);
        } else {
            failure(model);
        }
    }
}

#pragma mark - getter
- (NSMutableDictionary *)generalParaDict {
    if (_generalParaDict == nil) {
        _generalParaDict = [NSMutableDictionary dictionary];
    }
    return _generalParaDict;
}

- (NSMutableDictionary *)errorStringDict {
    if (_errorStringDict == nil) {
        _errorStringDict = [@{
                              @(-1009) : @"网络异常，请检查网络",
                              @(-99998) : @"对不起,服务器故障,请稍后重试",
                              @(-99999) : @"json解析失败",
                              @(-4) : @"请重新登录",
                              } mutableCopy];
    }
    return _errorStringDict;
}

- (NSMutableDictionary *)responseErrorHandlDict {
    if (_responseErrorHandlDict == nil) {
        _responseErrorHandlDict = [NSMutableDictionary dictionary];
    }
    return _responseErrorHandlDict;
}

#pragma mark - convenient method

/**
 获取app基本信息
 */
+ (NSMutableDictionary *)requestDeviceParameters {
    NSMutableDictionary *deviceData = [NSMutableDictionary  dictionary];
    
    [deviceData setObject:APP_VERSION forKey:@"soft_version"];
    [deviceData setObject:CurrentSystemVersion forKey:@"os_version"];
    [deviceData setObject:CurrentLanguage forKey:@"language"];
    [deviceData setObject:[[UIDevice currentDevice] lf_deviceId] forKey:@"mac_id"];//设备id
    [deviceData setObject:@"ios" forKey:@"os"];
    return deviceData;
}

+ (void)failure:(NSError *)error failure:(BJXYRequestModelFail)failure {
    
    AppBaseModel *model = nil;
    if (error && [[self sharedClient].errorStringDict objectForKey:@(error.code)]) {
        model = [self creatErrorBaseModel:(error.code)];
    } else {
        model = [self creatErrorBaseModel:BJXYRetCodeNetError];
    }
    failure(model);
}

+ (AppBaseModel *)creatErrorBaseModel:(NSInteger)errorCode {
    AppBaseModel *model = [[AppBaseModel alloc] init];
    model.errcode = errorCode;
    model.errstr = [[BJXYHTTPManager sharedClient].errorStringDict objectForKey:@(errorCode)];
    model.errstr = model.errstr == nil ? @"" : model.errstr;
    return model;
}

/**
 从task和error中收集网络错误信息
 */
+ (NSDictionary *)getNetworkError:(NSError *)error dataTask:(NSURLSessionDataTask *)task {
    
    if (error.code == NSURLErrorTimedOut
        || error.code == NSURLErrorCannotConnectToHost
        || error.code == NSURLErrorHTTPTooManyRedirects
        || error.code == NSURLErrorCannotConnectToHost
        || error.code == NSURLErrorRedirectToNonExistentLocation
        || error.code == NSURLErrorBadServerResponse) {
        
        NSMutableDictionary *errorDict = [NSMutableDictionary dictionary];
        
        if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
            [errorDict setObject:@(((NSHTTPURLResponse *)task.response).statusCode) forKey:@"errorCode"];
        } else {
            [errorDict setObject:@(error.code) forKey:@"errorCode"];
        }
        if (task.currentRequest.URL.absoluteString) {
            [errorDict setObject:task.currentRequest.URL.absoluteString forKey:@"errorUrl"];
        }
        return errorDict;
    }
    return nil;
}

@end
