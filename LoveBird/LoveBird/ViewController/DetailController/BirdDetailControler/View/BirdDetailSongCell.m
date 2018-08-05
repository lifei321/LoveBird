//
//  BirdDetailSongCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailSongCell.h"

@interface BirdDetailSongCell()

@property (nonatomic, strong) UIButton *iconImageView;


@property (nonatomic, strong) UILabel *timeTotalLabel;


@end

@implementation BirdDetailSongCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _iconImageView  = [[UIButton alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(20), AutoSize6(66), AutoSize6(66))];
        _iconImageView.clipsToBounds = YES;
        [_iconImageView setImage:[UIImage imageNamed:@"detail_play_no"] forState:UIControlStateNormal];
        [_iconImageView setImage:[UIImage imageNamed:@"detail_play_yes"] forState:UIControlStateSelected];

        [_iconImageView addTarget:self action:@selector(iconImageViewDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_iconImageView];
        
        self.progressView = [[AudioProgressView alloc] initWithFrame:CGRectMake(_iconImageView.right + AutoSize6(30), 0, AutoSize6(450), AutoSize6(106))];
        [self addSubview:self.progressView];
        
        self.timeTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(170), 0, AutoSize6(150), AutoSize6(106))];
        self.timeTotalLabel.textColor = kColorDefaultColor;
        self.timeTotalLabel.textAlignment = NSTextAlignmentRight;
        self.timeTotalLabel.font = kFont6(30);
        self.timeTotalLabel.text = @"00:00";
        [self addSubview:self.timeTotalLabel];

        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(_iconImageView.left, AutoSize6(106) - 0.5, SCREEN_WIDTH - _iconImageView.left, 0.5)];
        lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:lineView];
        
    }
    return self;
}


- (void)setSongModel:(BirdDetailSongModel *)songModel {
    _songModel = songModel;
    self.timeTotalLabel.text = songModel.playback_length;
    
}


- (void)iconImageViewDidClick {
    if (self.iconImageView.selected) {
        self.iconImageView.selected = NO;
    } else {
        self.iconImageView.selected = YES;
    }

    
    if (self.delegate && [self.delegate respondsToSelector:@selector(BirdDetailSongCell:button:)]) {
        [self.delegate BirdDetailSongCell:self button:self.iconImageView];
    }
}


@end
