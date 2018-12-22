//
//  AppManager.m
//  LoveBird
//
//  Created by 十八子飞 on 2018/12/22.
//  Copyright © 2018 shancheli. All rights reserved.
//

#import "AppManager.h"
#import "SetDao.h"
#import "MessageModel.h"


@implementation AppManager

+ (AppManager *)sharedInstance {
    static AppManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)refreshData {
    [AppManager sharedInstance].messageCount = @"0";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshMessageCountNotification object:nil];

}


- (void)netForMessageCount {
    
    [SetDao getMessageSuccessBlock:^(__kindof AppBaseModel *responseObject) {
        MessageCountModel *countmodel = (MessageCountModel *)responseObject;
        [AppManager sharedInstance].messageCount = countmodel.allNum;
        [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshMessageCountNotification object:nil];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        
    }];
    
}


@end
