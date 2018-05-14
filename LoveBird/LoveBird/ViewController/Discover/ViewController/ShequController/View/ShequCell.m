//
//  ShequCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/14.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ShequCell.h"
#import "ShequCellHeadView.h"



@interface ShequCell()

@property (nonatomic, strong) ShequCellHeadView *headView;

@property (nonatomic, strong) UIView *backView;

// 标题
@property (nonatomic, strong) UILabel *titleLable;

// 内容图片
@property (nonatomic, strong) UIImageView *contentImageView;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ShequCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.headView = [[ShequCellHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(75))];
        [self.contentView addSubview:self.headView];
        
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(95), self.headView.bottom, AutoSize6(626), 0)];
        self.backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.backView];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(20), AutoSize6(25), self.backView.width - AutoSize6(40), 0)];
        self.titleLable.font = kFontDiscoverTitle;
        self.titleLable.textColor = UIColorFromRGB(0x333333);
        self.titleLable.textAlignment = NSTextAlignmentLeft;
        self.titleLable.numberOfLines = 0;
        [self addSubview:self.titleLable];
        
        self.contentImageView = [[UIImageView alloc] init];
        self.contentImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.contentImageView];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(20), AutoSize6(25), self.backView.width - AutoSize6(40), 0)];
        self.timeLabel.font = kFont6(20);
        self.timeLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.timeLabel];
        
    }
    return self;
}


@end
