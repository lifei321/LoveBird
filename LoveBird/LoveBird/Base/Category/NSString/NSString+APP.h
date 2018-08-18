//
//  NSString+APP.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (APP)

/**
 * 求单行字的宽度
 */
- (CGFloat)getTextWightWithFont:(UIFont *)font;

/**
 * 求多行字在指定宽度下的高度
 */
- (CGFloat)getTextHeightWithFont:(UIFont *)font withWidth:(CGFloat)width;

- (CGFloat)getTextHeightWithFont:(UIFont *)font withWidth:(CGFloat)width att:(NSMutableParagraphStyle *)att;


//根据最大宽度 返回尺寸
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

//根据字体 返回lable的尺寸
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 *  判断文件是否已经在沙盒中已经存在？
 *
 */
- (BOOL)isFileExist;

/**
 *  计算当前文件\文件夹的内容大小
 */
- (NSInteger)fileSize;

/**
 *  文件名转 doc 目录路径
 *
 */
- (NSString *)fileNameToPath;

/**
 *  获取长度
 */
- (NSUInteger)getStrlength;


@end
