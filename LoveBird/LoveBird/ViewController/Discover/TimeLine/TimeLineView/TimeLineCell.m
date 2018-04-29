//
//  TimeLineCell.m
//  LFBaseProject
//
//  Created by ShanCheli on 2018/1/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "TimeLineCell.h"
#import "TimeLineTittleView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TimeLineBottomView.h"


@interface TimeLineCell()<TimeLineToolClickDelegate, FollowButtonDidClickDelegate>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) TimeLineTittleView *titleView;

// 内容图片
@property (nonatomic, strong) UIImageView *contentImageView;

// 文章标题
@property (nonatomic, strong) UILabel *titleLabel;

// 文章内容
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) TimeLineBottomView *toolView;

@end

@implementation TimeLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 顶部view
        self.topView = [[UIView alloc] initWithFrame:CGRectZero];
        UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize(1))];
        topLine.backgroundColor = [UIColor clearColor];
        self.topView.backgroundColor = UIColorFromRGB(0xececec);
        [self.topView addSubview:topLine];
        [self.contentView addSubview:self.topView];
        
        // 昵称
        self.titleView = [[TimeLineTittleView alloc] initWithFrame:CGRectZero];
        self.titleView.followDelegate = self;
        [self.contentView addSubview:self.titleView];
        
        // 图片 不一定存在
        self.contentImageView = [[UIImageView alloc] init];
        self.contentImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.contentImageView];
        
        // 文章标题
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = kFontDiscoverTitle;
        self.titleLabel.textColor = UIColorFromRGB(0x333333);
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        
        // 文章内容
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = kFontDiscoverContent;
        self.contentLabel.textColor = UIColorFromRGB(0x7f7f7f);
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.numberOfLines = 3;
        [self.contentView addSubview:self.contentLabel];

        // 底部线
        self.bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        self.bottomView.backgroundColor = UIColorFromRGB(0xececec);
        bottomLine.backgroundColor = UIColorFromRGB(0xececec);
        [self.bottomView addSubview:bottomLine];
        [self.contentView addSubview:self.bottomView];
        
        // 工具条
        self.toolView = [[TimeLineBottomView alloc] initWithFrame:CGRectZero];
        self.toolView.timeLineToolDelegate = self;
        [self.contentView addSubview:self.toolView];
    }
    return self;
}


- (void)setCellLayoutModel:(TimeLineLayoutModel *)cellLayoutModel {
    _cellLayoutModel = cellLayoutModel;
    
    _topView.frame = cellLayoutModel.topViewFrame;
    _titleView.frame = cellLayoutModel.titleViewFrame;
    _contentImageView.frame = cellLayoutModel.contentImageViewFrame;
    _titleLabel.frame = cellLayoutModel.titleLabelFrame;
    _contentLabel.frame = cellLayoutModel.contentLabelFrame;
    _bottomView.frame = cellLayoutModel.bottomViewFrame;
    _toolView.frame = cellLayoutModel.toolViewFrame;
    
    _titleView.contentModel = cellLayoutModel.contentModel;
    [_contentImageView sd_setImageWithURL:[NSURL URLWithString:cellLayoutModel.contentModel.imgUrl] placeholderImage:[UIImage imageNamed:@"holder"]];
    _titleLabel.text = cellLayoutModel.contentModel.subject;
    _contentLabel.text = cellLayoutModel.contentModel.summary;
    
}

- (void)followButtonClickDelegate:(UIButton *)button {
    if (self.timeLineCellDelegate && [self.timeLineCellDelegate respondsToSelector:@selector(timeLine:didClickDelegate:)]) {
        [self.timeLineCellDelegate timeLine:self didClickDelegate:button];
    }
}


- (void)timeLineToolClickDelegate:(UIButton *)button {
    if (self.timeLineCellDelegate && [self.timeLineCellDelegate respondsToSelector:@selector(timeLine:didClickDelegate:)]) {
        [self.timeLineCellDelegate timeLine:self didClickDelegate:button];
    }
}








@end
