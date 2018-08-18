//
//  LogDetailBirdCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/29.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogDetailBirdCell.h"

@interface LogDetailBirdCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *birdLabel;

@property (nonatomic, strong) UIView *lineView;
@end

@implementation LogDetailBirdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, AutoSize6(34), AutoSize6(94))];
        _iconImageView.contentMode = UIViewContentModeCenter;
        _iconImageView.image = [UIImage imageNamed:@"bird_record"];
        [self.contentView addSubview:_iconImageView];
        
        self.birdLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.right + AutoSize6(20), 0, SCREEN_WIDTH - _iconImageView.right - AutoSize6(40), AutoSize6(94))];
        self.birdLabel.textAlignment = NSTextAlignmentLeft;
        self.birdLabel.textColor = kColorTextColor333333;
        self.birdLabel.font = kFont6(28);
        [self.contentView addSubview:self.birdLabel];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(93), SCREEN_WIDTH - AutoSize6(30), 0.5)];
        self.lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)setBirdArray:(NSArray *)birdArray {
    _birdArray = [birdArray copy];
    
    NSString *text ;
    for (LogBirdInfoModel *model in birdArray) {
        text = [NSString stringWithFormat:@"%@ %@ ",model.genus, model.num];
    }
    self.birdLabel.text = text;
    self.lineView.hidden = NO;

}

- (void)setLocation:(NSString *)location {
    _location = [location copy];
    _iconImageView.image = [UIImage imageNamed:@"adress_record"];

    self.birdLabel.text = location;
    self.lineView.hidden = NO;

}

- (void)setTime:(NSString *)time {
    _time = [time copy];
    _iconImageView.image = [UIImage imageNamed:@"date_record"];

    self.birdLabel.text = time;
    self.lineView.hidden = NO;
}


- (void)setEvHuanjing:(NSString *)evHuanjing {
    _evHuanjing = evHuanjing;
    _iconImageView.image = [UIImage imageNamed:@"date_record"];

    self.birdLabel.text = evHuanjing;
    self.lineView.hidden = NO;
    self.lineView.frame = CGRectMake(AutoSize6(0), AutoSize6(93), SCREEN_WIDTH, 0.5);

}


@end
