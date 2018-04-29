//
//  AppTextField.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppTextField.h"

@implementation AppTextField {
    
    UIButton *_clearButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.font = kFontDefault;
        self.textColor = UIColorFromRGB(0xffffff);
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        
        __weak typeof(self) weakSelf = self;
        self.delegate = weakSelf;
        _clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, AutoSize(25), AutoSize(25))];
        [_clearButton setImage:[UIImage imageNamed:@"Backspace"] forState:UIControlStateNormal];
        [_clearButton setImage:[UIImage imageNamed:@"Backspace"] forState:UIControlStateHighlighted];
        self.rightView = _clearButton;
        self.rightViewMode = UITextFieldViewModeWhileEditing;
        [_clearButton addTarget:self action:@selector(clearTextFile) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setIsDisplayCleanButton:(BOOL)isDisplayCleanButton {
    _isDisplayCleanButton = isDisplayCleanButton;
    if (_isDisplayCleanButton == NO) {
        self.rightView = nil;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _clearButton.frame = CGRectMake(self.width - AutoSize(30), 0, AutoSize(30), self.height);
}

/**
 *  //override respondsToSelector
 */
- (BOOL)respondsToSelector:(SEL)aSelector {
    NSString * selectorName = NSStringFromSelector(aSelector);
    //IOS8 以下 防止 self.delegate == self crash
    if ([selectorName isEqualToString:@"customOverlayContainer"]) {
        return NO;
    }
    
    return [super respondsToSelector:aSelector];
}

/**
 *  情况输入框
 */
- (void)clearTextFile {
    
    self.text = @"";
    self.rightViewMode = UITextFieldViewModeNever;
    [self becomeFirstResponder];
    
}

- (void)setPlaceholder:(NSString *)placeholder {
    
    [super setPlaceholder:placeholder];
    [self setValue:kLoginDefaultPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setIsTransparent:(BOOL)isTransparent {
    _isTransparent = isTransparent;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    if (_isTransparent) {
        
        self.backgroundColor = [UIColor clearColor];
        self.borderStyle = UITextBorderStyleNone;
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, kLoginDefaultPlaceholderColor.CGColor);
        CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
    }
    
}

- (void)setRightImage:(UIImage *)image addTarget:(id)addTarget action:(SEL)action {
    
    UIButton *iconButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - AutoSize(40), 0, AutoSize(40), AutoSize(37))];
    [iconButton setImage:image forState:UIControlStateNormal];
    [iconButton addTarget:addTarget action:action forControlEvents:UIControlEventTouchUpInside];
    self.rightView = iconButton;
    self.rightViewMode = UITextFieldViewModeAlways;
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *textString = textField.text ;
    NSUInteger length = [textString length];
    
    //    NSLog(@"length %ld,%@, %@", length, NSStringFromRange(range), string);
    
    if (range.location == 0 && [string isBlankString]) {
        self.rightViewMode = UITextFieldViewModeNever;
    } else {
        self.rightViewMode = UITextFieldViewModeAlways;
    }
    
    if (_limitLenght <= 0) {
        return YES;
    }
    BOOL bChange =YES;
    if (length >= _limitLenght)
        bChange = NO;
    
    if (range.length == 1) {
        bChange = YES;
    }
    return bChange;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.rightViewMode = UITextFieldViewModeNever;
    return YES;
}


@end
