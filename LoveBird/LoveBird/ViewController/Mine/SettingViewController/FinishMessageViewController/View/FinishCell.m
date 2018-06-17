//
//  FinishCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/17.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FinishCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FinishCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *arrowImageView;


@end


@implementation FinishCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, AutoSize6(150), AutoSize6(94))];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = kFont(14);
        [self.contentView addSubview:_titleLabel];
        
        _arrowImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize(17), 0, AutoSize(7), AutoSize(47))];
        _arrowImageView.contentMode = UIViewContentModeCenter;
        _arrowImageView.image = [UIImage imageNamed:@"left_arrow"];
        _arrowImageView.clipsToBounds = YES;
        [self.contentView addSubview:_arrowImageView];
        
        
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.right + AutoSize6(20), 0, SCREEN_WIDTH / 2, AutoSize6(94))];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = kColorTextColorLightGraya2a2a2;
        _contentLabel.font = kFont(14);
        [self.contentView addSubview:_contentLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(94) - 0.5, SCREEN_WIDTH - AutoSize6(30), 0.5)];
        line.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:line];
    }
    return self;
}


- (void)setModel:(MineSetModel *)model {
    _model = model;
    _titleLabel.text = model.title;
    
    if ([model.type isEqualToString:@"100"]) {
        _contentLabel.textColor = kColorDefaultColor;
    } else {
        _contentLabel.textColor = kColorTextColorLightGraya2a2a2;
    }
    
    if ([model.type isEqualToString:@"200"]) {
        if (model.detailText.length) {
            _contentLabel.textColor = kColorTextColorLightGraya2a2a2;
        } else {
            model.detailText = @"请绑定手机号";
            _contentLabel.textColor = kColorTextColorOrangeED7338;
        }
    }
    
    _contentLabel.text = model.detailText;

}

@end
