//
//  ThirdAcountTableViewCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ThirdAcountTableViewCell.h"

@interface ThirdAcountTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UISwitch *switchView;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation ThirdAcountTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImageView.contentMode = UIViewContentModeCenter;
        _iconImageView.layer.cornerRadius = _iconImageView.width / 2;
        _iconImageView.clipsToBounds = YES;
        [self.contentView addSubview:_iconImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
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
        _arrowImageView.image = [UIImage imageNamed:@"placeHolder"];
        _arrowImageView.clipsToBounds = YES;
        [self.contentView addSubview:_arrowImageView];
        
        _switchView = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize(57), 0, AutoSize(47), AutoSize(47))];
        [self.contentView addSubview:_switchView];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(94) - 0.5, SCREEN_WIDTH - AutoSize6(30), 0.5)];
        line.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:line];
    }
    return self;
}

@end
