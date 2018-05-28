//
//  LogDetailTitleView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogDetailTitleView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LogDetailTitleView()

@property (nonatomic, strong) UIImageView *headIcon;

@property (nonatomic, strong) UILabel *nickNameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

// 关注按钮
@property (nonatomic, strong) UIButton *followButton;


@end

@implementation LogDetailTitleView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        // 头像
        self.headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize(10), AutoSize(12), AutoSize(36), AutoSize(36))];
        self.headIcon.contentMode = UIViewContentModeCenter;
        self.headIcon.clipsToBounds = YES;
        self.headIcon.layer.cornerRadius = AutoSize(18);
        [self addSubview:self.headIcon];
        
        // 昵称
        self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headIcon.right + AutoSize(5), self.headIcon.top, SCREEN_WIDTH / 2, AutoSize(20))];
        self.nickNameLabel.textColor = [UIColor blackColor];
        self.nickNameLabel.font = kFont(13);
        self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.nickNameLabel];
        
        // 时间
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nickNameLabel.left, self.nickNameLabel.bottom, self.nickNameLabel.width, AutoSize(15))];
        self.timeLabel.textColor = UIColorFromRGB(0xa2a2a2);
        self.timeLabel.font = kFont(9);
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.timeLabel];
        
        // 关注
        self.followButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize(10) - AutoSize(40), 0, AutoSize(40), AutoSize(60))];
        [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.followButton setTitle:@"已关注" forState:UIControlStateSelected];
        self.followButton.titleLabel.font = kFont(13);
        [self.followButton setTitleColor:UIColorFromRGB(0x7faf41) forState:UIControlStateNormal];
        [self.followButton setTitleColor:UIColorFromRGB(0xa2a2a2) forState:UIControlStateSelected];
        [self.followButton addTarget:self action:@selector(followButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.followButton];
        self.followButton.tag = 500;
    }
    return self;
}

- (void)followButtonDidClick:(UIButton *)button {
    
//    if (self.followDelegate && [self.followDelegate respondsToSelector:@selector(followButtonDidClick:)]) {
//        [self.followDelegate followButtonClickDelegate:button];
//    }
}

- (void)setDetailModel:(LogDetailModel *)detailModel {
    _detailModel = detailModel;
    
    self.nickNameLabel.text = detailModel.author;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:detailModel.authorHead] placeholderImage:nil];
    self.followButton.selected = detailModel.isFollow;
    self.timeLabel.text = [[AppDateManager shareManager] getDateWithTime:detailModel.publishTime formatSytle:DateFormatYMD];
}

@end
