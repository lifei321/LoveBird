//
//  AppBaseHud.m
//  LoveBird
//
//  Created by ShanCheli on 2017/6/21.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseHud.h"

static CGFloat FONT_SIZE = 14.0f;
static CGFloat OPACITY = 0.85;

static CGFloat HudAfterTime = 2.5;

@implementation AppBaseHud

/**
 *  显示提示框
 *
 */
+ (void)showHud:(NSString *)title tipsType:(BWMMBProgressHUDMsgType)tipsType view:(UIView *)view {
    
    if (view == nil) {
        return;
    }
    [AppBaseHud hideHud:view];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.labelFont = [UIFont systemFontOfSize:FONT_SIZE];
    HUD.labelText = nil;
    HUD.detailsLabelText = title;
    HUD.opacity = OPACITY;
    
    [HUD bwm_hideWithTitle:nil
                 hideAfter:HudAfterTime
                   msgType:tipsType];
    
}

+ (void)showHud:(NSString *)title view:(UIView *)view {
    if (view == nil) {
        return;
    }
    [AppBaseHud hideHud:view];
    [MBProgressHUD bwm_showTitle:title toView:view hideAfter:kAfterSecond];
}

/**
 *  显示等待指示器
 */
+ (void)showHudWithLoding:(UIView *)view {
    
    [AppBaseHud hideHud:view];
    [AppBaseHud showHudWithLoding:view title:@"正在加载..."];
}

/**
 *  显示等待指示器
 */
+ (void)showHudWithLoding:(UIView *)view title:(NSString *)title {
    if (view == nil) {
        return;
    }
    [AppBaseHud hideHud:view];;
    MBProgressHUD *HUD = [MBProgressHUD bwm_showHUDAddedTo:view title:kBWMMBProgressHUDMsgLoading];
    HUD.labelText = nil;
    HUD.detailsLabelText = title;
}

/**
 *   操作成功
 *
 */
+ (void)showHudWithSuccessful:(NSString *)title view:(UIView *)view {
    
    [AppBaseHud showHud:title tipsType:BWMMBProgressHUDMsgTypeSuccessful view:view];
}

/**
 *   操作成功
 *
 */
+ (void)showHudWithSuccessful:(NSString *)title view:(UIView *)view block:(AppHudBlock)block {
    [AppBaseHud showHud:title tipsType:BWMMBProgressHUDMsgTypeSuccessful view:view];
    sleep(HudAfterTime);
    if (block) {
        block();
    }
    
}

/**
 *   操作失败
 *
 */
+ (void)showHudWithfail:(NSString *)title view:(UIView *)view {
    
    if (view == nil) {
        return;
    }
    [AppBaseHud showHud:title tipsType:BWMMBProgressHUDMsgTypeError view:view];
}

/**
 *   操作失败
 *
 */
+ (void)showHudWithfail:(NSString *)title view:(UIView *)view block:(AppHudBlock)block {
    [AppBaseHud showHudWithfail:title view:view];
    sleep(HudAfterTime);
    if (block) {
        block();
    }
}

/**
 *   显示进度条
 *
 */
+ (MBProgressHUD *)showHubWithProgressTitle:(NSString *)title detail:(NSString *)detail view:(UIView *)view {
    if(view == nil) {
        return nil;
    }
    [AppBaseHud hideHud:view];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.labelText = title;
    hud.detailsLabelText = detail;
    hud.progress = 0.01;//设置为0.0会出现进度条无法更新的问题
    hud.animationType = MBProgressHUDAnimationZoomIn;
    [view addSubview:hud];
    [hud show:YES];
    return hud;
}

/**
 *  隐藏指示器
 *
 */
+ (void)hideHud:(UIView *)view {
    
    if (view == nil) {
        return;
    }
    
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

@end
