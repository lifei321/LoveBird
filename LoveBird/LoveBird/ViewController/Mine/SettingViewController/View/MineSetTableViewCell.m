//
//  MineSetTableViewCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/5.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineSetTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>



@interface MineSetTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UISwitch *switchView;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation MineSetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.layer.cornerRadius = _iconImageView.width / 2;
        _iconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = kFont(14);
        [self.contentView addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize(77), 0, AutoSize(60), AutoSize6(94))];
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = kFont(14);
        [self.contentView addSubview:_contentLabel];
        
        _arrowImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize(17), 0, AutoSize(7), AutoSize6(94))];
        _arrowImageView.contentMode = UIViewContentModeCenter;
        _arrowImageView.image = [UIImage imageNamed:@"left_arrow"];
        _arrowImageView.clipsToBounds = YES;
        [self.contentView addSubview:_arrowImageView];
        
        _switchView = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(124), AutoSize6(18), AutoSize6(94), AutoSize6(58))];
        [self.contentView addSubview:_switchView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(94) - 0.5, SCREEN_WIDTH - AutoSize6(30), 0.5)];
        line.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:line];
    }
    return self;
}


- (void)setModel:(MineSetModel *)model {
    _model = model;
    _titleLabel.text = model.title;
    
    if (model.iconUrl.length) {
        _iconImageView.hidden = NO;
        _arrowImageView.hidden = NO;
        _contentLabel.hidden = YES;
        _switchView.hidden = YES;
        
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        _iconImageView.frame = CGRectMake(AutoSize6(30), AutoSize6(10), AutoSize6(74), AutoSize6(74));
        _iconImageView.layer.cornerRadius = _iconImageView.width / 2;

        _titleLabel.frame = CGRectMake(_iconImageView.right + AutoSize(5), 0, SCREEN_WIDTH / 2, self.height);
        
    } else {
        _iconImageView.hidden = YES;
        _titleLabel.frame = CGRectMake(AutoSize6(30), 0, SCREEN_WIDTH / 2, self.height);

        if (model.isShowSwitch) {
            _arrowImageView.hidden = YES;
            _contentLabel.hidden = YES;
            _switchView.hidden = NO;
        } else {
            _switchView.hidden = YES;
            if (model.isShowContent) {
                _contentLabel.hidden = NO;
                _arrowImageView.hidden = NO;
            } else {
                _contentLabel.hidden = YES;
                _arrowImageView.hidden = NO;
            }
        }
    }
}


@end
