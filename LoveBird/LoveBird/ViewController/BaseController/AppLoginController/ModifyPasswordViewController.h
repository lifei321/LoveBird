//
//  ModifyPasswordViewController.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/12.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseViewController.h"
#import "VerifiCodeView.h"


@interface ModifyPasswordViewController : AppBaseViewController <VerifiCodeViewDelegate>


/**
 *  手机号
 */
@property (nonatomic, strong) NSString *mobile;


/**
 *  验证码
 */
@property (nonatomic, strong) NSString *smsCode;


@end
