//
//  LoginViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/10.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "LoginViewController.h"
#import "AppTextField.h"
#import "IQUITextFieldView+Additions.h"
#import "TTTAttributedLabel.h"
#import "AppButton.h"
#import "PhoneTextField.h"
#import "PasswordTextField.h"
#import "UIDevice+LFAddition.h"
#import "RegViewController.h"
#import "UserDao.h"
#import "ResetWordController.h"
#import "RegisterModel.h"


@interface LoginViewController ()<UITextFieldDelegate,TTTAttributedLabelDelegate>

@property (nonatomic, strong) PasswordTextField *passwordTextField;

@property (nonatomic, strong) AppTextField *phoneTextField;


@end

@implementation LoginViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;
    
    // 背景
    [self creatBackGround];
    
    //白方块内容
    [self creatInputView];
    
    // 第三方登录
    [self creatThirdLogin];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;
}

- (void)creatBackGround {
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImageView.backgroundColor = kColorTarBarTitleHighlightColor;
    [self.view addSubview:backImageView];
}

- (void)creatInputView {
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize(25), AutoSize(48), self.view.width - AutoSize(50), AutoSize(360))];
    inputView.backgroundColor = [UIColor whiteColor];
    inputView.layer.cornerRadius = 5;
    
    // 关闭按钮
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(inputView.width - AutoSize(33), AutoSize(13), AutoSize(20), AutoSize(20))];
    [closeButton setImage:[UIImage imageNamed:@"close_login"] forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"close_login"] forState:UIControlStateHighlighted];
    [closeButton addTarget:self action:@selector(closeButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:closeButton];
    
    //logo图标
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize(20), AutoSize6(70), AutoSize6(220), AutoSize6(84))];
    logo.image = [UIImage imageNamed:@"log_icon"];
    [inputView addSubview:logo];
    
    //提示语句
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize(22), logo.bottom + AutoSize(5), inputView.width, AutoSize(20))];
    tipLabel.text = @"佳友在线用户可直接登录爱鸟网";
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.textColor = kColorTextColorLightGraya2a2a2;
    tipLabel.font = kFont(11);
    [inputView addSubview:tipLabel];
    tipLabel.width = [tipLabel.text getTextWightWithFont:tipLabel.font];

    //问好
    UIButton *questionButton = [[UIButton alloc] initWithFrame:CGRectMake(tipLabel.right - AutoSize(5), tipLabel.top - AutoSize(3), tipLabel.height + AutoSize(6), tipLabel.height + AutoSize(6))];
    [questionButton setImage:[UIImage imageNamed:@"question"] forState:UIControlStateNormal];
    [questionButton setImage:[UIImage imageNamed:@"question"] forState:UIControlStateHighlighted];
    [questionButton addTarget:self action:@selector(questionButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:questionButton];
    
    //账号输入框
    UIView *phoneView = [self makeTextBackViewWithImage:@"phone"
                                                  frame:CGRectMake(0, tipLabel.bottom + AutoSize(25), inputView.width, AutoSize(44))
                                            placeHolder:@"请输入用户名/手机号"
                                                 isShow:NO];
    [inputView addSubview:phoneView];
    
    UIView *linePhone = [[UIView alloc] initWithFrame:CGRectMake(AutoSize(13), phoneView.bottom, inputView.width - AutoSize(26), 0.5)];
    linePhone.backgroundColor = kColorTarBarTitleHighlightColor;
    [inputView addSubview:linePhone];
    
    //密码
    UIView *passWordView = [self makeTextBackViewWithImage:@"lock"
                                                     frame:CGRectMake(0, linePhone.bottom , inputView.width, AutoSize(44))
                                               placeHolder:@"请输入密码"
                                                    isShow:YES];
    [inputView addSubview:passWordView];
    
    UIView *linePass = [[UIView alloc] initWithFrame:CGRectMake(AutoSize(13), passWordView.bottom, inputView.width - AutoSize(26), 0.5)];
    linePass.backgroundColor = kLineColoreLightGrayECECEC;
    [inputView addSubview:linePass];
    
    // 免费注册
    UIButton *registButton = [[UIButton alloc] initWithFrame:CGRectMake(AutoSize(13), linePass.bottom + AutoSize(10), AutoSize(60), AutoSize(30))];
    [registButton setTitle:@"立即注册" forState: UIControlStateNormal];
    [registButton setTitleColor:kColorDefaultColor forState:UIControlStateNormal];
    registButton.titleLabel.font = kFont(12);
    [registButton addTarget:self action:@selector(gotoRegist) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:registButton];
    
    // 忘记密码
    UIButton *forgetButton = [[UIButton alloc] initWithFrame:CGRectMake(inputView.width - AutoSize(73), registButton.top, AutoSize(60), AutoSize(30))];
    [forgetButton setTitle:@"忘记密码？" forState: UIControlStateNormal];
    [forgetButton setTitleColor:kColorTextColorLightGraya2a2a2 forState:UIControlStateNormal];
    forgetButton.titleLabel.font = kFont(12);
    [forgetButton addTarget:self action:@selector(goToModifyPassword) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:forgetButton];
    
    // 登录按钮
    AppButton *submitButton = [[AppButton alloc] initWithFrame:CGRectMake(AutoSize(22), registButton.bottom + AutoSize(20), inputView.width - AutoSize(44), AutoSize(35)) style:AppButtonStyleDefault];
    submitButton.layer.cornerRadius = AutoSize(5);
    submitButton.titleLabel.font = kFont(15);
    [submitButton setTitle:@"登录" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(goToLogin) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:submitButton];
    
    // 使用协议
    TTTAttributedLabel *readLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, submitButton.bottom + AutoSize(20), inputView.width, AutoSize(15))];
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
    [inputView addSubview:readLabel];
    
    [self.view addSubview:inputView];
}


