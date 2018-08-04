//
//  LogDeatilTalkCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogDeatilTalkCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LogDeatilTalkCell()


@property (nonatomic, strong) UIImageView *headIcon;

@property (nonatomic, strong) UILabel *nickNameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

// 点赞按钮
@property (nonatomic, strong) UIButton *upButton;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *lineView;

@end


@implementation LogDeatilTalkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        // 头像
        self.headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(30), AutoSize6(75), AutoSize6(75))];
        self.headIcon.contentMode = UIViewContentModeScaleAspectFit;
        self.headIcon.clipsToBounds = YES;
        self.headIcon.layer.cornerRadius = self.headIcon.height / 2;
        [self.contentView addSubview:self.headIcon];
        
        // 昵称
        self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headIcon.right + AutoSize(5), self.headIcon.top + AutoSize6(5), SCREEN_WIDTH / 2, AutoSize6(37))];
        self.nickNameLabel.textColor = [UIColor blackColor];
        self.nickNameLabel.font = kFont(13);
        self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.nickNameLabel];
        
        // 时间
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nickNameLabel.left, self.nickNameLabel.bottom + AutoSize6(5), self.nickNameLabel.width, AutoSize6(30))];
        self.timeLabel.textColor = UIColorFromRGB(0xa2a2a2);
        self.timeLabel.font = kFont(9);
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.timeLabel];
        
        // 关注
        self.upButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(100), self.headIcon.top, AutoSize6(70), self.headIcon.height)];
        [self.upButton setImage:[UIImage imageNamed:@"operat_big_icon_like"] forState:UIControlStateNormal];
        [self.upButton setImage:[UIImage imageNamed:@"operat_big_icon_liked"] forState:UIControlStateSelected];
        [self.upButton addTarget:self action:@selector(followButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.upButton];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), self.headIcon.bottom + AutoSize6(20), SCREEN_WIDTH - AutoSize6(60), AutoSize6(94))];
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.textColor = UIColorFromRGB(0x7f7f7f);
        self.contentLabel.font = kFont6(26);
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(93), SCREEN_WIDTH - AutoSize6(30), 0.5)];
        self.lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:self.lineView];
        
    }
    return self;
}

- (void)followButtonDidClick:(UIButton *)button {

}

- (void)setBodyModel:(LogDetailTalkModel *)bodyModel {
    _bodyModel = bodyModel;
    
    self.nickNameLabel.text = bodyModel.userName;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:bodyModel.head] placeholderImage:nil];
    self.upButton.selected = bodyModel.isUp;
    self.timeLabel.text = [[AppDateManager shareManager] getDateWithTime:bodyModel.dateline formatSytle:DateFormatYMD];
    
    self.contentLabel.height = [bodyModel.content getTextHeightWithFont:self.contentLabel.font withWidth:(SCREEN_WIDTH - AutoSize6(60))];
    self.lineView.top = self.contentLabel.bottom + AutoSize6(29);
    self.contentLabel.text = bodyModel.content;
}

+ (CGFloat)getHeightWithModel:(LogDetailTalkModel *)model {
    
    CGFloat height = 0;
//    if (model.content.length) {
        height = AutoSize6(30) + AutoSize6(75);
        
        height += [model.content getTextHeightWithFont:kFont6(26) withWidth:(SCREEN_WIDTH - AutoSize6(60))];
        
        height += AutoSize6(20);
        
        height += AutoSize6(30);
//    }

    return height;
}

@end
