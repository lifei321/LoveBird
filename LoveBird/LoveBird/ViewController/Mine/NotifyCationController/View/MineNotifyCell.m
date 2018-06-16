//
//  MineNotifyCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/16.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineNotifyCell.h"


@interface MineNotifyCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UISwitch *switchView;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@end


@implementation MineNotifyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(17), AutoSize6(64), AutoSize6(64))];
        _iconImageView.contentMode = UIViewContentModeCenter;
        _iconImageView.layer.cornerRadius = _iconImageView.width / 2;
        [self.contentView addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + AutoSize6(20), 0, SCREEN_WIDTH / 2, AutoSize6(98))];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = kFont(14);
        [self.contentView addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize(77), 0, AutoSize(60), AutoSize(47))];
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = kFont(14);
        [self.contentView addSubview:_contentLabel];
        
        _arrowImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize(17), 0, AutoSize(7), AutoSize(47))];
        _arrowImageView.contentMode = UIViewContentModeCenter;
        _arrowImageView.image = [UIImage imageNamed:@"left_arrow"];
        _arrowImageView.clipsToBounds = YES;
        [self.contentView addSubview:_arrowImageView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(98) - 0.5, SCREEN_WIDTH - AutoSize6(30), 0.5)];
        line.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:line];
    }
    return self;
}

- (void)setModel:(MineSetModel *)model {
    _model = model;
    
    _iconImageView.image = [UIImage imageNamed:model.iconUrl];
    _titleLabel.text = model.title;
    _contentLabel.text = model.detailText;
}

@end
