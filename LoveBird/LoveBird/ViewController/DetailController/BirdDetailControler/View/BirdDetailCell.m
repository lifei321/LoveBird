//
//  BirdDetailCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BirdDetailCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;


@end

@implementation BirdDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(52), AutoSize6(20), AutoSize6(4), AutoSize6(28))];
        lineView.backgroundColor = kColorDefaultColor;
        [self.contentView addSubview:lineView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(75), AutoSize6(20), SCREEN_WIDTH - AutoSize6(230), AutoSize6(28))];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = UIColorFromRGB(0x000000);
        self.titleLabel.font = kFont6(25);
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(52), lineView.bottom + AutoSize6(20), SCREEN_WIDTH - AutoSize6(100), AutoSize6(92))];
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.textColor = [UIColor blackColor];
        self.contentLabel.font = kFont6(26);
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentLabel.left, self.contentLabel.bottom + AutoSize6(10), self.contentLabel.width, AutoSize6(92))];
        self.iconImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_iconImageView];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
    self.iconImageView.hidden = YES;
}

- (void)setDetailModel:(BirdDetailModel *)detailModel {
    _detailModel = detailModel;
    
}

- (void)setDetail:(NSString *)detail {
    self.iconImageView.hidden = YES;
    self.contentLabel.text = detail;
    
    CGFloat height = [detail getTextHeightWithFont:self.contentLabel.font withWidth:self.contentLabel.width];
    self.contentLabel.height = height + AutoSize6(20);
}

- (void)setHasImage:(BOOL)hasImage {
    self.iconImageView.hidden = NO;
    
    if (_detailModel.hand_drawing_img.length) {
        CGFloat imageHeight = (_detailModel.hand_drawing_height) * (self.iconImageView.width / _detailModel.hand_drawing_width);
        self.iconImageView.height = imageHeight + AutoSize6(10);
        self.iconImageView.top = self.contentLabel.bottom + AutoSize6(20);
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_detailModel.hand_drawing_img] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    }
    
}

+ (CGFloat)getHeightWithModel:(BirdDetailModel *)model text:(NSString *)text img:(BOOL)img {
    CGFloat height = 0;
    
    if (text.length) {
        height += AutoSize6(48);
        CGFloat textheight = [text getTextHeightWithFont:kFont6(30) withWidth: SCREEN_WIDTH - AutoSize6(100)];
        height += textheight + AutoSize6(40);
    }
    
    if (img) {
        CGFloat imageHeight = (model.hand_drawing_height) * ((SCREEN_WIDTH - AutoSize6(100)) / model.hand_drawing_width);
        height += AutoSize6(20) + imageHeight;
    }
    
    return height;
}




@end
