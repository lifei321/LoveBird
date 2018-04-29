//
//  RegViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/12.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "RegViewController.h"
#import "PhoneTextField.h"
#import "AppButton.h"
#import "LoginViewController.h"
#import "UIDevice+LFAddition.h"
#import "RegInfoViewController.h"
#import "ModifyPasswordViewController.h"


@interface RegViewController ()

@property (nonatomic, strong) PhoneTextField *phoneText;

@end

@implementation RegViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //statusbar颜色
    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
    
    //标题颜色
    [self wr_setNavBarTitleColor:[UIColor blackColor]];

    [self wr_setNavBarBackgroundAlpha:0];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count == 1) {
        self.leftButton.image = [UIImage imageNamed:@"nav_close_black"];
    }
    
    //隐藏
    [self wr_setNavBarBackgroundAlpha:0];
}



- (void)leftButtonAction {
    
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [super leftButtonAction];
    }
}


#pragma mark-- 去登录

- (void)goToLogin {
    [self hideKeyboard];
    
    //将之前的登录页面移除
    NSMutableArray *viewController1 = [self.navigationController.viewControllers mutableCopy];
    for(int i =0; i<[viewController1 count]; i++) {
        UIViewController *ctr = viewController1[i];
        if ([ctr isKindOfClass:[LoginViewController class]]) {
            [viewController1 removeObject:ctr];
        }
    }
    [self.navigationController setViewControllers:[viewController1 copy]];
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    //再将注册页面移除
    NSMutableArray *viewController2 = [self.navigationController.viewControllers mutableCopy];
    for(int i =0; i<[viewController2 count]; i++) {
        UIViewController *ctr = viewController2[i];
        if ([ctr isKindOfClass:[RegViewController class]]) {
            [viewController2 removeObject:ctr];
        }
    }
    [self.navigationController setViewControllers:[viewController2 copy]];
}

#pragma mark- 去注册 或者 重置密码

- (void)goToReg {
    
    [self hideKeyboard];
    
    NSString *mobile = [_phoneText.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if ([mobile isBlankString]) {
        
        [AppBaseHud showHudWithfail:@"请输入手机号" view:self.view];
        return;
    }
    
    if ([mobile validateMobile] == NO) {
        
        [AppBaseHud showHudWithfail:@"请输入正确的手机号" view:self.view];
        return;
    }
    
    if (_controllerType == RegViewControllerTypeForgetPassword) {
        
        ModifyPasswordViewController *modifypassword =[[ModifyPasswordViewController alloc] init];
        modifypassword.mobile = _phoneText.text;
        [self.navigationController pushViewController:modifypassword animated:YES];
        
    } else {
        
        RegInfoViewController *regInfoVC =[[RegInfoViewController alloc] init];
        regInfoVC.phoneText = _phoneText;
        [self.navigationController pushViewController:regInfoVC animated:YES];

    }
}

@end
