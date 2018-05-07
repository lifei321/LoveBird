//
//  PublishCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishCell.h"
#import "NSString+APP.h"

@interface PublishCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabe;

// 选择鸟种
@property (nonatomic, strong) UIButton *birdButton;


@property (nonatomic, strong) UIButton *upButton;

@property (nonatomic, strong) UIButton *downButton;


@end

@implementation PublishCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(20), AutoSize6(14), SCREEN_WIDTH - AutoSize6(40), AutoSize6(260))];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(-AutoSize6(12), -AutoSize6(12), AutoSize6(42), AutoSize6(42))];
        [closeButton setImage:[UIImage imageNamed:@"pub_close"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeDidClilck) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:closeButton];
        
        UIButton *upButton = [[UIButton alloc] initWithFrame:CGRectMake(backView.width - AutoSize6(48), AutoSize6(14), AutoSize6(26), AutoSize6(14))];
        [upButton setImage:[UIImage imageNamed:@"pub_up"] forState:UIControlStateNormal];
        [upButton addTarget:self action:@selector(upDidClilck) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:upButton];
        self.upButton = upButton;
        
        UIButton *downButton = [[UIButton alloc] initWithFrame:CGRectMake(upButton.left, AutoSize6(274) - AutoSize6(36), AutoSize6(26), AutoSize6(14))];
        [downButton setImage:[UIImage imageNamed:@"pub_down"] forState:UIControlStateNormal];
        [downButton addTarget:self action:@selector(downDidClilck) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:downButton];
        self.downButton = downButton;
        
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(35), AutoSize6(288), AutoSize6(194))];
        self.iconView.contentMode = UIViewContentModeScaleAspectFill;
        [backView addSubview:self.iconView];
        
        self.titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(self.iconView.right + AutoSize6(20), self.iconView.top, AutoSize6(286), AutoSize6(132))];
        self.titleLabe.textColor = kColorTextColor333333;
        self.titleLabe.textAlignment = NSTextAlignmentLeft;
        self.titleLabe.font = kFont6(20);
        self.titleLabe.numberOfLines = 0;
        [backView addSubview:self.titleLabe];

        self.birdButton = [[UIButton alloc] initWithFrame:CGRectMake(self.iconView.right + AutoSize6(20), self.iconView.bottom - AutoSize6(44), AutoSize6(120), AutoSize6(44))];
        self.birdButton.layer.borderColor = UIColorFromRGB(0xd2d2d2).CGColor;
        self.birdButton.layer.borderWidth = 1;
        self.birdButton.layer.cornerRadius = 5;
        [self.birdButton setTitle:@"添加鸟名" forState:UIControlStateNormal];
        [self.birdButton setTitleColor:kColorTextColorLightGraya2a2a2 forState:UIControlStateNormal];
        self.birdButton.titleLabel.font = kFont6(20);
        [backView addSubview:self.birdButton];
    }
    return self;
}

- (void)closeDidClilck {
    
}

- (void)upDidClilck {
    
}

- (void)downDidClilck {
    
}

- (void)setEditModel:(PublishEditModel *)editModel {
    _editModel = editModel;
    
    self.iconView.image = editModel.imageSelect;

    if (editModel.title.length) {
        self.birdButton.hidden = YES;
        self.titleLabe.text = editModel.title;

        CGFloat height = [editModel.title getTextHeightWithFont:self.titleLabe.font withWidth:AutoSize6(286)];
        if (height > AutoSize6(132)) {
            height = AutoSize6(132);
        }
        self.titleLabe.height = height;
        
    } else {
        self.birdButton.hidden = NO;
    }
    
}

@end