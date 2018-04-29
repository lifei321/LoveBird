//
//  RegInfoViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/12.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "RegInfoViewController.h"
#import "PasswordTextField.h"
#import "VerifiCodeView.h"
#import "TTTAttributedLabel.h"
#import "AppBaseCellModel.h"
#import "RegInfoTableViewCell.h"

@interface RegInfoViewController ()<VerifiCodeViewDelegate, TTTAttributedLabelDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) PasswordTextField *passwordText;

@end

@implementation RegInfoViewController {
    
    VerifiCodeView *_verifiCodeView;
    
    // 邀请人手机号
    AppTextField *_inviterMobile;
    
    // 密码确认
    PasswordTextField *_confirmPasswordText;
    
    // 协议确定button
    UIButton *_protocolButton;
    
    // 是否第一次发送验证码
    BOOL _isFirstSendCode;
    
    // 用户昵称
    AppTextField *_nickname;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    //statusbar颜色
    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
    
    //标题颜色
    [self wr_setNavBarTitleColor:[UIColor blackColor]];
    
    [self wr_setNavBarBackgroundAlpha:0];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.height = SCREEN_HEIGHT;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerClass:[RegInfoTableViewCell class] forCellReuseIdentifier:NSStringFromClass([RegInfoTableViewCell class]) dataSource:nil];
    
    
    NSMutableArray *tableListArray = [NSMutableArray arrayWithArray:@[[NSMutableArray new]]];
    
    //验证码
    _verifiCodeView = [[VerifiCodeView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - AutoSize(248)) / 2, 0, AutoSize(248), AutoSize(35))];
    _verifiCodeView.verifiCode.textColor = kColorTextColor3c3c3c;
    _verifiCodeView.verifiCode.placeholder = @"请输入验证码";
    _verifiCodeView.verifiCode.font = kFont(13.5);
    [_verifiCodeView.verifiCode setValue:kColorTextColorA1A1A1 forKeyPath:@"_placeholderLabel.textColor"];
    [_verifiCodeView.verifiButton setTitleColor:kColorNavigationBar forState:UIControlStateNormal];
    [_verifiCodeView.verifiButton setTitleColor:kColorTextColorA1A1A1 forState:UIControlStateDisabled];
    _verifiCodeView.delegate = self;
    [_verifiCodeView setAlignmentCenterWithSuperview:self.view];
    _verifiCodeView.isTransparent = YES;
    [_verifiCodeView pullVerifiCodeFirstNoSendSMS];
    AppBaseCellModel *cellModel0 = [[AppBaseCellModel alloc] init];
    cellModel0.leftView = _verifiCodeView;
    [tableListArray[0] addObject:cellModel0];
    
    _passwordText = [[PasswordTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - AutoSize(248)) / 2, 0, AutoSize(248), AutoSize(35))];
    [_passwordText setAlignmentCenterWithSuperview:self.view];
    _passwordText.placeholder = @"登录密码,区分大小写，6-16位字符";
    _passwordText.textColor = kColorTextColor3c3c3c;
    _passwordText.font = kFont(13.5);
    [_passwordText setValue:kColorTextColorA1A1A1 forKeyPath:@"_placeholderLabel.textColor"];
    _passwordText.limitLenght = 16;
    AppBaseCellModel *cellModel1 = [[AppBaseCellModel alloc] init];
    cellModel1.leftView = _passwordText;
    [tableListArray[0] addObject:cellModel1];
    
    _confirmPasswordText = [[PasswordTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - AutoSize(248)) / 2, 0, AutoSize(248), AutoSize(35))];
    [_confirmPasswordText setAlignmentCenterWithSuperview:self.view];
    _confirmPasswordText.placeholder = @"确认登录密码";
    _confirmPasswordText.font = kFont(13.5);
    _confirmPasswordText.textColor = kColorTextColor3c3c3c;
    [_confirmPasswordText setValue:kColorTextColorA1A1A1 forKeyPath:@"_placeholderLabel.textColor"];
    _confirmPasswordText.limitLenght = 16;
    AppBaseCellModel *cellModel2 = [[AppBaseCellModel alloc] init];
    cellModel2.leftView = _confirmPasswordText;
    [tableListArray[0] addObject:cellModel2];
    
    _nickname = [[AppTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - AutoSize(248)) / 2, 0, AutoSize(248), AutoSize(35))];
    [_nickname setAlignmentCenterWithSuperview:self.view];
    _nickname.placeholder = @"请设置昵称";
    _nickname.font = kFont(13.5);
    _nickname.textColor = kColorTextColor3c3c3c;
    [_nickname setValue:kColorTextColorA1A1A1 forKeyPath:@"_placeholderLabel.textColor"];
    _nickname.isTransparent = YES;
    AppBaseCellModel *cellModel3 = [[AppBaseCellModel alloc] init];
    cellModel3.leftView = _nickname;
    [tableListArray[0] addObject:cellModel3];
    
    _inviterMobile = [[AppTextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - AutoSize(248)) / 2, 0, AutoSize(248), AutoSize(35))];
    [_inviterMobile setAlignmentCenterWithSuperview:self.view];
    _inviterMobile.placeholder = @"（选填）邀请人手机号或邀请码";
    _inviterMobile.textColor = kColorTextColor3c3c3c;
    _inviterMobile.font = kFont(13.5);
    [_inviterMobile setValue:kColorTextColorA1A1A1 forKeyPath:@"_placeholderLabel.textColor"];
    _inviterMobile.text = self.inviterCode;
    _inviterMobile.isTransparent = YES;
    _inviterMobile.keyboardType = UIKeyboardTypeNumberPad;
    AppBaseCellModel *cellModel4 = [[AppBaseCellModel alloc] init];
    cellModel4.leftView = _inviterMobile;
    [tableListArray[0] addObject:cellModel4];
    
    if (self.inviterCode.length > 0) {
        UIView *viewProtocol = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - AutoSize(248)) / 2, 0, AutoSize(248), AutoSize(25))];
        
        UILabel *protocolTips = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_protocolButton.frame) + 5, 0, AutoSize(100), AutoSize(25))];
        protocolTips.text = @"亲，已有朋友邀请您加入啦";
        protocolTips.font = kFont(11);
        protocolTips.textColor = [UIColor blackColor];
        [protocolTips sizeToFit];
        [viewProtocol addSubview:protocolTips];
        
        _protocolButton = [[UIButton alloc] initWithFrame:CGRectMake(protocolTips.right+AutoSize(3), AutoSize(3), AutoSize(11), AutoSize(11))];
        [_protocolButton setBackgroundImage:[UIImage imageNamed:@"icon_info_blue"] forState:UIControlStateNormal];
        _protocolButton.centerY = protocolTips.centerY;
        
        [_protocolButton addTarget:self action:@selector(protocolButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _protocolButton.selected = YES;
        [viewProtocol addSubview:_protocolButton];
        
        AppBaseCellModel *cellModel5 = [[AppBaseCellModel alloc] init];
        cellModel5.leftView = viewProtocol;
        [tableListArray[0] addObject:cellModel5];
    }
    [self addFootViewWithButton:@"完成" addTarget:self action:@selector(goToReg) buttonStyle:AppButtonStyleYellow];
    
    self.dataSourceArray = [NSArray arrayWithArray:tableListArray];
    [self.tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count == 1) {
        self.leftButton.image = [UIImage imageNamed:@"nav_close_black"];
    }
    
    //隐藏
    [self wr_setNavBarBackgroundAlpha:0];
}



