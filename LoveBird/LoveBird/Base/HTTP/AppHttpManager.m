//
//  AppHttpManager.m
//  LoveBird
//
//  Created by ShanCheli on 2017/11/17.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppHttpManager.h"

@implementation AppHttpManager


+ (NSURLSessionDataTask *)GET:(NSString *)url
                   parameters:(NSDictionary *)parameters
                jsonModelName:(Class)jsonModelName
                      success:(LFRequestSuccess)success
                      failure:(LFRequestFail)failure {
    
    return [BJXYHTTPManager GET:url
                     parameters:parameters
                  jsonModelName:jsonModelName
                        success:^(AppBaseModel *responseObject) {
                            if(success) {
                                success(responseObject);
                            }
                        }
                        failure:^(AppBaseModel *error) {
                            if(failure) {
                                failure(error);
                            }
                        }];
}


+ (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(NSDictionary *)parameters
                     fileArray:(NSArray *)fileArray
                 jsonModelName:(Class)jsonModelName
                       success:(LFRequestSuccess)success
                uploadProgress:(BdRequestProgress)uploadProgress
                       failure:(LFRequestFail)failure {
    
    return [BJXYHTTPManager POST:url
                      parameters:parameters
                       fileArray:fileArray
                   jsonModelName:jsonModelName
                         success:^(AppBaseModel *responseObject) {
                             if(success) {
                                 success(responseObject);
                             }
                         }
                  uploadProgress:^(NSProgress *progress) {
                      if(uploadProgress) {
                          uploadProgress(progress);
                      }
                  }
                         failure:^(AppBaseModel *error) {
                             if(failure) {
                                 failure(error);
                             }
                         }];
}

+ (NSURLSessionDataTask *)POST:(NSString *)url
                    parameters:(NSDictionary *)parameters
                 jsonModelName:(Class)jsonModelName
                       success:(LFRequestSuccess)success
                       failure:(LFRequestFail)failure {
    
    return [BJXYHTTPManager POST:url
                      parameters:parameters
                       fileArray:nil
                   jsonModelName:jsonModelName
                         success:^(AppBaseModel *responseObject) {
                             if(success) {
                                 success(responseObject);
                             }
                         }
                  uploadProgress:nil
                         failure:^(AppBaseModel *error) {
                             if(failure) {
                                 failure(error);
                             }
                         }];
}


@end
