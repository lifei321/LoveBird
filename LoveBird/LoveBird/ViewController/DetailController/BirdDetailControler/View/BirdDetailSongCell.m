//
//  BirdDetailSongCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailSongCell.h"

@interface BirdDetailSongCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *birdLabel;


@end

@implementation BirdDetailSongCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(20), AutoSize6(66), AutoSize6(66))];
        _iconImageView.contentMode = UIViewContentModeCenter;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.image = [UIImage imageNamed:@"detail_play_no"];
        [self.contentView addSubview:_iconImageView];
        
        self.birdLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + AutoSize6(30), 0, SCREEN_WIDTH - AutoSize6(150), AutoSize6(106))];
        self.birdLabel.textAlignment = NSTextAlignmentLeft;
        self.birdLabel.textColor = kColorDefaultColor;
        self.birdLabel.font = kFont6(30);
        [self.contentView addSubview:self.birdLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(_iconImageView.left, AutoSize6(106) - 0.5, SCREEN_WIDTH - _iconImageView.left, 0.5)];
        lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:lineView];
        
    }
    return self;
}


- (void)setSongModel:(BirdDetailSongModel *)songModel {
    _songModel = songModel;
    self.birdLabel.text = songModel.playback_length;
    
}





@end
