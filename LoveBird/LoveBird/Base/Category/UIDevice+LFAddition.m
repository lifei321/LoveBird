//
//  UIDevice+LFAddition.m
//  LoveBird
//
//  Created by cheli shan on 2018/4/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "UIDevice+LFAddition.h"
#import "KeychainWrapper.h"

@implementation UIDevice (LFAddition)

+ (NSInteger)lf_osMainVersion {
    NSString *version = [UIDevice currentDevice].systemVersion;
    
    return version.integerValue;
}

/**
 *   新设备ID
 *   iOS6+ [UIDevice identifierForVendor];
 */
- (NSString *)lf_deviceId {
    static NSString *deviceId;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        deviceId = [KeychainWrapper keychainStringFromMatchingIdentifier:@"lf_deviceId"];
        
        if (!deviceId) {
            deviceId = [[self identifierForVendor] UUIDString];
            
            if (deviceId) {
                [KeychainWrapper createKeychainValue:deviceId forIdentifier:@"lf_deviceId"];
            } else {
                NSAssert(0, @"Device ID not found");
                deviceId = [self randomDeviceId];
            }
        }
    });
    return deviceId;
}

- (void)removeKeychainDeviceId {
    [KeychainWrapper deleteItemFromKeychainWithIdentifier:@"lf_deviceId"];
}

#pragma mark -

- (NSString *)randomDeviceId {
    srandom([[NSDate date] timeIntervalSince1970]);
    NSString *uniqueId = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X", (Byte)random(), (Byte)random(), (Byte)random(), (Byte)random(), (Byte)random(), (Byte)random()];
    return uniqueId;
}

+ (UIImage *)appGetAppIcon {
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    
    return [UIImage imageNamed:icon];
}
@end
