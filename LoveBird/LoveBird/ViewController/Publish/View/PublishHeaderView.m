//
//  PublishHeaderView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishHeaderView.h"

@interface PublishHeaderView()

@property (nonatomic, strong) UIImageView *headerImageView;

@property (nonatomic, strong) UIImageView *changeImageView;


@end

@implementation PublishHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(436))];
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
        _headerImageView.image = [UIImage imageNamed:@"publish_header"];
    }
    return _headerImageView;
}

- (UIImageView *)changeImageView {
    if (!_changeImageView) {
        _changeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(187), AutoSize6(20), AutoSize6(157), AutoSize6(34))];
        _changeImageView.contentMode = UIViewContentModeScaleToFill;
        _changeImageView.image = [UIImage imageNamed:@"publish_change"];
        _changeImageView.userInteractionEnabled = YES;
        [_changeImageView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeDidClick)]];
    }
    return _changeImageView;
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

 - (void)changeDidClick {
     
 }
         
- (void)setImage:(UIImage *)image {
    
    if (_image) {
        return;
    }
    _image = image;
    [self addSubview:self.changeImageView];
    
    self.headerImageView.image = image;
    
    CGFloat height = SCREEN_WIDTH / image.size.width  * image.size.height;
    
    self.headerImageView.height = height;
    self.textField.top = self.headerImageView.bottom;
    self.height = self.textField.height + self.headerImageView.height;
}
         


@end
