//
//  AppAlertView.m
//  LoveBird
//
//  Created by ShanCheli on 2017/6/22.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppAlertView.h"

@implementation AppAlertView

@synthesize onDismissBlock = _onDismissBlock;
@synthesize customDelegate = _customDelegate;

+ (void)simpleAlertWithTitle:(NSString *)title
                     message:(NSString *)message
                   onDismiss:(AlertDismissBlock)dismissBlock
{
    AppAlertView *alert = [[AppAlertView alloc] initWithTitle:title
                                                      message:message
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil];
    
    alert.onDismissBlock = dismissBlock;
    [alert show];
}

+ (void)questionAlertWithTitle:(NSString *)title
                       message:(NSString *)message
                     onDismiss:(AlertDismissBlock)dismissBlock
{
    AppAlertView *alert = [[AppAlertView alloc] initWithTitle:title
                                                      message:message
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"确定", nil];
    
    alert.onDismissBlock = dismissBlock;
    [alert show];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION {
    return nil;
}

- (id)  initWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ...{
    if (message.length == 0) {
        return nil;
    }
    
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    
    if (self && otherButtonTitles) {
        va_list otherTitleArg;
        va_start(otherTitleArg, otherButtonTitles);
        NSString *butotnTitle = va_arg(otherTitleArg, typeof(NSString *));
        
        while (butotnTitle != nil) {
            [self addButtonWithTitle:butotnTitle];
            butotnTitle = va_arg(otherTitleArg, typeof(NSString *));
        }
        va_end(otherTitleArg);
    }
    
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_customDelegate && [_customDelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [_customDelegate alertView:self clickedButtonAtIndex:buttonIndex];
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    if (_customDelegate && [_customDelegate respondsToSelector:@selector(alertViewCancel:)]) {
        [_customDelegate alertViewCancel:self];
    }
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    if (_customDelegate && [_customDelegate respondsToSelector:@selector(willPresentAlertView:)]) {
        [_customDelegate willPresentAlertView:self];
    }
}

- (void)didPresentAlertView:(UIAlertView *)alertView
{
    if (_customDelegate && [_customDelegate respondsToSelector:@selector(didPresentAlertView:)]) {
        [_customDelegate didPresentAlertView:self];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (_customDelegate && [_customDelegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        [_customDelegate alertView:self willDismissWithButtonIndex:buttonIndex];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (_customDelegate && [_customDelegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
        [_customDelegate alertView:self didDismissWithButtonIndex:buttonIndex];
    }
    
    if (self.onDismissBlock) {
        self.onDismissBlock(buttonIndex);
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    if (_customDelegate && [_customDelegate respondsToSelector:@selector(alertViewShouldEnableFirstOtherButton:)]) {
        return [_customDelegate alertViewShouldEnableFirstOtherButton:self];
    }
    
    return YES;
}


@end