- (UIView *)makeTextBackViewWithImage:(NSString *)image
                                frame:(CGRect)frame
                          placeHolder:(NSString *)placeHolder
                               isShow:(BOOL)isShow {
    
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize(15), (frame.size.height - AutoSize(20)) / 2, AutoSize(20), AutoSize(20))];
    icon.contentMode = UIViewContentModeCenter;
    icon.image = [UIImage imageNamed:image];
    [backView addSubview:icon];
    
    if (isShow) {
        PasswordTextField *textField = [[PasswordTextField alloc] initWithFrame:CGRectMake(icon.right + AutoSize(13), 0, frame.size.width - icon.right - AutoSize(40), frame.size.height)];
        textField.placeholder = placeHolder;
        textField.textColor = [UIColor blackColor];
        textField.secureTextEntry = NO;
        textField.font = kFont(14);
        [backView addSubview:textField];
        
        UIButton *seeButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - AutoSize(33), icon.top, icon.width, icon.height)];
        [seeButton setImage:[UIImage imageNamed:@"open_eyes"] forState:UIControlStateNormal];
        [seeButton setImage:[UIImage imageNamed:@"close_eyes"] forState:UIControlStateSelected];
        [seeButton addTarget:self action:@selector(seeButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:seeButton];
        self.passwordTextField = textField;
    } else {
        AppTextField *phoneTextField = [[AppTextField alloc] initWithFrame:CGRectMake(icon.right + AutoSize(13), 0, frame.size.width - icon.right - AutoSize(26), frame.size.height)];
        phoneTextField.placeholder = placeHolder;
        phoneTextField.textColor = [UIColor blackColor];
        phoneTextField.font = kFont(14);
        [backView addSubview:phoneTextField];
        phoneTextField.isTransparent = YES;
        self.phoneTextField = phoneTextField;
    }
    return backView;
}


// 第三方登录
- (void)creatThirdLogin {
    
    //提示语
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, AutoSize(408) + AutoSize(20), self.view.width, AutoSize(15))];
    tipLabel.text = @"您还可以用以下方式登录";
    tipLabel.font = kFont(12);
    tipLabel.textColor = [UIColor whiteColor];
    CGFloat width = [tipLabel.text getTextWightWithFont:tipLabel.font];
    tipLabel.left = (self.view.width - width) / 2;
    tipLabel.width = width;
    [self.view addSubview:tipLabel];
    
    // 横线
    UIView *lineLeft = [[UIView alloc] init];
    lineLeft.backgroundColor = [UIColor whiteColor];
    lineLeft.centerY = tipLabel.centerY;
    lineLeft.width = AutoSize(51);
    lineLeft.height = 1;
    lineLeft.right = tipLabel.left - AutoSize(5);
    [self.view addSubview:lineLeft];
    
    UIView *lineRight = [[UIView alloc] init];
    lineRight.backgroundColor = [UIColor whiteColor];
    lineRight.centerY = tipLabel.centerY;
    lineRight.width = AutoSize(51);
    lineRight.height = 1;
    lineRight.left = tipLabel.right + AutoSize(5);
    [self.view addSubview:lineRight];
    
    // 第三方登录按钮
    UIView * thirdView = [self makeThirdViewWithFrame:CGRectMake(0, tipLabel.bottom + AutoSize(25), self.view.width, AutoSize(48))];
    [self.view addSubview:thirdView];
}

