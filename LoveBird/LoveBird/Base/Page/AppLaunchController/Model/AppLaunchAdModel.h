//
//  AppLaunchAdModel.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/6.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@interface AppLaunchAdModel : AppBaseModel

/**
 *  广告URL
 */
@property (nonatomic, copy) NSString *content;

/**
 *  点击打开连接
 */
@property (nonatomic, copy) NSString *openUrl;

/**
 *  广告分辨率
 */
@property (nonatomic, copy) NSString *contentSize;

/**
 *  广告停留时间
 */
@property (nonatomic, assign) NSInteger duration;


/**
 *  分辨率宽
 */
@property(nonatomic,assign,readonly)CGFloat width;
/**
 *  分辨率高
 */
@property(nonatomic,assign,readonly)CGFloat height;



@end
