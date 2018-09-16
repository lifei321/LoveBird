//
//  MineMessageViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/9/16.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineMessageViewController.h"
#import "AppPlaceHolderTextView.h"
#import "UserDao.h"

@interface MineMessageViewController ()

@property (nonatomic, copy) NSString *text;


@property (nonatomic, strong) AppPlaceHolderTextView *textView;


@end

@implementation MineMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    
    self.textView = [[AppPlaceHolderTextView alloc] initWithFrame:self.view.bounds];
    self.textView.placeholder = @"请输入内容...";
    self.textView.limitCount = 100000;
    [self.view addSubview:self.textView];
    
    if (self.text.length) {
        self.textView.text = self.text;
    }
    
}

- (void)setNavigation {
    self.title = @"编辑";
    self.rightButton.title = @"发送";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
}

- (void)rightButtonAction {
    
    if (self.textView.text.length == 0) {
        [AppBaseHud showHudWithfail:@"请输入信息" view:self.view block:^{
            
        }];
        
        return;
    }
    
    [AppBaseHud showHudWithLoding:self.view];
    [UserDao sendMessage:self.taid message:self.textView.text successBlock:^(__kindof AppBaseModel *responseObject) {
        
        [AppBaseHud showHudWithSuccessful:@"发送成功" view:self.view block:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        [AppBaseHud showHudWithfail:@"发送失败" view:self.view block:^{
            
        }];
    }];

}


@end
