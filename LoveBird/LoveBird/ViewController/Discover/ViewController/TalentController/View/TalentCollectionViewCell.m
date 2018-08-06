//
//  TalentCollectionViewCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/4.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "TalentCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TalentCollectionViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIButton *followButton;

@property (nonatomic, strong) UIImageView *lvImageView;

@property (nonatomic, strong) UIImageView *lvTwoImageView;


@end

@implementation TalentCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 3 / 4)];
        backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backView];
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(((backView.width * 0.6) / 2), AutoSize(10), (backView.width *0.4), (frame.size.width *0.4))];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.layer.cornerRadius = _iconImageView.width / 2;
        _iconImageView.clipsToBounds = YES;
        [backView addSubview:_iconImageView];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _iconImageView.bottom + AutoSize(10), backView.width, AutoSize(15))];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.font = kFont(12);
        [backView addSubview:_textLabel];
        
        
        self.followButton = [[UIButton alloc] initWithFrame:CGRectMake((frame.size.width - AutoSize(50)) / 2, backView.bottom + AutoSize(8), AutoSize(50), (frame.size.height / 4) - AutoSize(10))];
        [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.followButton setTitle:@"已关注" forState:UIControlStateSelected];
        [self.followButton setBackgroundColor:UIColorFromRGB(0x7faf41)];
        self.followButton.titleLabel.font = kFontBold(12);
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self.followButton addTarget:self action:@selector(followButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        self.followButton.layer.cornerRadius = AutoSize(3);
        
        [self addSubview:self.followButton];
    }
    return self;
}

- (void)followButtonDidClick:(UIButton *)button {

    [UserDao userFollow:self.talentModel.msaterid successBlock:^(__kindof AppBaseModel *responseObject) {
        button.selected = !button.selected;
    } failureBlock:^(__kindof AppBaseModel *error) {
        [AppBaseHud showHudWithfail:error.errstr view:[UIViewController currentViewController].view];
    }];
    
    if (self.followDelegate && [self.followDelegate respondsToSelector:@selector(followButtonDidClick:)]) {
        [self.followDelegate followButtonClickDelegate:button];
    }
}

- (void)setTalentModel:(TalentModel *)talentModel {
    _talentModel = talentModel;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:talentModel.head] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    _textLabel.text = talentModel.master;
    _followButton.selected = talentModel.is_follow;
}



@end
