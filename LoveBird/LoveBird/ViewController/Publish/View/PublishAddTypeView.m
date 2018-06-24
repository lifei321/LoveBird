//
//  PublishAddTypeView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/8.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishAddTypeView.h"

@implementation PublishAddTypeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, AutoSize6(22), AutoSize6(88), AutoSize6(62))];
        imageView.centerX = self.centerX;
        imageView.layer.cornerRadius = AutoSize6(25);
        imageView.image = [UIImage imageNamed:@"pub_add"];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageDidClick)];
        [imageView addGestureRecognizer:tap];
    }
    return self;
}

- (void)imageDidClick {
    if (self.addblock) {
        self.addblock();
    }
}

@end
