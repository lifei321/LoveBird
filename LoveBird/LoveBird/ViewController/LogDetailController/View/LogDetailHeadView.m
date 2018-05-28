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
        
        // 文章标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, SCREEN_WIDTH - AutoSize6(60), 0)];
        self.titleLabel.font = kFontDiscoverTitle;
        self.titleLabel.textColor = UIColorFromRGB(0x333333);
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
        
        // 昵称
        self.titleView = [[LogDetailTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize(60))];
        //        self.titleView.followDelegate = self;
        [self addSubview:self.titleView];
    }
    return self;
}

- (void)setDetailModel:(LogDetailModel *)detailModel {
    _detailModel = detailModel;
    
    CGFloat imageHeight = (detailModel.coverImgHeight) * (SCREEN_WIDTH / detailModel.coverImgWidth);
    self.contentImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, imageHeight);
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.coverImgUrl] placeholderImage:[UIImage imageNamed:@" "]];

    CGFloat titleHeight = [detailModel.title getTextHeightWithFont:self.titleLabel.font withWidth:self.titleLabel.width];
    self.titleLabel.text = detailModel.title;
    self.titleLabel.top = self.contentImageView.bottom + AutoSize6(30);
    self.titleLabel.height = titleHeight;
    
    self.titleView.top = self.titleLabel.bottom + AutoSize6(30);
    self.titleView.detailModel = detailModel;
    
}

- (CGFloat)getHeight {
    
    return self.titleView.bottom;
    
}

@end
