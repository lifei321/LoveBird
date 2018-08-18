//
//  BirdDetailTextCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailTextCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BirdDetailTextCell()



@property (nonatomic, strong) UILabel *tagLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation BirdDetailTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, SCREEN_WIDTH - AutoSize6(230), AutoSize6(92))];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = kFont6(32);
        [self.contentView addSubview:self.titleLabel];
        
        
        _playButton  = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(100), 0, AutoSize6(70), AutoSize6(92))];
        _playButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.contentView addSubview:_playButton];
        
        self.tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(255), 0, AutoSize6(200), AutoSize6(92))];
        self.tagLabel.textAlignment = NSTextAlignmentRight;
        self.tagLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.tagLabel.font = kFont6(30);
        [self.contentView addSubview:self.tagLabel];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(self.titleLabel.left, AutoSize6(91), SCREEN_WIDTH - AutoSize6(30) - self.titleLabel.left, 1)];
        self.lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:self.lineView];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(100), 0, AutoSize6(70), AutoSize6(92))];
        self.iconImageView.contentMode = UIViewContentModeRight;
        [self.contentView addSubview:self.iconImageView];
        self.iconImageView.hidden = YES;
        
    }
    return self;
}

- (void)playbuttondidclick {
    if (self.playButton.selected) {
        self.playButton.selected = NO;
    } else {
        self.playButton.selected = YES;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BirdDetailTextCell:button:)]) {
        [self.delegate BirdDetailTextCell:self button:self.playButton];
    }
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
    self.playButton.hidden = YES;
    self.iconImageView.hidden = YES;
}

- (void)setDetail:(NSString *)detail {
    self.playButton.hidden = YES;
    self.iconImageView.hidden = NO;
    self.iconImageView.image = [UIImage imageNamed:@"detail_right"];
    self.tagLabel.text = detail;
}

- (void)setHasImage:(BOOL)hasImage {
    self.playButton.hidden = NO;
    self.iconImageView.hidden = YES;
    [self.playButton setImage:[UIImage imageNamed:@"detail_song"] forState:UIControlStateNormal];
    [self.playButton setImage:[UIImage imageNamed:@"detail_song_no"] forState:UIControlStateSelected];

    [_playButton addTarget:self action:@selector(playbuttondidclick) forControlEvents:UIControlEventTouchUpInside];

}

@end
