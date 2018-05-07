//
//  PublishFooterView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishFooterView.h"

@implementation PublishFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *textView = [self makeView:AutoSize6(12) y:AutoSize6(22) image:@"pub_text" title:@"添加文本" action:@selector(textViewDidClick)];
        [self addSubview:textView];
        
        UIView *imageView = [self makeView:(textView.right + AutoSize6(12)) y:AutoSize6(22) image:@"pub_image" title:@"添加图片" action:@selector(imageViewDidClick)];
        [self addSubview:imageView];
    }
    return self;
}

- (void)textViewDidClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewClickDelegate)]) {
        [self.delegate textViewClickDelegate];
    }
}

- (void)imageViewDidClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageViewClickDelegate)]) {
        [self.delegate imageViewClickDelegate];
    }
}

- (UIView *)makeView:(CGFloat)x y:(CGFloat)y image:(NSString *)imageString title:(NSString *)title action:(SEL)action {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(x, y, (SCREEN_WIDTH - AutoSize6(36)) / 2, AutoSize6(144))];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderColor = kLineColoreLightGrayECECEC.CGColor;
    backView.layer.borderWidth = 1;
    backView.layer.cornerRadius = 5;
    backView.userInteractionEnabled = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(95), 0, AutoSize6(42), backView.height)];
    imageView.image = [UIImage imageNamed:imageString];
    imageView.contentMode = UIViewContentModeCenter;
    [backView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + AutoSize6(20), 0, AutoSize6(150), backView.height)];
    label.text = title;
    label.font = kFont6(28);
    label.textColor = kColorTextColorLightGraya2a2a2;
    label.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    [backView addGestureRecognizer:tap];
    
    return backView;
}


@end