- (void)addFootViewWithButton:(NSString *)buttonText addTarget:(id)target action:(SEL)action buttonStyle:(AppButtonStyle)buttonStyle {
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize(101))];
    footerView.userInteractionEnabled = YES;
    AppButton *logoutButton = [[AppButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - AutoSize(248)) / 2, AutoSize(20), AutoSize(248), AutoSize(40)) style:buttonStyle];
    logoutButton.layer.cornerRadius = AutoSize(20);
    logoutButton.titleLabel.font = kFontSysBold(15);
    [logoutButton setTitle:buttonText forState:UIControlStateNormal];
    [logoutButton setAlignmentCenterWithSuperview:footerView];
    [footerView addSubview:logoutButton];
    
    if (action != nil) {
        [logoutButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *viewProtocol = [[UIView alloc] initWithFrame:CGRectMake(0, logoutButton.bottom + AutoSize(16), AutoSize(248), AutoSize(25))];
    viewProtocol.userInteractionEnabled = YES;
    
    TTTAttributedLabel *protocolText = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, self.view.width, AutoSize(12))];
    NSString *text = @"点【完成】即视为您同意《小赢成单用户注册协议》";
    UIFont *font = kFont(12);
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    [protocolText setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)ctFont range:NSMakeRange(0, [text length])];
        return  mutableAttributedString;
    }];
    protocolText.textAlignment = NSTextAlignmentCenter;
    protocolText.delegate = self;
    protocolText.linkAttributes = @{(NSString *)kCTFontAttributeName:(__bridge id)ctFont,(id)kCTForegroundColorAttributeName:kColorNavigationBar};
    NSRange linkRange = [text rangeOfString:@"《小赢成单用户注册协议》"];
    [protocolText addLinkToURL:[NSURL URLWithString:@""] withRange:linkRange];
    [viewProtocol addSubview:protocolText];
    [footerView addSubview:viewProtocol];
    CFRelease(ctFont);
    self.tableView.tableFooterView = footerView;
    
}

