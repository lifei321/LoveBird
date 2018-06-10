//
//  MatchTitleView.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/10.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MatchTitleView.h"

@interface MatchTitleView()

@property (nonatomic, strong) UILabel *nickNameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

// 关注按钮
@property (nonatomic, strong) UIButton *followButton;

@end


@implementation MatchTitleView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        
        // 昵称
        self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(30), SCREEN_WIDTH - AutoSize6(60), AutoSize6(40))];
        self.nickNameLabel.textColor = [UIColor blackColor];
        self.nickNameLabel.font = kFont6(32);
        self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.nickNameLabel];
        
        // 时间
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nickNameLabel.left, self.nickNameLabel.bottom + AutoSize6(15), self.nickNameLabel.width, AutoSize6(30))];
        self.timeLabel.textColor = UIColorFromRGB(0xa2a2a2);
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.timeLabel];
        
        // 关注
        self.followButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(150), AutoSize6(70), AutoSize6(120), AutoSize6(42))];
        [self.followButton setTitle:@"我的记录" forState:UIControlStateNormal];
        [self.followButton setTitle:@"我的记录" forState:UIControlStateSelected];
        self.followButton.titleLabel.font = kFont6(24);
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.followButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:UIColorFromRGB(0xf7b03d) withSize:self.followButton.frame.size] forState:UIControlStateNormal];
        [self.followButton addTarget:self action:@selector(followButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        self.followButton.layer.cornerRadius = AutoSize6(3);
        self.followButton.clipsToBounds = YES;
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

- (void)setDetailModel:(MatchDetailModel *)detailModel {
    _detailModel = detailModel;
    
    self.nickNameLabel.text = detailModel.title;
    
    NSString *text1 = @"已投稿";
    NSString *text2 = @"件作品";
    NSString *textString = [NSString stringWithFormat:@"%@%@%@", text1, detailModel.articleNum, text2];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textString];
    [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColorLightGraya2a2a2 range:NSMakeRange(0, text1.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xf7b03d) range:NSMakeRange(text1.length, detailModel.articleNum.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColorLightGraya2a2a2 range:NSMakeRange(text1.length + detailModel.articleNum.length, text2.length)];
    
    [attrString addAttribute:NSFontAttributeName value:kFont6(20) range:NSMakeRange(0, textString.length)];
    self.timeLabel.attributedText = attrString;
}

@end
