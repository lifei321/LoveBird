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

@end

@implementation LogContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        self.birdLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, SCREEN_WIDTH - AutoSize6(60), AutoSize6(94))];
        self.birdLabel.textAlignment = NSTextAlignmentLeft;
        self.birdLabel.textColor = kColorTextColor333333;
        self.birdLabel.font = kFont6(26);
        self.birdLabel.numberOfLines = 0;
        [self.contentView addSubview:self.birdLabel];
        
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, SCREEN_WIDTH - AutoSize6(60), AutoSize6(94))];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_iconImageView];
        

        
    }
    return self;
}

- (void)setBodyModel:(LogPostBodyModel *)bodyModel {
    _bodyModel = bodyModel;
    
    self.birdLabel.text = bodyModel.message;
    CGFloat height = [bodyModel.message getTextHeightWithFont:self.birdLabel.font withWidth:(SCREEN_WIDTH - AutoSize6(60))];
    self.birdLabel.height = height;
    
    CGFloat imageHeight = (bodyModel.imgHeight) * ((SCREEN_WIDTH - AutoSize6(60)) / bodyModel.imgWidth);
    _iconImageView.height = imageHeight;
    
    if (bodyModel.message.length) {
        _iconImageView.top = self.birdLabel.bottom + AutoSize6(30);
    } else {
        _iconImageView.top = self.birdLabel.bottom;
    }
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:bodyModel.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
}

+ (CGFloat)getHeightWithModel:(LogPostBodyModel *)model {
    CGFloat height = 0;
    
    height = [model.message getTextHeightWithFont:kFont6(26) withWidth:(SCREEN_WIDTH - AutoSize6(60))];
    
    if (model.message.length) {
        height += AutoSize6(30);
    }
    
    height += (model.imgHeight) * ((SCREEN_WIDTH - AutoSize6(60)) / model.imgWidth);
    height += AutoSize6(30);
    
    return height;

}

@end
