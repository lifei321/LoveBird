//
//  ResetWordController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/18.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ResetWordController.h"
#import "PhoneTextField.h"
#import "PasswordTextField.h"
#import "UserDao.h"
#import "RegisterModel.h"

@interface ResetWordController ()

@property (nonatomic, strong) PasswordTextField *passwordTextField;

@property (nonatomic, strong) PasswordTextField *passwordTextField2;

@property (nonatomic, strong) PhoneTextField *phoneTextField;

@property (nonatomic, strong) AppTextField *nameTextField;

@property (nonatomic, strong) AppTextField *codeTextField;

@end

@implementation ResetWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.title = @"找回密码";
    
    if ([self.type isEqualToString:@"1"]) {
        [self makeView];
    } else {
        [self makeView2];
    }
}

- (void)makeView {
    
    //账号输入框
    UIView *phoneView = [self makeTextBackViewWithImage:@"phone"
                                                  frame:CGRectMake(AutoSize6(30), AutoSize6(45) + total_topView_height, SCREEN_WIDTH - AutoSize6(60), AutoSize(44))
                                            placeHolder:@"请输入手机号"
                                                 isShow:0];
    [self.view addSubview:phoneView];
    
    UIView *linePhone = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), phoneView.bottom, phoneView.width, 0.5)];
    linePhone.backgroundColor = kColorTarBarTitleHighlightColor;
    [self.view addSubview:linePhone];
    
    // 验证码
    UIView *codeView = [self makeTextBackViewWithImage:@"log_code"
                                                 frame:CGRectMake(AutoSize6(30), linePhone.bottom , phoneView.width, AutoSize(44))
                                           placeHolder:@"请输入验证码"
                                                isShow:3];
    [self.view addSubview:codeView];
    
    UIView *linecode = [[UIView alloc] initWithFrame:CGRectMake(AutoSize(13), codeView.bottom, phoneView.width, 0.5)];
    linecode.backgroundColor = kLineColoreLightGrayECECEC;
    [self.view addSubview:linecode];
    
    UIButton *codeButton = [[UIButton alloc] initWithFrame:CGRectMake(AutoSize6(50), linecode.bottom + AutoSize6(50), SCREEN_WIDTH - AutoSize6(100), AutoSize6(80))];
    [codeButton setTitle:@"下一步" forState:UIControlStateNormal];
    [codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [codeButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    codeButton.titleLabel.font = kFont6(26);
    codeButton.backgroundColor = kColorDefaultColor;
    codeButton.layer.cornerRadius = 4;
    [self.view addSubview:codeButton];

}

- (void)makeView2 {
    
    //账号输入框
    UIView *phoneView = [self makeTextBackViewWithImage:@"phone"
                                                  frame:CGRectMake(AutoSize6(30), AutoSize6(45) + total_topView_height, SCREEN_WIDTH - AutoSize6(60), AutoSize(44))
                                            placeHolder:@"请输入手机号"
                                                 isShow:0];
    [self.view addSubview:phoneView];
    
    UIView *linePhone = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), phoneView.bottom, phoneView.width, 0.5)];
    linePhone.backgroundColor = kColorTarBarTitleHighlightColor;
    [self.view addSubview:linePhone];
    

    //密码
    UIView *passWordView = [self makeTextBackViewWithImage:@"lock"
                                                     frame:CGRectMake(AutoSize6(30), linePhone.bottom , phoneView.width, AutoSize(44))
                                               placeHolder:@"请输入新密码（至少6位字符）"
                                                    isShow:1];
    [self.view addSubview:passWordView];
    
    UIView *linePass = [[UIView alloc] initWithFrame:CGRectMake(AutoSize(13), passWordView.bottom, phoneView.width, 0.5)];
    linePass.backgroundColor = kLineColoreLightGrayECECEC;
    [self.view addSubview:linePass];
    
    //密码
    UIView *passWordView2 = [self makeTextBackViewWithImage:@"lock"
                                                     frame:CGRectMake(AutoSize6(30), linePass.bottom , phoneView.width, AutoSize(44))
                                               placeHolder:@"确认密码"
                                                    isShow:4];
    [self.view addSubview:passWordView2];
    
    UIView *linePass2 = [[UIView alloc] initWithFrame:CGRectMake(AutoSize(13), passWordView2.bottom, phoneView.width, 0.5)];
    linePass2.backgroundColor = kLineColoreLightGrayECECEC;
    [self.view addSubview:linePass2];
    
    
    
    UIButton *codeButton = [[UIButton alloc] initWithFrame:CGRectMake(AutoSize6(50), linePass2.bottom + AutoSize6(50), SCREEN_WIDTH - AutoSize6(100), AutoSize6(80))];
    [codeButton setTitle:@"登录" forState:UIControlStateNormal];
    [codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [codeButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    codeButton.titleLabel.font = kFont6(26);
    codeButton.backgroundColor = kColorDefaultColor;
    codeButton.layer.cornerRadius = 4;
    [self.view addSubview:codeButton];
    
}


- (void)registerButtonClick {
    
    if (!_phoneTextField.text.length) {
        [AppBaseHud showHudWithfail:@"请输入手机号" view:self.view];
        return;
    }
    
    if (!_codeTextField.text.length) {
        [AppBaseHud showHudWithfail:@"请输入手机验证码" view:self.view];
        return;
    }

    ResetWordController *resetvc = [[ResetWordController alloc] init];
    resetvc.type = @"2";
    [self.navigationController pushViewController:resetvc animated:YES];
}

- (void)loginButtonClick {
    
    if (!_phoneTextField.text.length) {
        [AppBaseHud showHudWithfail:@"请输入手机号" view:self.view];
        return;
    }
    
    if (!_passwordTextField.text.length) {
        [AppBaseHud showHudWithfail:@"请输入密码" view:self.view];
        return;
    }
    
    if (!_passwordTextField2.text.length) {
        [AppBaseHud showHudWithfail:@"请输入密码" view:self.view];
        return;
    }
    
    if (![_passwordTextField.text isEqualToString:_passwordTextField2.text]) {
        [AppBaseHud showHudWithfail:@"两次密码不一致，请重新输入" view:self.view];
        return;
    }
    
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [UserDao userLogin:_phoneTextField.text
              password:[_passwordTextField.text md5HexDigest]
          SuccessBlock:^(__kindof AppBaseModel *responseObject) {
              @strongify(self);
              [AppBaseHud hideHud:self.view];
              
              [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
              [self dismissViewControllerAnimated:YES completion:nil];
              
          } failureBlock:^(__kindof AppBaseModel *error) {
              @strongify(self);
              [AppBaseHud showHudWithfail:error.errstr view:self.view];
          }];
}

- (void)codeButtonClick {
    
}

- (UIView *)makeTextBackViewWithImage:(NSString *)image
                                frame:(CGRect)frame
                          placeHolder:(NSString *)placeHolder
                               isShow:(NSInteger)isShow {
    
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize(0), (frame.size.height - AutoSize(20)) / 2, AutoSize(20), AutoSize(20))];
    icon.contentMode = UIViewContentModeCenter;
    icon.image = [UIImage imageNamed:image];
    [backView addSubview:icon];
    
    
    if (isShow == 0) {
        PhoneTextField *phoneTextField = [[PhoneTextField alloc] initWithFrame:CGRectMake(icon.right + AutoSize(13), 0, frame.size.width - icon.right - AutoSize(26), frame.size.height)];
        phoneTextField.placeholder = placeHolder;
        phoneTextField.textColor = [UIColor blackColor];
        phoneTextField.font = kFont(14);
        [backView addSubview:phoneTextField];
        self.phoneTextField = phoneTextField;
        if (self.phone.length) {
            self.phoneTextField.text = self.phone;
        }
        
    } else if (isShow == 1) {
        PasswordTextField *textField = [[PasswordTextField alloc] initWithFrame:CGRectMake(icon.right + AutoSize(13), 0, frame.size.width - icon.right - AutoSize(26), frame.size.height)];
        textField.placeholder = placeHolder;
        textField.textColor = [UIColor blackColor];
        textField.secureTextEntry = NO;
        textField.font = kFont(14);
        [backView addSubview:textField];
        
        self.passwordTextField = textField;
        
    } else if (isShow == 2) {
        AppTextField *textField = [[AppTextField alloc] initWithFrame:CGRectMake(icon.right + AutoSize(13), 0,  frame.size.width - icon.right - AutoSize(26), frame.size.height)];
        textField.placeholder = placeHolder;
        textField.textColor = [UIColor blackColor];
        textField.isTransparent = YES;
        textField.font = kFont(14);
        [backView addSubview:textField];
        self.nameTextField = textField;
    } else if(isShow == 3){
        AppTextField *textField = [[AppTextField alloc] initWithFrame:CGRectMake(icon.right + AutoSize(13), 0, frame.size.width - icon.right - AutoSize(13) - AutoSize6(180), frame.size.height)];
        textField.placeholder = placeHolder;
        textField.textColor = [UIColor blackColor];
        textField.isTransparent = YES;
        textField.font = kFont(14);
        [backView addSubview:textField];
        self.codeTextField = textField;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(textField.right, AutoSize6(20), 1, frame.size.height - AutoSize6(40))];
        line.backgroundColor = kLineColoreLightGrayECECEC;
        [backView addSubview:line];
        
        UIButton *codeButton = [[UIButton alloc] initWithFrame:CGRectMake(line.right, 0, AutoSize6(180), textField.height)];
        [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [codeButton setTitleColor:kColorDefaultColor forState:UIControlStateNormal];
        [codeButton addTarget:self action:@selector(codeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        codeButton.titleLabel.font = kFont6(26);
        codeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [backView addSubview:codeButton];
        
    } else if (isShow == 4) {
        PasswordTextField *textField = [[PasswordTextField alloc] initWithFrame:CGRectMake(icon.right + AutoSize(13), 0, frame.size.width - icon.right - AutoSize(26), frame.size.height)];
        textField.placeholder = placeHolder;
        textField.textColor = [UIColor blackColor];
        textField.secureTextEntry = NO;
        textField.font = kFont(14);
        [backView addSubview:textField];
        
        self.passwordTextField2 = textField;
    }
    return backView;
}





@end
