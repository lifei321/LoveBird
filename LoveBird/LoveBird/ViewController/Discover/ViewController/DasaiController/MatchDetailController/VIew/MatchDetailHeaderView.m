//
//  MatchDetailHeaderView.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MatchDetailHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MatchTitleView.h"
#import "RankViewController.h"
#import "LogDetailController.h"

@interface MatchDetailHeaderView()

// 内容图片
@property (nonatomic, strong) UIImageView *contentImageView;


@property (nonatomic, strong) MatchTitleView *titleView;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIButton *detailButton;

@property (nonatomic, strong) UIView *line1;

@property (nonatomic, strong) UIView *line2;

@end


@implementation MatchDetailHeaderView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        // 图片 不一定存在
        self.contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(440))];
        self.contentImageView.contentMode = UIViewContentModeScaleToFill;
        self.contentImageView.userInteractionEnabled = YES;
        [self addSubview:self.contentImageView];
        
        UIButton *bangButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(90), self.contentImageView.height - AutoSize6(80), AutoSize6(60), AutoSize6(60))];
        bangButton.layer.cornerRadius = bangButton.width / 2;
        bangButton.layer.masksToBounds = YES;
        bangButton.layer.borderColor = UIColorFromRGB(0xf7b03d).CGColor;
        bangButton.layer.borderWidth = 1;
        bangButton.backgroundColor = [UIColor whiteColor];
        bangButton.titleLabel.font = kFont6(32);
        [bangButton setTitle:@"榜" forState:UIControlStateNormal];
        [bangButton setTitleColor:UIColorFromRGB(0xf7b03d) forState:UIControlStateNormal];
        [bangButton addTarget:self action:@selector(gotoBangDan) forControlEvents:UIControlEventTouchUpInside];
        [self.contentImageView addSubview:bangButton];
        
        
        // 昵称
        self.titleView = [[MatchTitleView alloc] initWithFrame:CGRectMake(0, self.contentImageView.bottom, SCREEN_WIDTH, AutoSize6(133))];
        //        self.titleView.followDelegate = self;
        [self addSubview:self.titleView];
        
        self.line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleView.bottom, SCREEN_WIDTH, 0.5)];
        self.line1.backgroundColor = kLineColoreDefaultd4d7dd;
        [self addSubview:self.line1];
        
        // 昵称
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), self.line1.bottom, SCREEN_WIDTH - AutoSize6(60), AutoSize6(40))];
        self.contentLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.contentLabel.font = kFont6(20);
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.contentLabel];
        
        self.line2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentLabel.bottom, SCREEN_WIDTH, 0.5)];
        self.line2.backgroundColor = kLineColoreDefaultd4d7dd;
        [self addSubview:self.line2];
        
        
        self.detailButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(80))];
        [self.detailButton setTitle:@"大赛详情>" forState:UIControlStateNormal];
        [self.detailButton setTitle:@"大赛详情>" forState:UIControlStateSelected];
        self.detailButton.titleLabel.font = kFont6(26);
        [self.detailButton setTitleColor:UIColorFromRGB(0xf7b03d) forState:UIControlStateNormal];
        
        [self.detailButton addTarget:self action:@selector(followButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.detailButton];
    }
    return self;
}

- (void)gotoBangDan {
    RankViewController *rankvc = [[RankViewController alloc] init];
    [[UIViewController currentViewController].navigationController pushViewController:rankvc animated:YES];
}


- (void)followButtonDidClick:(UIButton *)button {
    LogDetailController *detailvc = [[LogDetailController alloc] init];
    detailvc.aid = self.detailModel.aid;
    [[UIViewController currentViewController].navigationController pushViewController:detailvc animated:YES];
}

- (void)setMatchid:(NSString *)matchid {
    _matchid = [matchid copy];
    self.titleView.matchid = matchid;
    
}

- (void)setDetailModel:(MatchDetailModel *)detailModel {
    _detailModel = detailModel;
    
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.titleView.detailModel = detailModel;
    
    self.contentLabel.text = detailModel.summary;
    CGFloat height = [detailModel.summary getTextHeightWithFont:self.contentLabel.font withWidth:self.contentLabel.width];
    self.contentLabel.height = height + AutoSize6(60);
    
    self.line2.top = self.contentLabel.bottom;
    
    self.detailButton.top = self.line2.bottom;
}

- (CGFloat)getHeight {
    
    return self.detailButton.bottom;
}

@end
