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

// 回复按钮
@property (nonatomic, strong) UIButton *upButton;

@property (nonatomic, strong) UILabel *contentLabel;

// 二层回复
@property (nonatomic, strong) UILabel *quoteLabel;

@property (nonatomic, strong) UIView *quoteView;


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
        self.headIcon.contentMode = UIViewContentModeScaleToFill;
        self.headIcon.clipsToBounds = YES;
        self.headIcon.layer.cornerRadius = self.headIcon.height / 2;
        [self.contentView addSubview:self.headIcon];
        
        self.headIcon.userInteractionEnabled = YES;
        [self.headIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headIconDidClick)]];
        
        // 昵称
        self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headIcon.right + AutoSize(5), self.headIcon.top + AutoSize6(5), SCREEN_WIDTH / 2, AutoSize6(37))];
        self.nickNameLabel.textColor = [UIColor blackColor];
        self.nickNameLabel.font = kFontPF6(28);
        self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.nickNameLabel];
        
        // 时间
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nickNameLabel.left, self.nickNameLabel.bottom + AutoSize6(5), self.nickNameLabel.width, AutoSize6(30))];
        self.timeLabel.textColor = UIColorFromRGB(0xa2a2a2);
        self.timeLabel.font = kFont(9);
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.timeLabel];
        
        // 回复
        self.upButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(100), self.headIcon.top, AutoSize6(70), self.headIcon.height)];
        [self.upButton setTitle:@"回复" forState:UIControlStateNormal];
        [self.upButton setTitle:@"回复" forState:UIControlStateHighlighted];
        [self.upButton setTitleColor:kColorDefaultColor forState:UIControlStateNormal];
        [self.upButton setTitleColor:kColorDefaultColor forState:UIControlStateHighlighted];
        self.upButton.titleLabel.font = kFont6(30);
        [self.upButton addTarget:self action:@selector(huifuButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.upButton];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headIcon.right - AutoSize6(5), self.headIcon.bottom + AutoSize6(20), SCREEN_WIDTH - self.headIcon.right - AutoSize6(30), AutoSize6(94))];
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.textColor = UIColorFromRGB(0x333333);
        self.contentLabel.font = kFontPF6(24);
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        
        self.quoteView = [[UIView alloc] initWithFrame:CGRectMake(self.contentLabel.left, self.contentLabel.bottom, self.contentLabel.width, AutoSize6(90))];
        self.quoteView.backgroundColor = UIColorFromRGB(0xececec);
        [self.contentView addSubview:self.quoteView];
        
        self.quoteLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.quoteLabel.textAlignment = NSTextAlignmentLeft;
        self.quoteLabel.textColor = UIColorFromRGB(0x333333);
        self.quoteLabel.font = kFontPF6(26);
        self.quoteLabel.numberOfLines = 0;
        [self.quoteView addSubview:self.quoteLabel];

        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(self.headIcon.right, AutoSize6(93), SCREEN_WIDTH - AutoSize6(30) - self.headIcon.right, 1)];
        self.lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:self.lineView];
        
    }
    return self;
}

- (void)setBodyModel:(LogDetailTalkModel *)bodyModel {
    _bodyModel = bodyModel;
    
    self.nickNameLabel.text = bodyModel.userName;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:bodyModel.head] placeholderImage:nil];
    self.upButton.selected = bodyModel.isUp;
    self.timeLabel.text = [[AppDateManager shareManager] getDateWithTime:bodyModel.dateline formatSytle:DateFormatYMD];
    
    self.contentLabel.height = [bodyModel.content getTextHeightWithFont:self.contentLabel.font withWidth:(SCREEN_WIDTH - self.headIcon.right - AutoSize6(30))];
    self.contentLabel.text = bodyModel.content;

    if (bodyModel.quote.length) {
        CGFloat quoteHeight = [bodyModel.quote getTextHeightWithFont:self.quoteLabel.font withWidth:(SCREEN_WIDTH - self.headIcon.right - AutoSize6(30) - AutoSize6(40))];
        self.quoteView.frame = CGRectMake(self.contentLabel.left, self.contentLabel.bottom + AutoSize6(30), self.contentLabel.width, quoteHeight + AutoSize6(50));
        self.quoteLabel.frame = CGRectMake(AutoSize6(20), AutoSize6(20), self.quoteView.width - AutoSize6(40), quoteHeight);
        self.lineView.top = self.quoteView.bottom + AutoSize6(29);
        self.quoteLabel.text = bodyModel.quote;
    } else {
        self.quoteView.frame = CGRectZero;
        self.quoteLabel.frame = CGRectZero;
        self.lineView.top = self.contentLabel.bottom + AutoSize6(29);
    }
    
    self.lineView.height = 1;
}

+ (CGFloat)getHeightWithModel:(LogDetailTalkModel *)model {
    
    CGFloat height = 0;
    
    if (model.head.length) {
        // 头像底部高度
        height = AutoSize6(30) + AutoSize6(75);
        
        // 一层距离头像高度
        height += AutoSize6(20);
        
        // 一层内容高度
        height += [model.content getTextHeightWithFont:kFontPF6(26) withWidth:(SCREEN_WIDTH - AutoSize6(105) - AutoSize6(30))];
        
        if (model.quote.length) {
            // 二层距离一层高度
            height += AutoSize6(30);
            
            // 二层内部上下间距
            height += AutoSize6(30) + AutoSize6(20);
            
            // 二层高度
            height += [model.quote getTextHeightWithFont:kFontPF6(24) withWidth:(SCREEN_WIDTH - AutoSize6(105) - AutoSize6(30) - AutoSize6(40))];
        }
        
        // 楼层距离底部高度
        height += AutoSize6(30);
    }

    return height;
}

- (void)headIconDidClick {
    
    if ([self.bodyModel.uid isEqualToString:[UserPage sharedInstance].uid]) {
        
        ((UITabBarController *)(kTabBarController)).selectedIndex = 4;
        
        [[UIViewController currentViewController].navigationController popToRootViewControllerAnimated:NO];
        return;
    }
    
    UserInfoViewController *uservc = [[UserInfoViewController alloc] init];
    uservc.uid = self.bodyModel.uid;
    uservc.userName = self.bodyModel.userName;
    [[UIViewController currentViewController].navigationController pushViewController:uservc animated:YES];
}


#pragma mark--- 回复

- (void)huifuButtonDidClick:(UIButton *)button {
    
    if (self.huifuBlock) {
        self.huifuBlock(self.bodyModel);
    }
}

@end
