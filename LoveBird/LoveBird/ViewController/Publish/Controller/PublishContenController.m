//
//  PublishContenController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/8.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishContenController.h"
#import "AppPlaceHolderTextView.h"

@interface PublishContenController ()

@property (nonatomic, strong) AppPlaceHolderTextView *textView;

@end

@implementation PublishContenController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigation];
    
    self.textView = [[AppPlaceHolderTextView alloc] initWithFrame:self.view.bounds];
    self.textView.placeholder = @"请输入描述内容";
    self.textView.limitCount = 100000;
    [self.view addSubview:self.textView];
    
}

- (void)setNavigation {
    self.title = @"编辑";
    self.rightButton.title = @"完成";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
}

- (void)rightButtonAction {
    if (self.contentblock) {
        self.contentblock(self.textView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
