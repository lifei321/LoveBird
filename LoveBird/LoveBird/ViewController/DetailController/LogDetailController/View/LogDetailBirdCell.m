//
//  LogDetailBirdCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/29.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "LogDetailBirdCell.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import "BirdDetailController.h"

@interface LogDetailBirdCell()<TTTAttributedLabelDelegate>

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) TTTAttributedLabel *birdLabel;

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
        
        self.birdLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(self.iconImageView.right + AutoSize6(20), 0, SCREEN_WIDTH - _iconImageView.right - AutoSize6(40), AutoSize6(94))];
        self.birdLabel.textAlignment = NSTextAlignmentLeft;
        self.birdLabel.textColor = kColorTextColor333333;
        self.birdLabel.font = kFont6(28);
        self.birdLabel.delegate = self;
        [self.contentView addSubview:self.birdLabel];
        self.birdLabel.userInteractionEnabled = YES;
        _birdLabel.activeLinkAttributes = @{NSForegroundColorAttributeName:kColorDefaultColor,NSUnderlineStyleAttributeName:@(0)};
        _birdLabel.linkAttributes = @{NSForegroundColorAttributeName:kColorTextColor333333,NSUnderlineStyleAttributeName:@(0)};

        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(93), SCREEN_WIDTH - AutoSize6(60), 0.5)];
        self.lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)setBirdArray:(NSArray *)birdArray {
    _birdArray = [birdArray copy];
    
    NSString *text ;
    NSString *contentText;
    
    for (LogBirdInfoModel *model in birdArray) {
        text = [NSString stringWithFormat:@"%@%@ ",model.genus, model.num];
        
        if (contentText.length) {
            contentText = [contentText stringByAppendingString:text];
        } else {
            contentText = [text copy];
        }
    }
    
    //设置需要点击的文字的颜色大小
    [self.birdLabel setText:contentText afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:kFont6(28) range:NSMakeRange(0, contentText.length)];
        [mutableAttributedString addAttribute:(NSString*)kCTForegroundColorAttributeName value:kColorDefaultColor range:NSMakeRange(0, contentText.length)];
        return mutableAttributedString;
    }];

    for (LogBirdInfoModel *model in birdArray) {
        NSString *text = [NSString stringWithFormat:@"%@%@ ",model.genus, model.num];
        NSRange boldRange1 = [contentText rangeOfString:text options:NSCaseInsensitiveSearch];
        [self.birdLabel addLinkToAddress:@{@"code": model.csp_code} withRange:boldRange1];
    }
    
//    CGFloat height = [contentText getTextHeightWithFont:self.birdLabel.font withWidth:SCREEN_WIDTH - _iconImageView.right - AutoSize6(40)];
    self.birdLabel.numberOfLines = 0;
    self.birdLabel.textColor = kColorDefaultColor;
    self.lineView.hidden = NO;
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithAddress:(NSDictionary *)addressComponents {
    BirdDetailController *detail = [[BirdDetailController alloc] init];
    detail.cspCode = [addressComponents objectForKey:@"code"];
    [[UIViewController currentViewController].navigationController pushViewController:detail animated:YES];

}

- (void)sdds {
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
    _iconImageView.image = [UIImage imageNamed:@"ecology_record"];

    self.birdLabel.text = evHuanjing;
    self.lineView.hidden = YES;
    self.lineView.frame = CGRectMake(AutoSize6(0), AutoSize6(93), SCREEN_WIDTH, 0.5);

}


@end
