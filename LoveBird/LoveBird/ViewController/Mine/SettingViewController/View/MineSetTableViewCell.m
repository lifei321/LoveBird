//
//  MineSetTableViewCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/5.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineSetTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SetDao.h"


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
        self.clipsToBounds = YES;
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.iconImageView.contentMode = UIViewContentModeScaleToFill;
        _iconImageView.layer.cornerRadius = _iconImageView.width / 2;
        _iconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = kFont(14);
        [self.contentView addSubview:_titleLabel];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize(100), 0, AutoSize(60), AutoSize6(94))];
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.textColor = UIColorFromRGB(0x7f7f7f);
        _contentLabel.font = kFontPF6(24);
        [self.contentView addSubview:_contentLabel];
        
        _arrowImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize(17), 0, AutoSize(7), AutoSize6(94))];
        _arrowImageView.contentMode = UIViewContentModeCenter;
        _arrowImageView.image = [UIImage imageNamed:@"left_arrow"];
        _arrowImageView.clipsToBounds = YES;
        [self.contentView addSubview:_arrowImageView];
        
        _switchView = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(124), AutoSize6(18), AutoSize6(94), AutoSize6(58))];
        [self.contentView addSubview:_switchView];
        [_switchView addTarget:self action:@selector(switchViewDidClick:) forControlEvents:UIControlEventValueChanged];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(94) - 0.5, SCREEN_WIDTH - AutoSize6(60), 0.5)];
        line.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:line];
    }
    return self;
}


- (void)setModel:(MineSetModel *)model {
    _model = model;
    _titleLabel.text = model.title;
    _contentLabel.text = model.detailText;
    
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
            
            NSString *system = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",kSystem, [UserPage sharedInstance].uid]];
            NSString *comment = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",kTalk, [UserPage sharedInstance].uid]];
            NSString *follow = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",kFollow, [UserPage sharedInstance].uid]];

            if ([model.title isEqualToString:@"系统消息"]) {
                _switchView.on = system.length ? system.boolValue : YES;
            } else if ([model.title isEqualToString:@"评论我"]) {
                _switchView.on = comment.length ? comment.boolValue : YES;

            } else if ([model.title isEqualToString:@"关注我"]) {
                _switchView.on = follow.length ? follow.boolValue : YES;
            }
            
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


- (void)switchViewDidClick:(UISwitch *)switchView {
    
    NSString *system = [UserPage sharedInstance].userModel.system.length ? [UserPage sharedInstance].userModel.system : @"1";
    NSString *commont = [UserPage sharedInstance].userModel.comment.length ? [UserPage sharedInstance].userModel.comment : @"1";
    NSString *follow = [UserPage sharedInstance].userModel.follow.length ? [UserPage sharedInstance].userModel.follow : @"1";

    if ([self.model.title isEqualToString:@"系统消息"]) {
        system = [NSString stringWithFormat:@"%d", switchView.on];
        
    } else if ([self.model.title isEqualToString:@"评论我"]) {
        commont = [NSString stringWithFormat:@"%d", switchView.on];

    } else if ([self.model.title isEqualToString:@"关注我"]) {
        follow = [NSString stringWithFormat:@"%d", switchView.on];
    }
    
    
    [SetDao setPush:system talk:commont follow:follow SuccessBlock:^(__kindof AppBaseModel *responseObject) {
        
        [UserPage sharedInstance].userModel.system = system;
        [UserPage sharedInstance].userModel.comment = commont;
        [UserPage sharedInstance].userModel.follow = follow;
        [[NSUserDefaults standardUserDefaults] setObject:system  forKey:[NSString stringWithFormat:@"%@%@",kSystem, [UserPage sharedInstance].uid]];
        [[NSUserDefaults standardUserDefaults] setObject:commont  forKey:[NSString stringWithFormat:@"%@%@",kTalk, [UserPage sharedInstance].uid]];
        [[NSUserDefaults standardUserDefaults] setObject:follow  forKey:[NSString stringWithFormat:@"%@%@",kFollow, [UserPage sharedInstance].uid]];

    } failureBlock:^(__kindof AppBaseModel *error) {
        
    }];
}
@end
