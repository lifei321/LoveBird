//
//  PublishAddView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/8.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishAddView.h"

@interface PublishAddView()

@property (nonatomic, strong) UILabel *contentLabe;

@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation PublishAddView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewClick)]];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, AutoSize6(22), AutoSize6(314), AutoSize6(62))];
        backView.centerX = self.centerX;
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.borderWidth = 1;
        backView.layer.borderColor = UIColorFromRGB(0xd2d2d2).CGColor;
        backView.layer.cornerRadius = AutoSize6(20);
        backView.clipsToBounds = YES;


        [self addSubview:backView];
        
        UIView *textView = [self makeView:0 left:AutoSize6(40) image:@"pub_text" title:@"文本" action:@selector(textViewDidClick)];
        [backView addSubview:textView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(backView.width / 2 - 1, AutoSize6(12), 1, AutoSize6(38))];
        line.backgroundColor = kColorTextColorLightGraya2a2a2;
        [backView addSubview:line];
        
        UIView *imageView = [self makeView:textView.right left:AutoSize6(24) image:@"pub_image" title:@"图片" action:@selector(imageViewDidClick)];
        [backView addSubview:imageView];
        
    }
    return self;
}

- (void)backViewClick {
    
}

- (void)textViewDidClick {
    if (self.textblock) {
        self.textblock();
    }
}

- (void)imageViewDidClick {
    if (self.imageblock) {
        self.imageblock();
    }
}

- (UIView *)makeView:(CGFloat)x left:(CGFloat)left image:(NSString *)imageString title:(NSString *)title action:(SEL)action {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(x, 0, AutoSize6(314) / 2, AutoSize6(62))];
    backView.backgroundColor = [UIColor whiteColor];
    backView.userInteractionEnabled = YES;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(left, 0, AutoSize6(42), backView.height)];
    imageView.image = [UIImage imageNamed:imageString];
    imageView.contentMode = UIViewContentModeCenter;
    [backView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.right + AutoSize6(10), 0, AutoSize6(100), backView.height)];
    label.text = title;
    label.font = kFont6(24);
    label.textColor = kColorTextColorLightGraya2a2a2;
    label.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:label];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    [backView addGestureRecognizer:tap];
    
    return backView;
}

@end
