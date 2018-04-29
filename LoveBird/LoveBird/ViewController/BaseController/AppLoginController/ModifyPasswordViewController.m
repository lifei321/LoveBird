//
//  ModifyPasswordViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/12.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "PasswordTextField.h"
#import "AppButton.h"


@interface ModifyPasswordViewController ()

@end

@implementation ModifyPasswordViewController {
    
    VerifiCodeView *_verifiCodeView;
    
    PasswordTextField *_passwordText;
    
    PasswordTextField *_passwordConfirmText;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"重置密码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //statusbar颜色
    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
    
    //标题颜色
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
    
    [self wr_setNavBarBackgroundAlpha:0];
    

    _verifiCodeView = [[VerifiCodeView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - AutoSize(248)) / 2, AutoSize(115), AutoSize(248), AutoSize(42))];
    _verifiCodeView.delegate = self;
    _verifiCodeView.verifiCode.placeholder = @"请输入短信验证码";
    _verifiCodeView.verifiCode.textColor = kColorTextColor3c3c3c;
    _verifiCodeView.verifiCode.font = kFont(13.5);
    [_verifiCodeView.verifiButton setTitleColor:kColorNavigationBar forState:UIControlStateNormal];
    [_verifiCodeView.verifiButton setTitleColor:kColorTextColorA1A1A1 forState:UIControlStateDisabled];
    [_verifiCodeView setAlignmentCenterWithSuperview:self.view];
    _verifiCodeView.isTransparent = YES;
    [_verifiCodeView pullVerifiCode];
    [self.view addSubview:_verifiCodeView];
    
    _passwordText = [[PasswordTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - AutoSize(248)) / 2, CGRectGetMaxY(_verifiCodeView.frame) + AutoSize(10), AutoSize(248), AutoSize(42))];
    _passwordText.placeholder = @"请设置新密码";
    [_passwordText setValue:kColorTextColorA1A1A1 forKeyPath:@"_placeholderLabel.textColor"];
    _passwordText.textColor = kColorTextColor3c3c3c;
    _passwordText.font = kFont(13.5);
    [_passwordText setAlignmentCenterWithSuperview:self.view];
    [self.view addSubview:_passwordText];
    
    _passwordConfirmText = [[PasswordTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - AutoSize(248)) / 2, CGRectGetMaxY(_passwordText.frame) + AutoSize(10), AutoSize(248), AutoSize(42))];
    _passwordConfirmText.placeholder = @"再次输入密码";
    [_passwordConfirmText setValue:kColorTextColorA1A1A1 forKeyPath:@"_placeholderLabel.textColor"];
    _passwordConfirmText.textColor = kColorTextColor3c3c3c;
    _passwordConfirmText.font = kFont(13.5);
    [_passwordConfirmText setAlignmentCenterWithSuperview:self.view];
    [self.view addSubview:_passwordConfirmText];
    
    AppButton *submitButton = [[AppButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - AutoSize(248)) / 2, CGRectGetMaxY(_passwordConfirmText.frame) + AutoSize(20), AutoSize(248), AutoSize(40)) style:AppButtonStyleYellow];
    submitButton.layer.cornerRadius = AutoSize(20);
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    [submitButton addTarget:self action:@selector(goToModifyPassword) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count == 1) {
        self.leftButton.image = [UIImage imageNamed:@"nav_close_black"];
    }
    
    //隐藏
    [self wr_setNavBarBackgroundAlpha:0];
}


- (void)goToModifyPassword {
    
    [self hideKeyboard];
    
    if ([_passwordText.text isBlankString]) {
        [AppBaseHud showHudWithfail:@"请输入修改密码" view:self.view];
        return;
    }
    
    if (![_passwordText.text isEqualToString:_passwordConfirmText.text]) {
        [AppBaseHud showHudWithfail:@"两次密码输入不一样" view:self.view];
        return;
    }
    
//    NSString *smscode = _verifiCodeView.verifiCode.text;
    
}


#pragma mark - VerifiCodeViewDelegate

- (NSString *)didClickButton:(AppButton *)button {
    return _mobile;
}

- (void)didSendSmsCodeSuccess:(NSString *)smsCode {
    
    _smsCode = smsCode;
    NSLog(@"发送验证码....%@", smsCode);
}

- (void)didSendSmsCodeFailure:(NSError *)error {
    
    NSLog(@"发送验证码....%@", error);
}

@end
