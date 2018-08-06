//
//  GuideCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/18.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "GuideCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GuideHeadView.h"

@interface GuideCell ()

@property (nonatomic, strong) UIView *bottonView;

@property (nonatomic, strong) GuideHeadView *titleView;

// 内容图片
@property (nonatomic, strong) UIImageView *contentImageView;

// 文章标题
@property (nonatomic, strong) UILabel *titleLabel;

// 文章内容
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation GuideCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
        // 昵称
        self.titleView = [[GuideHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(119))];
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
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.timeLabel = [[UILabel alloc] init];
        self.timeLabel.font = kFontDiscoverContent;
        self.timeLabel.textColor = UIColorFromRGB(0x7f7f7f);
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.timeLabel];
        
        self.bottonView = [[UIView alloc] init];
        self.bottonView.backgroundColor = kColorViewBackground;
        [self.contentView addSubview:self.bottonView];
    }
    return self;
}

- (void)setModel:(GuideModel *)model {
    _model = model;
    self.titleView.model = model;
    
    if (model.imgUrl.length) {
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        CGFloat imageHeight = (model.imgHeight) * (SCREEN_WIDTH / model.imgWidth);
        self.contentImageView.frame = CGRectMake(0, self.titleView.bottom, SCREEN_WIDTH, imageHeight);
    } else {
        self.contentImageView.frame = CGRectMake(0, self.titleView.bottom, SCREEN_WIDTH, 0);
    }
    
    if (model.subject.length) {
        CGFloat titleLabelHeight = [model.subject getTextHeightWithFont:self.titleLabel.font withWidth:(SCREEN_WIDTH - AutoSize6(60))];
        self.titleLabel.frame = CGRectMake(AutoSize6(30), self.contentImageView.bottom + AutoSize6(20), SCREEN_WIDTH - AutoSize6(60), titleLabelHeight);
        self.titleLabel.text = model.subject;
    }
    
    NSString *placeString = model.cost;
    NSString *textString = [NSString stringWithFormat:@"价格 %@", placeString];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:textString];
    [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColorLightGraya2a2a2 range:NSMakeRange(0, 3)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, placeString.length)];
    
    [attrString addAttribute:NSFontAttributeName value:kFont6(24) range:NSMakeRange(0, 3)];
    [attrString addAttribute:NSFontAttributeName value:kFont6(40) range:NSMakeRange(3, placeString.length)];

    self.contentLabel.attributedText = attrString;
    self.contentLabel.frame = CGRectMake(AutoSize6(30), self.titleLabel.bottom + AutoSize6(20), SCREEN_WIDTH / 3, AutoSize6(50));
    
    NSString *start = [[AppDateManager shareManager] getDateWithTime:model.dateStart formatSytle:DateFormatMD2];
    NSString *end = [[AppDateManager shareManager] getDateWithTime:model.dateEnd formatSytle:DateFormatMD2];

    self.timeLabel.text = [NSString stringWithFormat:@"出团日期：%@ - %@", start, end];
    self.timeLabel.frame = CGRectMake(SCREEN_WIDTH / 2, self.contentLabel.top, SCREEN_WIDTH / 2 - AutoSize6(30), self.contentLabel.height);
    
    self.bottonView.frame = CGRectMake(0, self.contentLabel.bottom, SCREEN_WIDTH, AutoSize6(20));
}

+ (CGFloat)getHeight:(GuideModel *)model {
    CGFloat height = 0;
    
    height = AutoSize6(119);
    
    if (model.imgUrl.length) {
        CGFloat imageHeight = (model.imgHeight) * (SCREEN_WIDTH / model.imgWidth);
        height += imageHeight;
    }
    
    if (model.subject.length) {
        CGFloat titleLabelHeight = [model.subject getTextHeightWithFont:kFontDiscoverTitle withWidth:(SCREEN_WIDTH - AutoSize6(60))];
        height += titleLabelHeight;
        height += AutoSize6(20);
    }
    
    height += AutoSize6(70);
    
    height += AutoSize6(20);
    
    return height;
}

@end
