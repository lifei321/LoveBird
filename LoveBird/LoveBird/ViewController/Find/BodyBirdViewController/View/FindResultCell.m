//
//  FindResultCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/27.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindResultCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FindResultCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *wordDetailLabel;

@property (nonatomic, strong) UILabel *scoreLabel;


@end

@implementation FindResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        
        self.iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, AutoSize6(200), AutoSize6(130))];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.iconImageView.image = [UIImage imageNamed:@"placeHolder"];
        [self.contentView addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.right + AutoSize6(20), AutoSize6(30), SCREEN_WIDTH - AutoSize6(50) - self.iconImageView.right, AutoSize6(30))];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = kFont6(30);
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom + AutoSize6(15), self.titleLabel.width, AutoSize6(30))];
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.font = kFont6(28);
        CGAffineTransform matrix = CGAffineTransformMake(1, 0, tanf(-15 * (CGFloat)M_PI / 180), 1, 0, 0);
        self.contentLabel.transform = matrix;
        self.contentLabel.textColor = UIColorFromRGB(0x7f7f7f);
        [self.contentView addSubview:self.contentLabel];
        
        self.wordDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(130), AutoSize6(30), AutoSize6(100), AutoSize6(30))];
        self.wordDetailLabel.textColor = kColorTextColor7f7f7f;
        self.wordDetailLabel.textAlignment = NSTextAlignmentRight;
        self.wordDetailLabel.font = kFont6(22);
        [self.contentView addSubview:self.wordDetailLabel];

        
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(130), self.contentLabel.top, AutoSize6(100), AutoSize6(30))];
        self.scoreLabel.textColor = kColorDefaultColor;
        self.scoreLabel.textAlignment = NSTextAlignmentRight;
        self.scoreLabel.font = kFont6(24);
        [self.contentView addSubview:self.scoreLabel];

        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(130) - 0.5, SCREEN_WIDTH - AutoSize6(30), 0.5)];
        self.lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:self.lineView];
        
    }
    return self;
}

- (void)setBirdModel:(FindSelectBirdModel *)birdModel {
    _birdModel = birdModel;
    self.accessoryType = UITableViewCellAccessoryNone;

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:birdModel.bird_img] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.titleLabel.text = birdModel.name;
    
//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:birdModel.name_la];
//    [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:AutoSize6(28)] range:NSMakeRange(0, birdModel.name_la.length)];
//    [attrString addAttribute:NSForegroundColorAttributeName value:kColorTextColor7f7f7f range:NSMakeRange(0, birdModel.name_la.length)];
//    self.contentLabel.attributedText = attrString;
    
    self.titleLabel.textColor = (birdModel.isSelect) ? kColorDefaultColor : [UIColor blackColor];
    self.lineView.backgroundColor = (birdModel.isSelect) ? kColorDefaultColor : kLineColoreDefaultd4d7dd;
    
    self.contentLabel.textColor = (birdModel.isSelect) ? kColorDefaultColor : kColorTextColor7f7f7f;
    self.contentLabel.text = birdModel.name_la;
}

- (void)setInfoModel:(MapDiscoverInfoModel *)infoModel {
    _infoModel = infoModel;
    self.accessoryType = UITableViewCellAccessoryNone;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:infoModel.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.titleLabel.text = infoModel.name;
    self.contentLabel.text = infoModel.name_la;
    
    self.titleLabel.textColor = (infoModel.isSelect) ? kColorDefaultColor : [UIColor blackColor];
    self.contentLabel.textColor = (infoModel.isSelect) ? kColorDefaultColor : [UIColor blackColor];
    self.lineView.backgroundColor = (infoModel.isSelect) ? kColorDefaultColor : kLineColoreDefaultd4d7dd;
    
}

- (void)setZhinengModel:(FindzhinengModel *)zhinengModel {
    _zhinengModel = zhinengModel;
    self.accessoryType = UITableViewCellAccessoryNone;

    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:zhinengModel.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.titleLabel.text = zhinengModel.name;
    self.contentLabel.text = zhinengModel.name_la;
    
    self.wordDetailLabel.text = @"置信度";
    self.scoreLabel.text = zhinengModel.score;
}

@end
