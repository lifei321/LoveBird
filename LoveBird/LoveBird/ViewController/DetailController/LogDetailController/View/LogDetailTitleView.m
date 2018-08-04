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
        self.headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(20), AutoSize6(75), AutoSize6(75))];
        self.headIcon.contentMode = UIViewContentModeScaleAspectFit;
        self.headIcon.clipsToBounds = YES;
        self.headIcon.layer.cornerRadius = self.headIcon.height / 2;
        [self addSubview:self.headIcon];
        
        // 昵称
        self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headIcon.right + AutoSize(5), self.headIcon.top + AutoSize6(5), SCREEN_WIDTH / 2, AutoSize6(37))];
        self.nickNameLabel.textColor = [UIColor blackColor];
        self.nickNameLabel.font = kFont(13);
        self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.nickNameLabel];
        
        // 时间
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nickNameLabel.left, self.nickNameLabel.bottom + AutoSize6(5), self.nickNameLabel.width, AutoSize6(30))];
        self.timeLabel.textColor = UIColorFromRGB(0xa2a2a2);
        self.timeLabel.font = kFont(9);
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.timeLabel];
        
        // 关注
        self.followButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize(10) - AutoSize6(90), AutoSize6(32.5), AutoSize6(90), AutoSize6(50))];
        [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.followButton setTitle:@"已关注" forState:UIControlStateSelected];
        self.followButton.titleLabel.font = kFont6(24);
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.followButton setTitleColor:kColorTextColorLightGraya2a2a2 forState:UIControlStateSelected];

        [self.followButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:self.followButton.frame.size] forState:UIControlStateNormal];
        [self.followButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kLineColoreLightGrayECECEC withSize:self.followButton.frame.size] forState:UIControlStateSelected];
        [self.followButton addTarget:self action:@selector(followButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        self.followButton.layer.cornerRadius = AutoSize6(3);
        self.followButton.clipsToBounds = YES;
        [self addSubview:self.followButton];
        self.followButton.tag = 500;
    }
    return self;
}

- (void)followButtonDidClick:(UIButton *)button {
    
    NSString *tid;
    if (self.detailModel) {
        tid = self.detailModel.authorid;
    } if (self.contentModel) {
        tid = self.contentModel.authorid;
    }
    
    [UserDao userFollow:tid successBlock:^(__kindof AppBaseModel *responseObject) {
        button.selected = !button.selected;
    } failureBlock:^(__kindof AppBaseModel *error) {
        [AppBaseHud showHudWithfail:error.errstr view:[UIViewController currentViewController].view];
    }];
}

- (void)setDetailModel:(LogDetailModel *)detailModel {
    _detailModel = detailModel;
    
    self.nickNameLabel.text = detailModel.author;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:detailModel.authorHead] placeholderImage:nil];
    self.followButton.selected = detailModel.isFollow;
    self.timeLabel.text = [[AppDateManager shareManager] getDateWithTime:detailModel.publishTime formatSytle:DateFormatYMD];
}

- (void)setContentModel:(LogContentModel *)contentModel {
    _contentModel = contentModel;
    
    self.nickNameLabel.text = contentModel.author;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:contentModel.head] placeholderImage:nil];
    self.followButton.selected = contentModel.isFollow;
    self.timeLabel.text = [[AppDateManager shareManager] getDateWithTime:contentModel.dateline formatSytle:DateFormatYMD];
}

@end
