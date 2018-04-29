//
//  MineSetModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/3/5.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineSetModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *iconUrl;

@property (nonatomic, copy) NSString *detailText;

@property (nonatomic, assign) BOOL isShowContent;

@property (nonatomic, assign) BOOL isShowSwitch;

@property (nonatomic, copy) NSString *pushViewController;
@end
