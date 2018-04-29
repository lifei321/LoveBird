//
//  VerifiCodeView.m
//  loan
//
//  Created by zhuayi on 15/11/10.
//  Copyright © 2015年 renxin. All rights reserved.
//

#import "VerifiCodeView.h"

#define kInitialTimingNumber 60;

@implementation VerifiCodeView {
    
    int _timingNumber;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _verifiCode = [[AppTextField alloc] initWithFrame:CGRectMake(0, 0, AutoSize(205), self.height)];
        _verifiCode.placeholder = @"请输入验证码";
        _verifiCode.keyboardType = UIKeyboardTypeDefault;
        [self addSubview:_verifiCode];
        _verifiCode.isTransparent = YES;
        
//        UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, AutoSize(17), AutoSize(17))];
//        [clearButton setBackgroundImage:[UIImage imageNamed:@"clearbutton"] forState:UIControlStateNormal];
//        [clearButton setBackgroundImage:[UIImage imageNamed:@"clearbutton_high"] forState:UIControlStateHighlighted];
//        _verifiCode.rightView = clearButton;
//        _verifiCode.rightViewMode = UITextFieldViewModeWhileEditing;
//        [clearButton addTarget:self action:@selector(clearTextFile) forControlEvents:UIControlEventTouchUpInside];
        
        _verifiButton = [[AppButton alloc] initWithFrame:CGRectMake(self.width - AutoSize(95), 0, AutoSize(95), self.height) style:AppButtonStyleNone];
        [_verifiButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifiButton setTitleColor:UIColorFromRGB(0xf48f45) forState:UIControlStateNormal];
        [_verifiButton setTitleColor:UIColorFromRGB(0xdcdcdc) forState:UIControlStateDisabled];
        _verifiButton.titleLabel.font = kFont(13.5);
        _verifiButton.backgroundColor = [UIColor clearColor];
        _verifiButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [self addSubview:_verifiButton];
                
        _verifiCode.width = self.width - _verifiButton.width - 10;
        
        [_verifiButton addTarget:self action:@selector(pullVerifiCode) forControlEvents:UIControlEventTouchUpInside];
        
        _timingNumber = kInitialTimingNumber;
    }
    return self;
}

- (void)setIsTransparent:(BOOL)isTransparent {
    _isTransparent = isTransparent;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, kLoginDefaultPlaceholderColor.CGColor);
    if (_isTransparent) {
        
        _verifiCode.isTransparent = NO;
        _verifiCode.borderStyle = UITextBorderStyleNone;
        
        // 底部划线
        CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
        
        CGContextFillRect(context, CGRectMake(_verifiButton.left, CGRectGetHeight(self.frame) * 0.2, 0.5, CGRectGetHeight(self.frame) * 0.6));
    }
    
    //验证码左侧划线
    CGContextFillRect(context, CGRectMake(_verifiButton.left, CGRectGetHeight(self.frame) * 0.2, 0.5, CGRectGetHeight(self.frame) * 0.6));
}


/**
 *  替换文本
 */
- (void)replaceButton {
    if (_timingNumber < 0) {
        
        _timingNumber = kInitialTimingNumber;
        [_verifiButton setTitle:[NSString stringWithFormat:@"(%d)重新发送", _timingNumber] forState:UIControlStateDisabled];
        _verifiButton.enabled = YES;
        return;
    }
    [_verifiButton setTitle:[NSString stringWithFormat:@"(%d)重新发送", _timingNumber] forState:UIControlStateDisabled];
    _timingNumber--;
    
    __weak typeof(self) weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        
        [weakSelf replaceButton];
    });

}

/**
 *  第一次拉取验证码,只是显示,并不真正拉取
 */
- (void)pullVerifiCodeFirstNoSendSMS {
    _verifiButton.enabled = NO;
    [_delegate didClickButton:_verifiButton];
    [self replaceButton];
}

/**
 *  拉取验证码
 *
 */
- (void)pullVerifiCode {
    
    _verifiButton.enabled = NO;
    NSString *mobile = [_delegate didClickButton:_verifiButton];
    [self replaceButton];
    [self getsms:mobile];
    NSLog(@"mobile is %@", mobile);
}

- (void)getsms:(NSString *)mobile {
//    [UserDao sendMobile:mobile successBlock:^(LoanBaseModel *responseObject) {
//        
//        NSLog(@"responseObject is %@", responseObject);
//        
//        [_delegate didSendSmsCodeSuccess:responseObject.errstr];
//        
//    } failure:^(NSError *error, LoanBaseModel *responseObject) {
//        
//        [_delegate didSendSmsCodeFailure:error];
//    }];

}

/**
 *  情况输入框
 */
- (void)clearTextFile {
    
    _verifiCode.text = @"";
    
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

@end
