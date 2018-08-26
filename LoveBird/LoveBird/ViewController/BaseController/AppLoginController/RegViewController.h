//
//  RegViewController.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/12.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseViewController.h"

typedef NS_ENUM(NSInteger, RegViewControllerType) {
    RegViewControllerTypeReg, // 注册
    RegViewControllerTypeForgetPassword, // 找回密码
    RegViewControllerTypeThird, // 第三方注册

};

@interface RegViewController : AppBaseViewController


/**
 *  页面类型
 */
@property (nonatomic, assign) RegViewControllerType controllerType;


@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *headImage;

@property (nonatomic, copy) NSString *uinionid;

@property (nonatomic, copy) NSString *openid;

@property (nonatomic, assign) NSInteger type;



@end
