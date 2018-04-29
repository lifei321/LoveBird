//
//  UIDevice+LFAddition.h
//  LoveBird
//
//  Created by cheli shan on 2018/4/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//



@interface UIDevice (LFAddition)

+ (NSInteger)lf_osMainVersion;

/*设备ID**/
- (NSString *)lf_deviceId;

+ (UIImage *)appGetAppIcon;

@end
