//
//  NotifyFollowCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/16.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "NotifyFollowCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NotifyFollowCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UILabel *timeLabel;

@end


@implementation NotifyFollowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(22), AutoSize6(88), AutoSize6(88))];
        self.iconImageView.contentMode = UIViewContentModeScaleToFill;
        _iconImageView.layer.cornerRadius = _iconImageView.width / 2;
        _iconImageView.clipsToBounds = YES;
        [self.contentView addSubview:_iconImageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconDidClick)];
        _iconImageView.userInteractionEnabled = YES;
        [_iconImageView addGestureRecognizer:tap];
        
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + AutoSize6(20), _iconImageView.top, SCREEN_WIDTH / 2, _iconImageView.height)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = kColorTextColor333333;
        _titleLabel.font = kFont(14);
        [self.contentView addSubview:_titleLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(330), _titleLabel.top, AutoSize6(300), _titleLabel.height)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = kColorTextColorLightGraya2a2a2;
        _timeLabel.font = kFont6(23);
        [self.contentView addSubview:_timeLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.left, _iconImageView.bottom, SCREEN_WIDTH - AutoSize6(60), AutoSize6(70))];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = kColorTextColor7f7f7f;
        _contentLabel.font = kFontPF6(26);
        [self.contentView addSubview:_contentLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(192) - 0.5, SCREEN_WIDTH - AutoSize6(60), 0.5)];
        line.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setModel:(MessageModel *)model {
    _model = model;
    
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    _titleLabel.text = model.messageUsername;
    _timeLabel.text = [[AppDateManager shareManager] getDateWithTime:model.dateline formatSytle:DateFormatYMDHM];
    _contentLabel.text = model.messageContent;
    
}


- (void)iconDidClick {
    UserInfoViewController *infovc = [[UserInfoViewController alloc] init];
    infovc.uid = self.model.messageUid;
    [[UIViewController currentViewController].navigationController pushViewController:infovc animated:YES];
}
@end
