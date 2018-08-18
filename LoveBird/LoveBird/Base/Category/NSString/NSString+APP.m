//
//  NSString+APP.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "NSString+APP.h"


@implementation NSString (APP)

/**
 * 求单行字的宽度
 */
- (CGFloat)getTextWightWithFont:(UIFont *)font {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(1000, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
}

/**
 * 求多行字在指定宽度下的高度
 */
- (CGFloat)getTextHeightWithFont:(UIFont *)font withWidth:(CGFloat)width {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size.height;
}


- (CGFloat)getTextHeightWithFont:(UIFont *)font withWidth:(CGFloat)width att:(NSMutableParagraphStyle *)att {
    

    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:@{NSFontAttributeName:font,
                                                                                      NSParagraphStyleAttributeName:att.copy}];
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return rect.size.height;
}

/**
 *  判断文件是否已经在沙盒中已经存在？
 *
 */
- (BOOL)isFileExist {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:[self fileNameToPath]];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}

/**
 *  文件名转 doc 目录路径
 *
 */
- (NSString *)fileNameToPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return [path stringByAppendingPathComponent:self];
}


#pragma mark - 文件大小
- (NSInteger)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}



- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;

}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

/**
 *  获取长度
 */
- (NSUInteger)getStrlength {
    return [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding];
}


@end
