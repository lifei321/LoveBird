//
//  AppManager.h
//  LoveBird
//
//  Created by 十八子飞 on 2018/12/22.
//  Copyright © 2018 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppManager : NSObject

+ (AppManager *)sharedInstance;

- (void)refreshData;

- (void)netForMessageCount;

// 消息数量
@property (nonatomic, copy) NSString *messageCount;

// 最大上传数量
@property (nonatomic, copy) NSString *maxPicCount;

@end

NS_ASSUME_NONNULL_END
