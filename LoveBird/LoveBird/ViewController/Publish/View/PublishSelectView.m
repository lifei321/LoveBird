//
//  PublishSelectView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishSelectView.h"

@interface PublishSelectView ()
@property (nonatomic, strong) UILabel *countLabel;


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
        
        self.countTextField = [[UITextField alloc] initWithFrame:CGRectMake(lessButton.right + AutoSize6(5), 0, AutoSize6(90), lessButton.height)];
        self.countTextField.textColor = [UIColor blackColor];
        self.countTextField.layer.borderColor = kLineColoreLightGrayECECEC.CGColor;
        self.countTextField.layer.borderWidth = 1;
        self.countTextField.layer.cornerRadius = 3;
        self.countTextField.text = @"1";
        self.countTextField.textAlignment = NSTextAlignmentCenter;
        self.countTextField.textColor = [UIColor blackColor];
        self.countTextField.font = kFont6(28);
        self.countTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.countTextField];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.countTextField.right - 2, 0, AutoSize6(44), lessButton.height)];
        self.countLabel.layer.borderColor = kLineColoreLightGrayECECEC.CGColor;
        self.countLabel.layer.borderWidth = 1;
        self.countLabel.layer.cornerRadius = 3;
        self.countLabel.text = @"只";
        self.countLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        self.countLabel.font = kFont6(25);
        [self addSubview:self.countLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.countTextField.right - 3, 1, 3, lessButton.height - 2)];
        lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:lineView];
        
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(self.countLabel.right + AutoSize6(5), 0, AutoSize6(50), lessButton.height)];
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
    
    NSInteger count = self.countTextField.text.integerValue;
    if (_isSelect) {
        return;
    }

    if (count == 1) {
        return;
    }
    
    count--;
    self.countTextField.text = [NSString stringWithFormat:@"%ld", count];
    
    if (self.lessblock) {
        self.lessblock();
    }
}

- (void)addButtonClick {
    
    NSInteger count = self.countTextField.text.integerValue;
    if (_isSelect) {
        return;
    }
    
    count++;
    self.countTextField.text = [NSString stringWithFormat:@"%ld", count];
    if (self.addblock) {
        self.addblock();
    }
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if (isSelect) {
        self.countTextField.userInteractionEnabled = NO;
    } else {
        self.countTextField.userInteractionEnabled = YES;
    }
}

@end
