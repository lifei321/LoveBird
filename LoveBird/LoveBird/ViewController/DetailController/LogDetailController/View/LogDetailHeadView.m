//
//  LogDetailHeadView.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogDetailHeadView.h"
#import "LogDetailTitleView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LogDetailHeadView()

// 内容图片
@property (nonatomic, strong) UIImageView *contentImageView;

// 文章标题
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) LogDetailTitleView *titleView;

@property (nonatomic, strong) UIButton *countButton;

@end

@implementation LogDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        // 图片 不一定存在
        self.contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(100))];
        self.contentImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.contentImageView];
        
        // 观看次数
        self.countButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(100), 0, AutoSize6(80), AutoSize6(70))];
        [self.contentImageView addSubview:self.countButton];
        [self.countButton setImage:[UIImage imageNamed:@"detailview"] forState:UIControlStateNormal];
        [self.countButton setIconInLeftWithSpacing:AutoSize6(20)];
        self.countButton.titleLabel.font = kFont6(26);

        // 文章标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, SCREEN_WIDTH - AutoSize6(60), 0)];
        self.titleLabel.font = kFontPF6(30);
        self.titleLabel.textColor = UIColorFromRGB(0x333333);
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
        
        // 昵称
        self.titleView = [[LogDetailTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(115))];
        //        self.titleView.followDelegate = self;
        [self addSubview:self.titleView];
    }
    return self;
}

- (void)setDetailModel:(LogDetailModel *)detailModel {
    _detailModel = detailModel;
    
    if (detailModel.coverImgUrl.length) {
        if (detailModel.coverImgWidth > 0) {
            CGFloat imageHeight = (detailModel.coverImgHeight) * (SCREEN_WIDTH / detailModel.coverImgWidth);
            self.contentImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, imageHeight);
            [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.coverImgUrl] placeholderImage:[UIImage imageNamed:@" "]];
        } else {
            self.contentImageView.frame = CGRectZero;
        }
    } else {
        self.contentImageView.frame = CGRectZero;
    }

    CGFloat titleHeight = [detailModel.title getTextHeightWithFont:self.titleLabel.font withWidth:self.titleLabel.width];
    self.titleLabel.text = detailModel.title;
    self.titleLabel.top = self.contentImageView.bottom + AutoSize6(30);
    self.titleLabel.height = titleHeight;
    
    self.titleView.top = self.titleLabel.bottom + AutoSize6(20);
    self.titleView.detailModel = detailModel;
    
    if (detailModel.viewNum.length && detailModel.coverImgUrl.length) {
        [self.countButton setTitle:detailModel.viewNum forState:UIControlStateNormal];
        self.countButton.hidden = NO;

    } else {
        self.countButton.hidden = YES;
    }
    
}

- (void)setContentModel:(LogContentModel *)contentModel {
    _contentModel = contentModel;
    
    if (contentModel.coverImgUrl.length) {
        CGFloat imageHeight = (contentModel.coverImgHeight) * (SCREEN_WIDTH / contentModel.coverImgWidth);
        self.contentImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, imageHeight);
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:contentModel.coverImgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    } else {
        self.contentImageView.frame = CGRectZero;
    }
    
    CGFloat titleHeight = [contentModel.title getTextHeightWithFont:self.titleLabel.font withWidth:self.titleLabel.width];
    self.titleLabel.text = contentModel.title;
    self.titleLabel.top = self.contentImageView.bottom + AutoSize6(20);
    self.titleLabel.height = titleHeight;
    
    self.titleView.top = self.titleLabel.bottom + AutoSize6(20);
    self.titleView.contentModel = contentModel;
    if (contentModel.viewNum.length && contentModel.coverImgUrl.length) {
        [self.countButton setTitle:contentModel.viewNum forState:UIControlStateNormal];
        self.countButton.hidden = NO;
        
    } else {
        self.countButton.hidden = YES;
    }


}

- (CGFloat)getHeight {
    
    return self.titleView.bottom;
    
}

@end