- (UIView *)makeThirdViewWithFrame:(CGRect)frame {
    
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    
    CGFloat space = AutoSize(49);
    CGFloat width = frame.size.height;
    CGFloat x = (self.view.width - width * 3 - space * 2) / 2;
    
    UIButton *wechat = [self makeButton:@"weixin" frame:CGRectMake(x, 0, width, width) tag:1000];
    UIButton *qq = [self makeButton:@"qq" frame:CGRectMake(wechat.right + space, 0, width, width) tag:1001];
    UIButton *weibo = [self makeButton:@"weibo" frame:CGRectMake(qq.right + space, 0, width, width) tag:1002];

    [backView addSubview:wechat];
    [backView addSubview:qq];
    [backView addSubview:weibo];
    return backView;
}

- (UIButton *)makeButton:(NSString *)image frame:(CGRect)frame tag:(NSInteger)tag {
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.tag = tag;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(thirdLoginDidClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark- 关闭按钮点击

- (void)closeButtonDidClick {
    [self hideKeyboard];
    
    if (self.isModal) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark- 爱鸟网问题

- (void)questionButtonDidClick {
    
}

#pragma mark- 密码是否可见

- (void)seeButtonDidClick:(UIButton *)button {
    if (button.selected) {
        button.selected = NO;
        self.passwordTextField.secureTextEntry = NO;
    } else {
        button.selected = YES;
        self.passwordTextField.secureTextEntry = YES;
    }
}

#pragma mark- 登录

- (void)goToLogin {
    [self hideKeyboard];
    
    if ([EMPTY_STRING_IF_NIL(self.phoneTextField.text) isBlankString]) {
        [AppBaseHud showHudWithfail:@"请输入用户名/手机号" view:self.view];
        return;
    }
    
    if ([EMPTY_STRING_IF_NIL(self.passwordTextField.text) isBlankString]) {
        [AppBaseHud showHudWithfail:@"请输入密码" view:self.view];
        return;
    }
    
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [UserDao userLogin:_phoneTextField.text
                 password:[_passwordTextField.text md5HexDigest]
             SuccessBlock:^(__kindof AppBaseModel *responseObject) {
                 @strongify(self);
                 [AppBaseHud hideHud:self.view];
                 RegisterDataModel *dataModel = (RegisterDataModel *)responseObject;
                 [UserPage sharedInstance].userModel.token = dataModel.userInfo.token;
                 [UserPage sharedInstance].userModel.uid = dataModel.userInfo.uid;
                 
                 if (self.viewControllerActionBlock) {
                     self.viewControllerActionBlock(self, nil);
                 }
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessNotification object:nil];
                 [self dismissViewControllerAnimated:YES completion:nil];
                 
             } failureBlock:^(__kindof AppBaseModel *error) {
                 @strongify(self);
                 [AppBaseHud showHudWithfail:error.errstr view:self.view];
             }];
}

#pragma mark-- 去注册

- (void)gotoRegist {
    [self hideKeyboard];
    
    RegViewController *modifyPassword = [[RegViewController alloc] init];
    modifyPassword.controllerType = RegViewControllerTypeReg;
    [self.navigationController pushViewController:modifyPassword animated:YES];
}

#pragma mark-  找回密码

- (void)goToModifyPassword {
    [self hideKeyboard];

    ResetWordController *modifyPassword = [[ResetWordController alloc] init];
    modifyPassword.type = @"1";
    [self.navigationController pushViewController:modifyPassword animated:YES];
}

#pragma mark- 第三方登录
- (void)thirdLoginDidClick:(UIButton *)button {
    
    
}


#pragma mark- TTTAttributedLabelDelegate
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url {
    [self hideKeyboard];
    
}

@end
