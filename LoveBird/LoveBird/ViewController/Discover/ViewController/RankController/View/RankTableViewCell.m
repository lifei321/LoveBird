//
//  RankTableViewCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "RankTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+Addition.h"

@interface RankTableViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *rankLabel;

@property (nonatomic, strong) UIButton *followButton;

@property (nonatomic, strong) UILabel *topLabel;

@property (nonatomic, strong) UILabel *bottomLabel;

@end


@implementation RankTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(50), 0, AutoSize6(50), AutoSize6(136))];
        self.rankLabel.textAlignment = NSTextAlignmentLeft;
        self.rankLabel.textColor = [UIColor blackColor];
        self.rankLabel.font = kFont6(30);
        [self.contentView addSubview:self.rankLabel];
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(92), AutoSize6(23), AutoSize6(90), AutoSize6(90))];
        _iconImageView.contentMode = UIViewContentModeCenter;
        _iconImageView.layer.cornerRadius = _iconImageView.width / 2;
        _iconImageView.clipsToBounds = YES;
        [self.contentView addSubview:_iconImageView];
        
        self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + AutoSize6(10), _iconImageView.top, AutoSize6(300), _iconImageView.height / 2)];
        self.topLabel.textAlignment = NSTextAlignmentLeft;
        self.topLabel.textColor = [UIColor blackColor];
        self.topLabel.font = kFont6(30);
        [self.contentView addSubview:self.topLabel];
        
        self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(_topLabel.left, _topLabel.bottom, _topLabel.width, _iconImageView.height / 2)];
        self.bottomLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.bottomLabel];
        
        
        self.followButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(142), AutoSize6(40), AutoSize6(114), AutoSize6(56))];
        [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.followButton setTitle:@"已关注" forState:UIControlStateSelected];
        [self.followButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:self.followButton.size] forState:UIControlStateNormal];
        [self.followButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorTextColorLightGraya2a2a2 withSize:self.followButton.size] forState:UIControlStateSelected];

        self.followButton.titleLabel.font = kFontBold(12);
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.followButton setTitleColor:UIColorFromRGB(0xa2a2a2) forState:UIControlStateSelected];
        [self.followButton addTarget:self action:@selector(followButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        self.followButton.layer.cornerRadius = AutoSize(3);
        [self.contentView addSubview:self.followButton];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(136) - 1, SCREEN_WIDTH - AutoSize6(60), 1)];
        line.backgroundColor = UIColorFromRGB(0xececec);
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)followButtonDidClick:(UIButton *)button {
    
}

- (void)setRankModel:(RankModel *)rankModel {
    _rankModel = rankModel;
    self.rankLabel.text = [NSString stringWithFormat:@"%ld", rankModel.second];
    if (rankModel.second < 4) {
        self.rankLabel.textColor = UIColorFromRGB(0xffad29);
    } else {
        self.rankLabel.textColor = [UIColor blackColor];
    }
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:rankModel.head] placeholderImage:[UIImage imageNamed:@""]];
    self.topLabel.text = rankModel.username;
    
    if (rankModel.birdNum.length) {
        NSString *textString = [NSString stringWithFormat:@"%@ 种", rankModel.birdNum];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textString];
        [attrString addAttribute:NSForegroundColorAttributeName value:kColorDefaultColor range:NSMakeRange(0, rankModel.birdNum.length)];
        [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColorLightGraya2a2a2 range:NSMakeRange(rankModel.birdNum.length, 2)];
        
        [attrString addAttribute:NSFontAttributeName value:kFont6(36) range:NSMakeRange(0, rankModel.birdNum.length)];
        [attrString addAttribute:NSFontAttributeName value:kFont6(23) range:NSMakeRange(rankModel.birdNum.length, 2)];
        self.bottomLabel.attributedText = attrString;
    } else if (rankModel.articleNum.length) {
        NSString *textString = [NSString stringWithFormat:@"%@ 篇", rankModel.articleNum];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textString];
        [attrString addAttribute:NSForegroundColorAttributeName value:kColorDefaultColor range:NSMakeRange(0, rankModel.articleNum.length)];
        [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColorLightGraya2a2a2 range:NSMakeRange(rankModel.articleNum.length, 2)];
        
        [attrString addAttribute:NSFontAttributeName value:kFont6(36) range:NSMakeRange(0, rankModel.articleNum.length)];
        [attrString addAttribute:NSFontAttributeName value:kFont6(23) range:NSMakeRange(rankModel.articleNum.length, 2)];
        self.bottomLabel.attributedText = attrString;
    } else if (rankModel.credit.length) {
        NSString *textString = [NSString stringWithFormat:@"%@ 分", rankModel.credit];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textString];
        [attrString addAttribute:NSForegroundColorAttributeName value:kColorDefaultColor range:NSMakeRange(0, rankModel.credit.length)];
        [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColorLightGraya2a2a2 range:NSMakeRange(rankModel.credit.length, 2)];
        
        [attrString addAttribute:NSFontAttributeName value:kFont6(36) range:NSMakeRange(0, rankModel.credit.length)];
        [attrString addAttribute:NSFontAttributeName value:kFont6(23) range:NSMakeRange(rankModel.credit.length, 2)];
        self.bottomLabel.attributedText = attrString;
    }
    
    
    
}

@end