#pragma mark-- 注册

- (void)goToReg {
    [self hideKeyboard];
    
    if ([EMPTY_STRING_IF_NIL(_verifiCodeView.verifiCode.text) isBlankString]) {
        
        [AppBaseHud showHudWithfail:@"请输入验证码" view:self.view];
        return ;
    }
    
    if (_verifiCodeView.verifiCode.text.length < 6) {
        
        [AppBaseHud showHudWithfail:@"请输入6位数验证码" view:self.view];
        return ;
    }
    
    if ([EMPTY_STRING_IF_NIL(_passwordText.text) isBlankString]) {
        
        [AppBaseHud showHudWithfail:@"请输入登录密码" view:self.view];
        return;
    }
    
    if (_passwordText.text.length < 6 || _passwordText.text.length > 16) {
        
        [AppBaseHud showHudWithfail:@"密码必须为长度6-16位数字、字母组合" view:self.view];
        return;
    }
    
    if ([EMPTY_STRING_IF_NIL(_confirmPasswordText.text) isBlankString]) {
        
        [AppBaseHud showHudWithfail:@"请再次输入登录密码" view:self.view];
        return;
    }
    
    if (![_passwordText.text isEqualToString:_confirmPasswordText.text]) {
        
        [AppBaseHud showHudWithfail:@"两次密码不一致，请重新输入" view:self.view];
        return;
    }
    
    if ([EMPTY_STRING_IF_NIL(_nickname.text) isBlankString]) {
        
        [AppBaseHud showHudWithfail:@"请设置昵称" view:self.view];
        return;
    }
    
    //先判断长度
    if ([_nickname.text getStrlength] < 4 || [_nickname.text getStrlength] > 20) {
        
        [AppBaseHud showHudWithfail:@"用户昵称限长2-10个字符" view:self.view];
        return;
    }
    
    if ([_nickname.text validateNickname] == NO) {
        [AppBaseHud showHudWithfail:@"昵称只能由中文、字母或数字组成" view:self.view];
        return;
    }
    
    if ([_nickname.text validateNumber]) {
        [AppBaseHud showHudWithfail:@"昵称不支持纯数字" view:self.view];
        return;
    }
    
    if (_protocolButton) {
        if (_protocolButton.selected == NO) {
            [AppBaseHud showHudWithfail:@"请先阅读用户使用协议" view:self.view];
            return;
        }
    }
}

#pragma mark - Actions
- (void)protocolButtonAction:(UIButton *)sender {
    [AppAlertView simpleAlertWithTitle:nil message:@"您已通过成单的活动建立了邀请关系哦，详情可咨询客服" onDismiss:nil];
}

/**
 *  用户协议（本地）
 *
 */
- (void)protocolUserTipsTapped:(UITapGestureRecognizer *)gesture{
    AppWebViewController *vc = [AppWebViewController new];
    vc.startupUrlString = @"";
    _protocolButton.selected = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url {
    AppWebViewController *vc = [AppWebViewController new];
    vc.startupUrlString = @"";
    _protocolButton.selected = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark VerifiCodeViewDelegate

- (NSString *)didClickButton:(AppButton *)button {
    
    return [_phoneText.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

- (void)didSendSmsCodeSuccess:(NSString *)smsCode {
    
    
    NSLog(@"发送验证码....%@", smsCode);
}

- (void)didSendSmsCodeFailure:(NSError *)error {
    
    NSLog(@"发送验证码....%@", error);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 5) {
        return AutoSize(0);
    }
    return AutoSize(45);

}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.dataSourceArray.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [self.dataSourceArray[section] count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//
//}

#pragma mark--- tableview代理
@end
