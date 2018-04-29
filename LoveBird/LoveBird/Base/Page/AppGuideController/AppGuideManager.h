//
//  AppGuideManager.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppGuideManager : NSObject



+(AppGuideManager *)shareManager;


//显示引导页
- (void)showGuideView;

@end
