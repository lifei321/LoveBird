//
//  BirdLookTableViewCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/8/5.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdLookTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MineLogLineView.h"

@interface BirdLookTableViewCell()


@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *iconImageView;

// 标题
@property (nonatomic, strong) UILabel *titleLable;

// 内容图片
@property (nonatomic, strong) UIImageView *contentImageView;

// 线
@property (nonatomic, strong) MineLogLineView *lineView;


@property (nonatomic, strong) UILabel *timeLabel;


@property (nonatomic, strong) UILabel *subjectLable;


@property (nonatomic, strong) UILabel *countLabel;


@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) UILabel *dayLable;

@property (nonatomic, strong) UILabel *monthLable;


@end


@implementation BirdLookTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        self.backView = [[UIView alloc] init];
        self.backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.backView];
        
        self.dayLable = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(20), AutoSize6(25), self.backView.width - AutoSize6(40), 0)];
        self.dayLable.font = kFont6(27);
        self.dayLable.textColor = kColorTextColor3c3c3c;
        self.dayLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.dayLable];
        
        self.monthLable = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(20), AutoSize6(25), self.backView.width - AutoSize6(40), 0)];
        self.monthLable.font = kFont6(17);
        self.monthLable.textColor = kColorTextColor333333;
        self.monthLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.monthLable];
        
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.contentMode = UIViewContentModeCenter;
        self.iconImageView.image = [UIImage imageNamed:@"adress_grey"];
        [self.backView addSubview:self.iconImageView];
        
        self.titleLable = [[UILabel alloc] init];
        self.titleLable.font = kFontDiscoverTitle;
        self.titleLable.textColor = UIColorFromRGB(0x333333);
        self.titleLable.textAlignment = NSTextAlignmentLeft;
        self.titleLable.numberOfLines = 0;
        [self.backView addSubview:self.titleLable];
        
        self.contentImageView = [[UIImageView alloc] init];
        self.contentImageView.contentMode = UIViewContentModeScaleToFill;
        [self.backView addSubview:self.contentImageView];
        
        self.lineView = [[MineLogLineView alloc] init];
        [self.contentView addSubview:self.lineView];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(20), AutoSize6(25), self.backView.width - AutoSize6(40), 0)];
        self.timeLabel.font = kFont6(20);
        self.timeLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self.backView addSubview:self.timeLabel];
        
        self.subjectLable = [[UILabel alloc] init];
        self.subjectLable.font = kFont6(20);
        self.subjectLable.textColor = kColorTextColorLightGraya2a2a2;
        self.subjectLable.textAlignment = NSTextAlignmentLeft;
        [self.backView addSubview:self.subjectLable];
        
        self.countLabel = [[UILabel alloc] init];
        self.countLabel.font = kFont6(20);
        self.countLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.countLabel.textAlignment = NSTextAlignmentRight;
        [self.backView addSubview:self.countLabel];
        
        self.moreButton = [[UIButton alloc] init];
        [self.backView addSubview:self.moreButton];
    }
    return self;
}

- (void)setFrameModel:(MineLogFrameModel *)frameModel {
    _frameModel = frameModel;
    self.accessoryType = UITableViewCellStyleDefault;
    self.backView.frame = frameModel.backViewFrame;
    
    self.iconImageView.frame = CGRectMake(frameModel.titleLabelFrame.origin.x, frameModel.titleLabelFrame.origin.y, AutoSize6(12), frameModel.titleLabelFrame.size.height);
    self.titleLable.frame = CGRectMake(self.iconImageView.right + AutoSize6(10), self.iconImageView.top, frameModel.titleLabelFrame.size.width, frameModel.titleLabelFrame.size.height);
    self.contentImageView.frame = frameModel.contentImageViewFrame;
    self.lineView.isFirst = frameModel.isFirst;
    self.lineView.frame = frameModel.lineViewFrame;
    self.subjectLable.frame = frameModel.subjectLabelFrame;
    self.moreButton.frame = frameModel.moreButtonFrame;
    self.timeLabel.frame = frameModel.timeLabelFrame;
    self.dayLable.frame = frameModel.dayLabelFrame;
    self.monthLable.frame = frameModel.monthLabelFrame;
    
//    self.countLabel.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    self.titleLable.text = frameModel.shequModel.subject;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:frameModel.shequModel.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.timeLabel.text = frameModel.shequModel.dateline;
    self.subjectLable.text = frameModel.shequModel.author;
    self.dayLable.text = [[AppDateManager shareManager] getDateWithTime:frameModel.shequModel.dateline formatSytle:DateFormatD];
    self.monthLable.text = [[AppDateManager shareManager] getMonthWithTime:frameModel.shequModel.dateline];
}


- (void)drawRect:(CGRect)rect {
    
    //定义画图的path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    //path移动到开始画图的位置
    [path moveToPoint:CGPointMake(AutoSize6(100), AutoSize6(30))];
    
    //从开始位置画一条直线到（rect.origin.x + rect.size.width， rect.origin.y）
    [path addLineToPoint:CGPointMake(AutoSize6(87), AutoSize6(30))];
    
    //再从rect.origin.x + rect.size.width， rect.origin.y））画一条线到(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height)
    [path addLineToPoint:CGPointMake(AutoSize6(100), AutoSize6(43))];
    
    //关闭path
    [path closePath];
    
    //三角形内填充颜色
    [[UIColor whiteColor] setFill];
    
    [path fill];
}

@end
