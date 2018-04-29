//
//  AppHttpManager.h
//  LoveBird
//
//  Created by ShanCheli on 2017/11/17.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BJXYHTTPManager.h"
#import "AppBaseModel.h"

#define EMPTY_STRING_IF_NIL(a)  (((a)==nil)?@"":(a))


typedef void(^CardRequestSuccess)(__kindof AppBaseModel *responseObject);
typedef void(^CardRequestFail)(__kindof AppBaseModel *error);

@interface AppHttpManager : NSObject


+ (NSURLSessionDataTask *)GET:(NSString *)url
                   parameters:(NSDictionary *)parameters
                jsonModelName:(Class)jsonModelName
                      success:(CardRequestSuccess)success
                      failure:(CardRequestFail)failure;

+ (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(NSDictionary *)parameters
                     fileArray:(NSArray *)fileArray
                 jsonModelName:(Class)jsonModelName
                       success:(CardRequestSuccess)success
                uploadProgress:(BdRequestProgress)uploadProgress
                       failure:(CardRequestFail)failure;


+ (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(NSDictionary *)parameters
                 jsonModelName:(Class)jsonModelName
                       success:(CardRequestSuccess)success
                       failure:(CardRequestFail)failure;
@end
