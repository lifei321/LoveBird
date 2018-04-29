//
//  NSString+Validate.h
//  LoveBird
//
//  Created by ShanCheli on 2017/11/17.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)

/**
 *  身份证有效日期校验
 *  2010.11.11-2020.11.11 或2010.11.11-长期
 */
- (BOOL)validateIdentityDate;


//判断字符串是不是中文
-(BOOL)isChinese;

/**
 *  判断字符串是否为空
 */
- (BOOL)isBlankString;

/**
 *  MD5加密
 */
- (NSString *)md5HexDigest;

/**
 *  验证身份证号码
 */
- (BOOL)checkUserIdCard;

/**
 *  邮箱
 */
- (BOOL)validateEmail;

/**
 *  手机号码验证
 */
- (BOOL)validateMobile;

/**
 *  用户名
 */
- (BOOL)validateUserName;

/**
 *  密码校验
 */
- (BOOL)validatePassword;

/**
 *  验证昵称
 */
- (BOOL)validateNickname;

/**
 *  验证纯数组
 */
- (BOOL)validateNumber;

/**
 *  身份证号验证
 */
- (BOOL)validateIdentityCard;

/**
 *  隐藏中间四位手机号
 */
- (NSString *)hideMobile;

/**
 *  银行卡号转正常号 － 去除4位间的空格
 */
-(NSString *)bankNumToNormalNum;


/**
 *  正常号转银行卡号 － 增加4位间的空格
 */
-(NSString *)normalNumToBankNum;

/**
 *  时间戳转换到固定格式的时间
 */
- (NSString *)timeToStringWithFormatter:(NSDateFormatter *)formatter ;

///DES 解密
+ (NSString *)DecryptWithText:(NSString *)plainText key:(NSString *)key;

//中文URLEncode
- (NSString *)URLEncodedString;

@end
