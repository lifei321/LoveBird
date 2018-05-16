//
//  ShequCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/14.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ShequCell.h"
#import "ShequCellHeadView.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface ShequCell()

@property (nonatomic, strong) ShequCellHeadView *headView;

@property (nonatomic, strong) UIView *backView;

// 标题
@property (nonatomic, strong) UILabel *titleLable;

// 内容图片
@property (nonatomic, strong) UIImageView *contentImageView;

// 线
@property (nonatomic, strong) UIView *lineView;


@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ShequCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.headView = [[ShequCellHeadView alloc] init];
        [self.contentView addSubview:self.headView];
        
        self.backView = [[UIView alloc] init];
        self.backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.backView];
        
        self.titleLable = [[UILabel alloc] init];
        self.titleLable.font = kFontDiscoverTitle;
        self.titleLable.textColor = UIColorFromRGB(0x333333);
        self.titleLable.textAlignment = NSTextAlignmentLeft;
        self.titleLable.numberOfLines = 0;
        [self.backView addSubview:self.titleLable];
        
        self.contentImageView = [[UIImageView alloc] init];
        self.contentImageView.contentMode = UIViewContentModeScaleToFill;
        [self.backView addSubview:self.contentImageView];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = kColorTextColord2d2d2;
        [self.contentView addSubview:self.lineView];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(20), AutoSize6(25), self.backView.width - AutoSize6(40), 0)];
        self.timeLabel.font = kFont6(20);
        self.timeLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self.backView addSubview:self.timeLabel];
        
    }
    return self;
}

- (void)setShequFrameModel:(ShequFrameModel *)shequFrameModel {
    _shequFrameModel = shequFrameModel;
    self.accessoryType = UITableViewCellStyleDefault;
    self.headView.shequModel = shequFrameModel.shequModel;
    self.headView.frame = shequFrameModel.headViewFrame;
    self.backView.frame = shequFrameModel.backViewFrame;
    self.titleLable.frame = shequFrameModel.titleLabelFrame;
    self.contentImageView.frame = shequFrameModel.contentImageViewFrame;
    self.lineView.frame = shequFrameModel.lineViewFrame;
    
    self.titleLable.text = shequFrameModel.shequModel.subject;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:shequFrameModel.shequModel.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
}


@end
