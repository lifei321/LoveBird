//
//  FeedBackViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "FeedBackViewController.h"

#import "AppPlaceHolderTextView.h"
#import "AppTextField.h"
#import "AppButton.h"

@interface FeedBackViewController ()<UITextViewDelegate>

@property (nonatomic, strong) AppPlaceHolderTextView *inputField;


@property (strong, nonatomic) AppTextField *contactField;


@end

@implementation FeedBackViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"意见反馈";
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self creatTextView];
    
    [self creatFooterView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)creatTextView {
    
    self.inputField = [[AppPlaceHolderTextView alloc] initWithFrame:CGRectMake(AutoSize(10), AutoSize(10) + total_topView_height, SCREEN_WIDTH - AutoSize(20), AutoSize(115))];
    self.inputField.returnKeyType = UIReturnKeyNext;
    self.inputField.delegate = (id<UITextViewDelegate>)self;
    [self.view addSubview:self.inputField];
    
    self.contactField = [[AppTextField alloc] initWithFrame:CGRectMake(AutoSize(10), self.inputField.bottom + AutoSize(20), SCREEN_WIDTH - AutoSize(20), AutoSize(35))];
    self.contactField.backgroundColor = [UIColor whiteColor];
    self.contactField.font = [UIFont systemFontOfSize:AutoSize(12)];
    self.contactField.placeholder = @"请写下您的联系方式 QQ/手机/邮箱";
    self.contactField.returnKeyType = UIReturnKeyNext;
    self.contactField.borderStyle = UITextBorderStyleNone;
    
    UIView *leftview = [[UIView alloc] initWithFrame:self.contactField.frame];
    leftview.width = AutoSize(5.0);
    self.contactField.leftViewMode = UITextFieldViewModeAlways;
    self.contactField.leftView = leftview;
    [self.view addSubview:self.contactField];
}

- (void)creatFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contactField.bottom + AutoSize(18), SCREEN_WIDTH, AutoSize(49))];
    
    [self.view addSubview:footerView];
    
    AppButton *submitButton = [[AppButton alloc] initWithFrame:CGRectMake(0, 0, AutoSize(300), AutoSize(39)) style:AppButtonStyleYellow];
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [submitButton setAlignmentCenterWithSuperview:footerView];
    [submitButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:submitButton];
}


- (void)submitButtonPressed:(UIButton *)btn {
    
    [self hideKeyboard];
    
    if (!self.inputField.text.length) {
        [AppBaseHud showHudWithfail:@"请填写意见" view:self.view];
        return;
    } else if (self.inputField.text.length > self.inputField.limitCount) {
        [AppBaseHud showHudWithfail:@"您输入的字数已经超出范围" view:self.view];
        return;
    }
}

#pragma mark - 判断字数

- (void)textViewDidChange:(UITextView *)textView
{
    
}





@end
