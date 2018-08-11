//
//  ShequBottomView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/16.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ShequBottomView.h"
#import "LogDetailController.h"


@interface ShequBottomView()

@property (nonatomic, strong) UIButton *zhuanfaButton;

@property (nonatomic, strong) UIButton *collectButton;

@property (nonatomic, strong) UIButton *talkButton;

@property (nonatomic, strong) UIButton *upButton;

@end

@implementation ShequBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.zhuanfaButton = [self makeButtonWithTitle:@"" image:@"operat_icon_forward" selectImage:@"operat_icon_forward"];
        self.zhuanfaButton.frame = CGRectMake(AutoSize6(10), 0, AutoSize6(80), AutoSize6(80));
        [self addSubview:self.zhuanfaButton];
        
        self.collectButton = [self makeButtonWithTitle:@"" image:@"operat_icon_collect" selectImage:@"operat_icon_collected"];
        self.collectButton.frame = CGRectMake(self.zhuanfaButton.right, 0, self.zhuanfaButton.width, self.zhuanfaButton.height);
        [self addSubview:self.collectButton];
        
        self.talkButton = [self makeButtonWithTitle:@"" image:@"operat_icon_comment" selectImage:@"operat_icon_comment"];
        self.talkButton.frame = CGRectMake(self.collectButton.right, 0, self.zhuanfaButton.width, self.zhuanfaButton.height);
        [self addSubview:self.talkButton];
        
        self.upButton = [self makeButtonWithTitle:@"" image:@"operat_icon_like" selectImage:@"operat_icon_liked"];
        self.upButton.frame = CGRectMake(self.talkButton.right, 0, self.zhuanfaButton.width, self.zhuanfaButton.height);
        [self addSubview:self.upButton];
        
        [self.zhuanfaButton addTarget:self action:@selector(zhuanfaButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.collectButton addTarget:self action:@selector(collectButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.talkButton addTarget:self action:@selector(talkButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.upButton addTarget:self action:@selector(upButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.zhuanfaButton.tag = 100;
        self.collectButton.tag = 200;
        self.talkButton.tag = 300;
        self.upButton.tag = 400;
    }
    return self;
}

- (UIButton *)makeButtonWithTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:UIColorFromRGB(0x7f7f7f) forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x7f7f7f) forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    button.titleLabel.font = kFont(10);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, -AutoSize6(3), 0.0, 0.0)];
    return button;
}

- (void)zhuanfaButtonDidClick:(UIButton *)button {

}


- (void)collectButtonDidClick:(UIButton *)button {
    [UserDao userCollect:self.model.tid successBlock:^(__kindof AppBaseModel *responseObject) {
        button.selected = !button.selected;
    } failureBlock:^(__kindof AppBaseModel *error) {
        [AppBaseHud showHudWithfail:error.errstr view:[UIViewController currentViewController].view];
    }];
}

- (void)talkButtonDidClick:(UIButton *)button {
    
    if (self.model.tid.length) {
        LogDetailController *detailController = [[LogDetailController alloc] init];
        detailController.tid = self.model.tid;
        [[UIViewController currentViewController].navigationController pushViewController:detailController animated:YES];
        
    }
}

- (void)upButtonDidClick:(UIButton *)button {
    [UserDao userUp:self.model.tid successBlock:^(__kindof AppBaseModel *responseObject) {
        button.selected = !button.selected;
    } failureBlock:^(__kindof AppBaseModel *error) {
        [AppBaseHud showHudWithfail:error.errstr view:[UIViewController currentViewController].view];
    }];
}

- (void)setModel:(ShequModel *)model {
    _model = model;
    if (model.commentNum.length) {
        [self.talkButton setTitle:model.commentNum forState:UIControlStateNormal];
    }
    if (model.upNum.length) {
        [self.upButton setTitle:model.upNum forState:UIControlStateNormal];
    }
}

@end
