//
//  TimeLineBottomView.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "TimeLineBottomView.h"

@interface TimeLineBottomView()

@property (nonatomic, strong) UIButton *zhuanfaButton;

@property (nonatomic, strong) UIButton *collectButton;

@property (nonatomic, strong) UIButton *talkButton;

@property (nonatomic, strong) UIButton *upButton;

@end

@implementation TimeLineBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.zhuanfaButton = [self makeButtonWithTitle:@"转发" image:@"operat_icon_forward" selectImage:@"operat_icon_forward"];
        self.zhuanfaButton.frame = CGRectMake(AutoSize(10), 0, AutoSize(53), AutoSize(45));
        [self addSubview:self.zhuanfaButton];
        
        self.collectButton = [self makeButtonWithTitle:@"收藏" image:@"operat_icon_collect" selectImage:@"operat_icon_collected"];
        self.collectButton.frame = CGRectMake(self.zhuanfaButton.right, 0, AutoSize(53), AutoSize(45));
        [self addSubview:self.collectButton];
        
        self.talkButton = [self makeButtonWithTitle:@"" image:@"operat_icon_comment" selectImage:@"operat_icon_comment"];
        self.talkButton.frame = CGRectMake(self.collectButton.right, 0, AutoSize(53), AutoSize(45));
        [self addSubview:self.talkButton];
        
        self.upButton = [self makeButtonWithTitle:@"" image:@"operat_icon_like" selectImage:@"operat_icon_liked"];
        self.upButton.frame = CGRectMake(self.talkButton.right, 0, AutoSize(53), AutoSize(45));
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

- (void)setContentModel:(DiscoverContentModel *)contentModel {
    _contentModel = contentModel;
    
    self.collectButton.selected = contentModel.isCollection;
    self.upButton.selected = contentModel.isUp;
    
    if (contentModel.commentNum.length) {
        [self.talkButton setTitle:contentModel.commentNum forState:UIControlStateNormal];
        [self.talkButton setTitle:contentModel.commentNum forState:UIControlStateHighlighted];
    } else {
        [self.talkButton setTitle:@"0" forState:UIControlStateNormal];
        [self.talkButton setTitle:@"0" forState:UIControlStateHighlighted];
    }
    
    if (contentModel.upNum.length) {
        [self.upButton setTitle:contentModel.upNum forState:UIControlStateNormal];
        [self.upButton setTitle:contentModel.upNum forState:UIControlStateHighlighted];
    } else {
        [self.upButton setTitle:@"0" forState:UIControlStateNormal];
        [self.upButton setTitle:@"0" forState:UIControlStateHighlighted];
    }
}

- (void)setZhuangbeiModel:(ZhuangbeiModel *)zhuangbeiModel {
    _zhuangbeiModel = zhuangbeiModel;
    
    self.collectButton.selected = zhuangbeiModel.isCollection;
    self.upButton.selected = zhuangbeiModel.isUp;
    
    if (zhuangbeiModel.commentNum.length) {
        [self.talkButton setTitle:zhuangbeiModel.commentNum forState:UIControlStateNormal];
        [self.talkButton setTitle:zhuangbeiModel.commentNum forState:UIControlStateHighlighted];
    } else {
        [self.talkButton setTitle:@"0" forState:UIControlStateNormal];
        [self.talkButton setTitle:@"0" forState:UIControlStateHighlighted];
    }
    
    if (zhuangbeiModel.upNum.length) {
        [self.upButton setTitle:zhuangbeiModel.upNum forState:UIControlStateNormal];
        [self.upButton setTitle:zhuangbeiModel.upNum forState:UIControlStateHighlighted];
    } else {
        [self.upButton setTitle:@"0" forState:UIControlStateNormal];
        [self.upButton setTitle:@"0" forState:UIControlStateHighlighted];
    }
}

- (UIButton *)makeButtonWithTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitleColor:UIColorFromRGB(0x7f7f7f) forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x7f7f7f) forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    button.titleLabel.font = kFont(10);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, -AutoSize(15), 0.0, 0.0)];
    return button;
}


- (void)zhuanfaButtonDidClick:(UIButton *)button {
    if (self.timeLineToolDelegate && [self.timeLineToolDelegate respondsToSelector:@selector(timeLineToolClickDelegate:)]) {
        [self.timeLineToolDelegate timeLineToolClickDelegate:button];
    }
}


- (void)collectButtonDidClick:(UIButton *)button {
    if (self.timeLineToolDelegate && [self.timeLineToolDelegate respondsToSelector:@selector(timeLineToolClickDelegate:)]) {
        [self.timeLineToolDelegate timeLineToolClickDelegate:button];
    }
}

- (void)talkButtonDidClick:(UIButton *)button {
    if (self.timeLineToolDelegate && [self.timeLineToolDelegate respondsToSelector:@selector(timeLineToolClickDelegate:)]) {
        [self.timeLineToolDelegate timeLineToolClickDelegate:button];
    }
}

- (void)upButtonDidClick:(UIButton *)button {
    if (self.timeLineToolDelegate && [self.timeLineToolDelegate respondsToSelector:@selector(timeLineToolClickDelegate:)]) {
        [self.timeLineToolDelegate timeLineToolClickDelegate:button];
    }
}



@end
