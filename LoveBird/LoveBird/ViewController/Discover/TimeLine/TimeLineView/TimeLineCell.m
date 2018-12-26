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

@property (nonatomic, strong) UILabel *imageCountLabel;


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
        
        self.imageCountLabel = [[UILabel alloc] init];
        self.imageCountLabel.font = kFontPF6(28);
        self.imageCountLabel.textColor = UIColorFromRGB(0xffffff);
        self.imageCountLabel.backgroundColor = UIColorFromRGBWithAlpha(0x000000,0.5);
        self.imageCountLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentImageView addSubview:self.imageCountLabel];

        
        // 文章标题
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:AutoSize6(30)];
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
    
    if (cellLayoutModel.contentModel) {
        
        _titleView.contentModel = cellLayoutModel.contentModel;
        NSString *utString = [cellLayoutModel.contentModel.imgUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSURL *url = [NSURL URLWithString:utString];
        [_contentImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        _titleLabel.text = cellLayoutModel.contentModel.subject;
        _contentLabel.text = cellLayoutModel.contentModel.summary;
        _toolView.contentModel = cellLayoutModel.contentModel;
        
        if (cellLayoutModel.contentModel.show_picsum.integerValue) {
            self.imageCountLabel.hidden = NO;

            self.imageCountLabel.frame = CGRectMake(0, self.contentImageView.height - AutoSize6(54), AutoSize6(100), AutoSize6(54));
            self.imageCountLabel.text = [NSString stringWithFormat:@"%@张", cellLayoutModel.contentModel.picsum];
        } else {
            self.imageCountLabel.hidden = YES;
        }

        
    } else if (cellLayoutModel.zhuangbeiModel) {
        
        NSString *utString = [cellLayoutModel.zhuangbeiModel.img stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSURL *url = [NSURL URLWithString:utString];
        [_contentImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        _titleLabel.text = cellLayoutModel.zhuangbeiModel.title;
        _contentLabel.text = cellLayoutModel.zhuangbeiModel.summary;
        _toolView.zhuangbeiModel = cellLayoutModel.zhuangbeiModel;
    }
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
