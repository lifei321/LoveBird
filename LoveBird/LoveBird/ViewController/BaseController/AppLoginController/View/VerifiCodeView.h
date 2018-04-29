//
//  VerifiCodeView.h
//  loan
//
//  Created by zhuayi on 15/11/10.
//  Copyright © 2015年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppButton.h"
#import "AppTextField.h"
#import "AppBaseModel.h"

@protocol VerifiCodeViewDelegate <NSObject>

/**
 *  点击 button 后回调
 *
 */
- (NSString *)didClickButton:(AppButton *)button;

/**
 *  发送验证码失败
 *
 */
- (void)didSendSmsCodeSuccess:(NSString *)smsCode;

/**
 *  发送验证码成功
 *
 */
- (void)didSendSmsCodeFailure:(NSError *)error;

@end

@interface VerifiCodeView : UIView<UITextFieldDelegate>


@property (nonatomic, weak) id<VerifiCodeViewDelegate> delegate;

@property (nonatomic, strong) AppButton *verifiButton;

@property (nonatomic, strong) AppTextField *verifiCode;


/**
 *  发送过来的验证码
 */
@property (nonatomic, strong) NSString *smsCode;

/**
 *  是否透明
 */
@property (nonatomic, assign) BOOL isTransparent;


/**
 *  拉取验证码
 *
 */
- (void)pullVerifiCode;

/**
 *  第一次拉取验证码,只是显示,并不真正拉取
 *
 */
- (void)pullVerifiCodeFirstNoSendSMS;
@end
