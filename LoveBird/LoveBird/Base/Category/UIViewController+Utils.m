//
//  UIViewController+Utils.m
//  cardloan
//
//  Created by zhuayi on 16/6/1.
//  Copyright © 2016年 renxin. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

///最上层的VC
- (UIViewController *)topViewController {
    return [self topViewController:[[UIApplication sharedApplication].delegate window].rootViewController];
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self topViewController:[navigationController.viewControllers lastObject]];
    }
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabController = (UITabBarController *)rootViewController;
        return [self topViewController:tabController.selectedViewController];
    }
    
    if (rootViewController.presentedViewController) {
        return [self topViewController:rootViewController];
    }
    
    return rootViewController;
}

+ (UIViewController *)findBestViewController:(UIViewController* )vc {
    
    if (vc.presentedViewController) {
        
        // Return presented view controller
        return [UIViewController findBestViewController:vc.presentedViewController];
        
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        // Return right hand side
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        // Return top view
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.topViewController];
        else
            return vc;
        
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        // Return visible view
        UITabBarController* svc = (UITabBarController*) vc;
        if (svc.viewControllers.count > 0)
            return [UIViewController findBestViewController:svc.selectedViewController];
        else
            return vc;
        
    } else {
        
        // Unknown view controller type, return last child view controller
        return vc;
    }
}

+ (UIViewController*)currentViewController {
    
    // Find best window
    UIWindow *window = nil;
    if ([[UIApplication sharedApplication].keyWindow isMemberOfClass:[UIWindow class]]) {
        window = [UIApplication sharedApplication].keyWindow;
    }
    
    if (window == nil) {
        for (UIWindow *win in [UIApplication sharedApplication].windows) {
            if ([win isMemberOfClass:[UIWindow class]]) {
                window = win;
            }
        }
    }
    
    // Find best view controller
    UIViewController* viewController = window.rootViewController;
    return [UIViewController findBestViewController:viewController];
}

@end
