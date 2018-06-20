//
//  UserModel.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "UserModel.h"
#import <JSONModel/JSONModel.h>
#import "LoginViewController.h"

@implementation UserPage

+ (UserPage *)sharedInstance {
    static UserPage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userModel = [self getUserModel];
    }
    return self;
}

- (BOOL)isLogin {
    if ([UserPage sharedInstance].userModel.uid.length) {
        return YES;
    }
    return NO;
}

+ (void)logoutBlock:(UserModelBlock)block {
    [AppCache removeObjectForKey:@"token"];
    [AppCache removeObjectForKey:@"uid"];
    [UserPage sharedInstance].userModel.token = nil;
    [UserPage sharedInstance].userModel.uid = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutSuccessNotification object:nil];
    if (block) {
        block();
    }
}

+ (void)gotoLoinBlock:(UserModelBlock)block {
    
    if (![UserPage sharedInstance].isLogin) {
        LoginViewController *logvc = [[LoginViewController alloc] init];
        logvc.viewControllerActionBlock = ^(UIViewController *viewController, NSObject *userInfo) {
            if (block) {
                block();
            }
        };
        [[UIViewController currentViewController] presentViewController:[[AppBaseNavigationController alloc] initWithRootViewController:logvc] animated:YES completion:nil];
    }
}

- (void)setUserModel:(UserModel *)userModel {
    _userModel = userModel;
    
    [AppCache setObject:userModel.birthday forKey:@"birthday"];
    [AppCache setObject:userModel.mobile forKey:@"mobile"];
    [AppCache setObject:userModel.head forKey:@"head"];
    [AppCache setObject:userModel.location forKey:@"location"];
    [AppCache setObject:userModel.qq forKey:@"qq"];
    [AppCache setObject:userModel.sign forKey:@"sign"];
    [AppCache setObject:userModel.uid forKey:@"uid"];
    [AppCache setObject:userModel.username forKey:@"username"];
    [AppCache setObject:userModel.wechat forKey:@"wechat"];
    [AppCache setObject:userModel.weibo forKey:@"weibo"];
    [AppCache setObject:userModel.articleNum forKey:@"articleNum"];
    [AppCache setObject:userModel.birdspeciesNum forKey:@"birdspeciesNum"];
    [AppCache setObject:userModel.credit forKey:@"credit"];
    [AppCache setObject:userModel.fansNum forKey:@"fansNum"];
    [AppCache setObject:userModel.followNum forKey:@"followNum"];
    [AppCache setObject:@(userModel.hasCollection) forKey:@"hasCollection"];
    [AppCache setObject:userModel.level forKey:@"level"];
    [AppCache setObject:userModel.zuzhi forKey:@"zuzhi"];
    [AppCache setObject:userModel.token forKey:@"token"];
    [AppCache setObject:@(userModel.hasFriends) forKey:@"hasFriends"];
    [AppCache setObject:@(userModel.hasMessage) forKey:@"hasMessage"];
}

- (UserModel *)getUserModel {
    UserModel *userModel = [[UserModel alloc] init];
    userModel.birthday = [AppCache objectForKey:@"birthday"];
    userModel.mobile = [AppCache objectForKey:@"mobile"];
    userModel.head = [AppCache objectForKey:@"head"];
    userModel.location = [AppCache objectForKey:@"location"];
    userModel.qq = [AppCache objectForKey:@"qq"];
    userModel.sign = [AppCache objectForKey:@"sign"];
    userModel.uid = [AppCache objectForKey:@"uid"];
    userModel.username = [AppCache objectForKey:@"username"];
    userModel.wechat = [AppCache objectForKey:@"wechat"];
    userModel.weibo = [AppCache objectForKey:@"weibo"];
    userModel.articleNum = [AppCache objectForKey:@"articleNum"];
    userModel.birdspeciesNum = [AppCache objectForKey:@"birdspeciesNum"];
    userModel.credit = [AppCache objectForKey:@"credit"];
    userModel.fansNum = [AppCache objectForKey:@"fansNum"];
    userModel.followNum = [AppCache objectForKey:@"followNum"];
    userModel.hasCollection = [[AppCache objectForKey:@"hasCollection"] boolValue];
    userModel.level = [AppCache objectForKey:@"level"];
    userModel.zuzhi = [AppCache objectForKey:@"zuzhi"];
    userModel.token = [AppCache objectForKey:@"token"];
    userModel.hasFriends = [[AppCache objectForKey:@"hasFriends"] boolValue];
    userModel.hasMessage = [[AppCache objectForKey:@"hasMessage"] boolValue];

    return userModel;
}

@end

@implementation UserModel


+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONBlock:^NSString *(NSString *keyName) {
        return [NSString stringWithFormat:@"data.%@", keyName];
    }];
}

- (void)setUid:(NSString *)uid {
    _uid = [uid copy];
    [AppCache setObject:uid forKey:@"uid"];
}

- (void)setToken:(NSString *)token {
    _token = [token copy];
    [AppCache setObject:token forKey:@"token"];

}

@end
