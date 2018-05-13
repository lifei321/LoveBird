//
//  PublishHeaderView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishHeaderView.h"

@interface PublishHeaderView()




@end

@implementation PublishHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(438))];
    if (self) {
        [self addSubview:self.headerImageView];
        [self addSubview:self.textField];
    }
    return self;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(322))];
        _headerImageView.contentMode = UIViewContentModeScaleToFill;
        _headerImageView.backgroundColor = [UIColor orangeColor];
    }
    return _headerImageView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.headerImageView.bottom, SCREEN_WIDTH, AutoSize6(114))];
        _textField.placeholder = @"标题不超过40字";
        _textField.backgroundColor = [UIColor whiteColor];
        
        CGRect frame = _textField.frame;
        frame.size.width = AutoSize(15);// 距离左侧的距离
        UIView *leftview = [[UIView alloc] initWithFrame:frame];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.leftView = leftview;
    }
    return _textField;
}



@end
