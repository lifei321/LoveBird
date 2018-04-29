//
//  AppEmptyView.h
//  LoveBird
//
//  Created by ShanCheli on 2017/6/21.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppEmptyView : UIView


+ (AppEmptyView *)createEmptyViewWithText:(NSString *)text
                                     image:(UIImage *)img
                                 retryText:(NSString *)retryTitle
                                retryBlock:(dispatch_block_t)retryBlock;


+ (AppEmptyView *)createEmptyViewWithText:(NSString *)text
                                 textColor:(UIColor *)textColor
                                     image:(UIImage *)img
                                     space:(CGFloat)space
                                 retryText:(NSString *)retryTitle
                                retryBlock:(dispatch_block_t)retryBlock;


/**
 *  <#Description#>
 *
 *  @param text           空页面的文字
 *  @param attributedText 空页面高亮的文字
 *
 */
+ (AppEmptyView *)createEmptyViewWithText:(NSString *)text
                           attributedText:(NSString *)attributedText
                                    image:(UIImage *)img
                                   target:(id)target
                                   action:(SEL)action;


@end
