//
//  PublishContenController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/8.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishContenController.h"

@interface PublishContenController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation PublishContenController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavigation];
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.textView];
    
}

- (void)setNavigation {
    self.title = @"编辑";
    self.rightButton.title = @"完成";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(36)} forState:UIControlStateNormal];
}

- (void)rightButtonAction {
    if (self.contentblock) {
        self.contentblock(self.textView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
