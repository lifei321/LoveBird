//
//  passwordTextField.m
//  loan
//
//  Created by zhuayi on 15/11/10.
//  Copyright © 2015年 renxin. All rights reserved.
//

#import "PasswordTextField.h"

@implementation PasswordTextField


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.placeholder = @"登录密码";
        self.secureTextEntry = YES;
        
        self.isTransparent = YES;
        
        self.limitLenght = 16;
                
        __weak typeof(self) weakSelf = self;
        self.delegate = weakSelf;
        
    }
    return self;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location == 0 && [string isBlankString]) {
        self.rightViewMode = UITextFieldViewModeWhileEditing;
    } else {
        self.rightViewMode = UITextFieldViewModeWhileEditing;
    }
    return YES;
}

@end
