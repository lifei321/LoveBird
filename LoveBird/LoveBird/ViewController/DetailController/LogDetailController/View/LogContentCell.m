//
//  LogContentCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/29.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogContentCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LogContentCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *birdLabel;

@property (nonatomic, strong) UILabel *tagLabel;


@end

@implementation LogContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        self.birdLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(20), SCREEN_WIDTH - AutoSize6(60), AutoSize6(94))];
        self.birdLabel.textAlignment = NSTextAlignmentLeft;
        self.birdLabel.textColor = kColorTextColor333333;
        self.birdLabel.font = kFont6(26);
        self.birdLabel.numberOfLines = 0;
        [self.contentView addSubview:self.birdLabel];
        
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(20), SCREEN_WIDTH - AutoSize6(60), AutoSize6(94))];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_iconImageView];
        
        self.tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(20), SCREEN_WIDTH - AutoSize6(60), AutoSize6(94))];
        self.tagLabel.textAlignment = NSTextAlignmentCenter;
        self.tagLabel.textColor = kColorTextColor333333;
        self.tagLabel.font = kFont6(22);
        self.tagLabel.backgroundColor = UIColorFromRGB(0xececec);
        self.tagLabel.layer.cornerRadius = 3;
        self.tagLabel.clipsToBounds = YES;
        [self.contentView addSubview:self.tagLabel];

        
    }
    return self;
}

- (void)setBodyModel:(LogPostBodyModel *)bodyModel {
    _bodyModel = bodyModel;
    
    self.birdLabel.text = bodyModel.message;
    CGFloat height = [bodyModel.message getTextHeightWithFont:self.birdLabel.font withWidth:(SCREEN_WIDTH - AutoSize6(60))];
    self.birdLabel.height = height;
    
    if (bodyModel.isImg) {
        CGFloat imageHeight = (bodyModel.imgHeight) * ((SCREEN_WIDTH - AutoSize6(60)) / bodyModel.imgWidth);
        _iconImageView.height = imageHeight;
        
        if (bodyModel.message.length) {
            _iconImageView.top = self.birdLabel.bottom + AutoSize6(30);
        } else {
            _iconImageView.top = self.birdLabel.bottom;
        }
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:bodyModel.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
        
        if (bodyModel.imgTag.length) {
            self.tagLabel.text = bodyModel.imgTag;
            CGFloat width = [bodyModel.imgTag getTextWightWithFont:self.tagLabel.font];
            self.tagLabel.frame = CGRectMake(_iconImageView.right - width - AutoSize6(40) , _iconImageView.bottom + AutoSize6(20), width + AutoSize6(40), AutoSize6(40));
        }
        
    } else {
        _iconImageView.height = 0;
        self.tagLabel.height = 0;
    }
}

+ (CGFloat)getHeightWithModel:(LogPostBodyModel *)model {
    CGFloat height = 0;
    
    height = [model.message getTextHeightWithFont:kFont6(26) withWidth:(SCREEN_WIDTH - AutoSize6(60))];
    
    if (model.message.length) {
        if (model.isImg) {
            height += AutoSize6(20);
        } else {
            height += AutoSize6(40);
        }
    }
    
    if (model.isImg) {
        height += (model.imgHeight) * ((SCREEN_WIDTH - AutoSize6(60)) / model.imgWidth);
        height += AutoSize6(30);
        
        if (model.imgTag.length) {
            height += AutoSize6(60);
        }
    }
    return height;
}





- (void)setContentModel:(LogPostBodyModel *)contentModel {
    _contentModel = contentModel;
    
    self.birdLabel.text = contentModel.content;
    CGFloat height = [contentModel.content getTextHeightWithFont:self.birdLabel.font withWidth:(SCREEN_WIDTH - AutoSize6(60))];
    self.birdLabel.height = height;
    
    if (contentModel.isImg) {
        CGFloat imageHeight = (contentModel.imgHeight) * ((SCREEN_WIDTH - AutoSize6(60)) / contentModel.imgWidth);
        _iconImageView.height = imageHeight;
        
        if (contentModel.content.length) {
            _iconImageView.top = self.birdLabel.bottom + AutoSize6(30);
        } else {
            _iconImageView.top = self.birdLabel.bottom;
        }
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:contentModel.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
        
        self.tagLabel.frame = CGRectZero;
//        if (contentModel.imgTag.length) {
//            self.tagLabel.text = contentModel.imgTag;
//            CGFloat width = [contentModel.imgTag getTextWightWithFont:self.tagLabel.font];
//            self.tagLabel.frame = CGRectMake(_iconImageView.right - width - AutoSize6(40) , _iconImageView.bottom + AutoSize6(20), width + AutoSize6(40), AutoSize6(40));
//        }
        
    } else {
        _iconImageView.height = 0;
        self.tagLabel.height = 0;
    }
}



+ (CGFloat)getHeightWithContentModel:(LogPostBodyModel *)model {
    CGFloat height = 0;
    
    height = [model.content getTextHeightWithFont:kFont6(26) withWidth:(SCREEN_WIDTH - AutoSize6(60))];
    
    if (model.content.length) {
        if (model.isImg) {
            height += AutoSize6(20);
        } else {
            height += AutoSize6(40);
        }
    }
    
    if (model.isImg) {
        height += (model.imgHeight) * ((SCREEN_WIDTH - AutoSize6(60)) / model.imgWidth);
        height += AutoSize6(30);
        
//        if (model.imgTag.length) {
//            height += AutoSize6(60);
//        }
    }
    return height;
}

@end
