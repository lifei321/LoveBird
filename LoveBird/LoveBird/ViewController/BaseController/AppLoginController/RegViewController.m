//
//  RegViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/12.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "RegViewController.h"
#import "AppButton.h"
#import "LoginViewController.h"
#import "UIDevice+LFAddition.h"
#import "PhoneTextField.h"
#import "PasswordTextField.h"
#import "TTTAttributedLabel.h"
#import "UserDao.h"
#import "RegisterModel.h"


@interface RegViewController ()<UITextFieldDelegate, TTTAttributedLabelDelegate>

@property (nonatomic, strong) PasswordTextField *passwordTextField;

@property (nonatomic, strong) PhoneTextField *phoneTextField;

@property (nonatomic, strong) AppTextField *nameTextField;

@property (nonatomic, strong) AppTextField *codeTextField;

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
    
    if (self.controllerType == RegViewControllerTypeReg) {
        self.title = @"注册";
    } else {
        self.title = @"找回密码";
    }
    
    [self makeView];

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
    
    //密码
    UIView *passWordView = [self makeTextBackViewWithImage:@"lock"
                                                     frame:CGRectMake(AutoSize6(30), linePhone.bottom , phoneView.width, AutoSize(44))
                                               placeHolder:@"请输入密码"
                                                    isShow:1];
    [self.view addSubview:passWordView];
    
    UIView *linePass = [[UIView alloc] initWithFrame:CGRectMake(AutoSize(13), passWordView.bottom, phoneView.width, 0.5)];
    linePass.backgroundColor = kLineColoreLightGrayECECEC;
    [self.view addSubview:linePass];
    
    //昵称
    UIView *nickNameView = [self makeTextBackViewWithImage:@"log_nickname"
                                                     frame:CGRectMake(AutoSize6(30), linePass.bottom , phoneView.width, AutoSize(44))
                                               placeHolder:@"请输入昵称"
                                                    isShow:2];
    [self.view addSubview:nickNameView];
    
    UIView *linename = [[UIView alloc] initWithFrame:CGRectMake(AutoSize(13), nickNameView.bottom, phoneView.width, 0.5)];
    linename.backgroundColor = kLineColoreLightGrayECECEC;
    [self.view addSubview:linename];
    
    // 验证码
    UIView *codeView = [self makeTextBackViewWithImage:@"log_code"
                                                     frame:CGRectMake(AutoSize6(30), linename.bottom , phoneView.width, AutoSize(44))
                                               placeHolder:@"请输入验证码"
                                                    isShow:3];
    [self.view addSubview:codeView];
    
    UIView *linecode = [[UIView alloc] initWithFrame:CGRectMake(AutoSize(13), codeView.bottom, phoneView.width, 0.5)];
    linecode.backgroundColor = kLineColoreLightGrayECECEC;
    [self.view addSubview:linecode];
    
    UIButton *codeButton = [[UIButton alloc] initWithFrame:CGRectMake(AutoSize6(50), linecode.bottom + AutoSize6(50), SCREEN_WIDTH - AutoSize6(100), AutoSize6(80))];
    [codeButton setTitle:@"注册" forState:UIControlStateNormal];
    [codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [codeButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    codeButton.titleLabel.font = kFont6(26);
    codeButton.backgroundColor = kColorDefaultColor;
    codeButton.layer.cornerRadius = 4;
    [self.view addSubview:codeButton];
    
    // 使用协议
    TTTAttributedLabel *readLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(codeButton.left, codeButton.bottom + AutoSize(20), codeButton.width, AutoSize(15))];
    readLabel.textAlignment = NSTextAlignmentCenter;
    readLabel.delegate = self;
    NSString *text = @"登陆后意味着同意爱鸟网的《使用协议》";
    UIFont *font = kFont(12);
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    [readLabel setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)ctFont range:NSMakeRange(0, [text length])];
        [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:kColorTextColorLightGraya2a2a2 range:NSMakeRange(0, text.length)];
        [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(8, 3)];
        return  mutableAttributedString;
    }];
    readLabel.linkAttributes = @{(NSString *)kCTFontAttributeName:(__bridge id)ctFont,(id)kCTForegroundColorAttributeName:kColorDefaultColor};
    NSRange linkRange = [text rangeOfString:@"《使用协议》"];
    [readLabel addLinkToURL:[NSURL URLWithString:@""] withRange:linkRange];
    CFRelease(ctFont);
    [self.view addSubview:readLabel];
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
    } else {
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
        
    }
    return backView;
}

- (void)codeButtonClick {
    
}

- (void)leftButtonAction {
    
    if (self.navigationController.viewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [super leftButtonAction];
    }
}

- (void)registerButtonClick {
    
    if (!_phoneTextField.text.length) {
        [AppBaseHud showHudWithfail:@"请输入手机号" view:self.view];
        return;
    }
    
    if (!_passwordTextField.text.length) {
        [AppBaseHud showHudWithfail:@"请输入密码" view:self.view];
        return;
    }
    
    if (!_nameTextField.text.length) {
        [AppBaseHud showHudWithfail:@"请输入昵称" view:self.view];
        return;
    }
    
    if (!_codeTextField.text.length) {
        [AppBaseHud showHudWithfail:@"请输入手机验证码" view:self.view];
        return;
    }
    
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [UserDao userRegister:_phoneTextField.text
                 password:[_passwordTextField.text md5HexDigest]
                     name:_nameTextField.text
                     code:_codeTextField.text
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


@end
