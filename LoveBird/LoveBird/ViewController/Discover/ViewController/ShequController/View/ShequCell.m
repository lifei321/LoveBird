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
#import "ShequBottomView.h"


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

@property (nonatomic, strong) ShequBottomView *bottomView;


@end

@implementation ShequCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
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
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = kFont6(20);
        self.timeLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self.backView addSubview:self.timeLabel];
        
        self.bottomView = [[ShequBottomView alloc] initWithFrame:CGRectZero];
        [self.backView addSubview:self.bottomView];
        
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
    self.bottomView.frame = shequFrameModel.bottomViewFrame;
    self.timeLabel.frame = shequFrameModel.timeLabelFrame;
    
    self.titleLable.text = shequFrameModel.shequModel.subject;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:shequFrameModel.shequModel.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.bottomView.model = shequFrameModel.shequModel;
    self.timeLabel.text = [[AppDateManager shareManager] getDateWithTime:shequFrameModel.shequModel.dateline formatSytle:DateFormatYMD];
}

- (void)drawRect:(CGRect)rect {
    
    //定义画图的path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    //path移动到开始画图的位置
    [path moveToPoint:CGPointMake(AutoSize6(125), AutoSize6(80))];
    
    //从开始位置画一条直线到（rect.origin.x + rect.size.width， rect.origin.y）
    [path addLineToPoint:CGPointMake(AutoSize6(140), AutoSize6(58))];
    
    //再从rect.origin.x + rect.size.width， rect.origin.y））画一条线到(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height)
    [path addLineToPoint:CGPointMake(AutoSize6(155), AutoSize6(80))];
    
    //关闭path
    [path closePath];

    //三角形内填充颜色
    [[UIColor whiteColor] setFill];
    
    [path fill];
}

@end
