//
//  MineBirdLeftCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/26.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineBirdLeftCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MineBirdLeftBackView.h"

#define kWidthForBackView (SCREEN_WIDTH / 2 - AutoSize6(35))

@interface MineBirdLeftCell()

@property (nonatomic, strong) MineBirdLeftBackView *backView;

// 标题
@property (nonatomic, strong) UILabel *titleLable;

// 内容图片
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *timeLabel;


@end

@implementation MineBirdLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
//        self.backView = [self makeBackView];
        self.backView = [[MineBirdLeftBackView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(44), kWidthForBackView, AutoSize6(84))];
        self.backView.isLeft = YES;
        [self.contentView addSubview:self.backView];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(5), AutoSize6(5), AutoSize6(74), AutoSize6(74))];
        self.iconImageView.layer.cornerRadius = self.iconImageView.width / 2;
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.iconImageView.clipsToBounds = YES;
        [self.backView addSubview:self.iconImageView];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.right + AutoSize6(20), 0, AutoSize6(300), AutoSize6(84))];
        self.titleLable.font = kFont6(26);
        self.titleLable.textColor = UIColorFromRGB(0x666666);
        self.titleLable.textAlignment = NSTextAlignmentLeft;
        [self.backView addSubview:self.titleLable];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + AutoSize6(25), 0, SCREEN_WIDTH / 2 - AutoSize6(90), AutoSize6(84))];
        self.timeLabel.centerY = self.backView.centerY;
        self.timeLabel.font = kFont6(24);
        self.timeLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.timeLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 0.5, 0, 1, AutoSize6(170))];
        lineView.backgroundColor = UIColorFromRGB(0xe2e2e2);
        [self.contentView addSubview:lineView];
        
        UIImageView *timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AutoSize6(36), AutoSize6(36))];
        timeImageView.image = [UIImage imageNamed:@"mine_bird_time"];
        timeImageView.contentMode = UIViewContentModeCenter;
        timeImageView.centerX = SCREEN_WIDTH / 2;
        timeImageView.centerY = self.backView.centerY;
        [self.contentView addSubview:timeImageView];
        


    }
    return self;
}


- (void)setBirdModel:(UserBirdModel *)birdModel {
    _birdModel = birdModel;
    
    self.timeLabel.text = [[AppDateManager shareManager] getDateWithTime:birdModel.dateline formatSytle:DateFormatYMD];
    NSString *utString = [birdModel.birdHead stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSURL *url = [NSURL URLWithString:utString];
    [self.iconImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.titleLable.text = birdModel.name;
}


- (UIView *)makeBackView {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(44), SCREEN_WIDTH / 2 - AutoSize6(40), AutoSize6(84))];
    backView.backgroundColor = kColorViewBackground;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:backView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(AutoSize6(84), AutoSize6(84))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = backView.bounds;
    maskLayer.path = maskPath.CGPath;
    backView.layer.mask = maskLayer;
    
    
    
    return backView;
}

@end
