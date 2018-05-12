//
//  PublishSelectView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishSelectView.h"

@interface PublishSelectView ()


@end

@implementation PublishSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _isSelect = NO;
        UIButton *lessButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, AutoSize6(52), AutoSize6(52))];
        lessButton.layer.borderColor = kLineColoreLightGrayECECEC.CGColor;
        [lessButton setImage:[UIImage imageNamed:@"pub_less_image"] forState:UIControlStateNormal];
        lessButton.layer.borderWidth = 1;
        lessButton.layer.cornerRadius = 3;
        [lessButton addTarget:self action:@selector(lessButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:lessButton];
        
        self.countLable = [[UILabel alloc] initWithFrame:CGRectMake(lessButton.right + AutoSize6(5), 0, AutoSize6(104), lessButton.height)];
        self.countLable.layer.borderColor = kLineColoreLightGrayECECEC.CGColor;
        self.countLable.layer.borderWidth = 1;
        self.countLable.layer.cornerRadius = 3;
        self.countLable.text = @"1";
        self.countLable.textAlignment = NSTextAlignmentCenter;
        self.countLable.textColor = [UIColor blackColor];
        self.countLable.font = kFont6(28);
        [self addSubview:self.countLable];
        
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.countLable.right + AutoSize6(5), 0, AutoSize6(50), lessButton.height)];
        addButton.layer.borderColor = kLineColoreLightGrayECECEC.CGColor;
        [addButton setImage:[UIImage imageNamed:@"pub_add_image"] forState:UIControlStateNormal];
        addButton.layer.borderWidth = 1;
        addButton.layer.cornerRadius = 3;
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
    }
    return self;
}

- (void)lessButtonClick {
    
    NSInteger count = self.countLable.text.integerValue;
    if (_isSelect) {
        if (count == 0) {
            return;
        }
    } else {
        if (count == 1) {
            return;
        }
    }

    count--;
    self.countLable.text = [NSString stringWithFormat:@"%ld", count];
    
    if (self.lessblock) {
        self.lessblock();
    }
}

- (void)addButtonClick {
    NSInteger count = self.countLable.text.integerValue;
    
    count++;
    self.countLable.text = [NSString stringWithFormat:@"%ld", count];
    if (self.addblock) {
        self.addblock();
    }
}

@end
