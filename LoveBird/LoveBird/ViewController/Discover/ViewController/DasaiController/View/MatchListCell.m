//
//  MatchListCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/20.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MatchListCell.h"
#import "MatchModel.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface MatchListCell()

@property (nonatomic, strong) UIImageView *iconImageView;


@property (nonatomic, strong) UILabel *titleLable;

@property (nonatomic, strong) UIButton *selectButton;


@end

@implementation MatchListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, AutoSize6(20), SCREEN_WIDTH, AutoSize6(442))];
        self.iconImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_iconImageView];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, _iconImageView.bottom, SCREEN_WIDTH, AutoSize6(115))];
        self.titleLable.font = kFont6(32);
        self.titleLable.textColor = UIColorFromRGB(0x333333);
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        self.titleLable.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLable];
        
        self.selectButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(100), AutoSize6(30), AutoSize6(70), AutoSize6(60))];
        [self.selectButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
        [self.selectButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        [self.selectButton addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.selectButton];
        
    }
    return self;
}

- (void)setModel:(AppBaseCellModel *)model {
    self.accessoryType = UITableViewCellStyleDefault;

    MatchModel *matchModel = (MatchModel *)model.userInfo;
    
    self.iconImageView.height = matchModel.imgHeight * (SCREEN_WIDTH / matchModel.imgWidth);
    self.titleLable.top = self.iconImageView.bottom;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:matchModel.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.titleLable.text = matchModel.title;
    
    self.selectButton.hidden = YES;
}

- (void)selectClick {
    if (self.matchClickBlock) {
        self.matchClickBlock(self);
    }
}

- (void)setMatchModel:(MatchModel *)matchModel {
    self.accessoryType = UITableViewCellStyleDefault;
    _matchModel = matchModel;
    self.iconImageView.height = matchModel.imgHeight * (SCREEN_WIDTH / matchModel.imgWidth);
    self.titleLable.top = self.iconImageView.bottom;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:matchModel.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.titleLable.text = matchModel.title;
    
    self.selectButton.selected = matchModel.isSelected;
}

@end
