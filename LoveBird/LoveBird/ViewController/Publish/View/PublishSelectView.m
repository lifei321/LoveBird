//
//  PublishSelectView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishSelectView.h"

@interface PublishSelectView ()

@property (nonatomic, strong) UILabel *countLable;

@end

@implementation PublishSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIButton *lessButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, AutoSize6(52), AutoSize6(52))];
        lessButton.layer.borderColor = kLineColoreLightGrayECECEC.CGColor;
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
        addButton.layer.borderWidth = 1;
        addButton.layer.cornerRadius = 3;
        [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
    }
    return self;
}

- (void)lessButtonClick {
    
}

- (void)addButtonClick {
    
}

@end