//
//  AppAlertView.h
//  LoveBird
//
//  Created by ShanCheli on 2017/6/22.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppAlertView;

@protocol ZBCustomAlertViewDelegate <NSObject>
@optional
- (void)alertView:(AppAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)alertViewCancel:(AppAlertView *)alertView;
- (void)willPresentAlertView:(AppAlertView *)alertView;  // before animation and showing view
- (void)didPresentAlertView:(AppAlertView *)alertView;  // after animation
- (void)alertView:(AppAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)alertView:(AppAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
- (BOOL)alertViewShouldEnableFirstOtherButton:(AppAlertView *)alertView;
@end

typedef void (^AlertDismissBlock)(NSInteger buttonIndex);

@interface AppAlertView : UIAlertView<UIAlertViewDelegate> {
}
+ (void)simpleAlertWithTitle:(NSString *)title
                     message:(NSString *)message
                   onDismiss:(AlertDismissBlock)dismissBlock;
+ (void)questionAlertWithTitle:(NSString *)title
                       message:(NSString *)message
                     onDismiss:(AlertDismissBlock)dismissBlock;

- (id)  initWithTitle:(NSString *)title
              message:(NSString *)message
    cancelButtonTitle:(NSString *)cancelButtonTitle
    otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;
@property (nonatomic, copy) AlertDismissBlock onDismissBlock;
@property (nonatomic, unsafe_unretained) id<ZBCustomAlertViewDelegate> customDelegate;


@end
