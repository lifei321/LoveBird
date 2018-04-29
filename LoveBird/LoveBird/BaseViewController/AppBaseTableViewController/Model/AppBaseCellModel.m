//
//  AppBaseCellModel.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseCellModel.h"

@implementation AppBaseCellModel

- (void)setRightView:(UIView *)rightView {
    
    if (_rightView) {
        
        [_rightView removeFromSuperview];
    }
    _rightView = rightView;
    
}

- (void)setLeftView:(UIView *)leftView {
    
    if (_leftView) {
        
        [_leftView removeFromSuperview];
    }
    
    _leftView = leftView;
}


- (AppBaseTextField *)rightTextFile {
    
    if (_rightTextFile == nil) {
        
        _rightTextFile = [[AppBaseTextField alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _rightTextFile.isTransparent = YES;
        _rightTextFile.borderStyle = UITextBorderStyleNone;
        _rightTextFile.font = kFont(13.);
        self.rightView = _rightTextFile;
    }
    return _rightTextFile;
}


/**
 *  设置 cell title的提示 icon
 *
 *  @param iconImage
 *  @param width
 */
- (void)addTitleIconWithImage:(UIImage *)iconImage width:(CGFloat)width addTarget:(id)target action:(SEL)action {
    
    self.titleIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.titleIcon setBackgroundImage:iconImage forState:UIControlStateNormal];
    self.titleIcon.width = width;
    self.titleIcon.height = width;
    [self.titleIcon addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  设置 block
 *
 *  @param cellUpdateBlock
 */
- (void)setCellUpdateBlock:(LFCellUpdateBlock)cellUpdateBlock {
    
    _cellUpdateBlock = cellUpdateBlock;
    
}

- (void)dealloc {
    
    [self.rightView removeFromSuperview];
    NSLog(@"%s", __func__);
    
}


@end
