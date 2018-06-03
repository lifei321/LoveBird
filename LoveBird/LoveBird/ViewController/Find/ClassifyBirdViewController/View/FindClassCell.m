//
//  FindClassCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindClassCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FindClassCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *birdLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FindClassCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(20), AutoSize6(64), AutoSize6(64))];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.layer.cornerRadius = AutoSize6(5);
        [self.contentView addSubview:_iconImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:_iconImageView.bounds];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = kFont6(40);
        [_iconImageView addSubview:self.titleLabel];
        
        self.birdLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right + AutoSize6(30), 0, SCREEN_WIDTH - AutoSize6(150), AutoSize6(104))];
        self.birdLabel.textAlignment = NSTextAlignmentLeft;
        self.birdLabel.textColor = kColorTextColor333333;
        self.birdLabel.font = kFont6(30);
        [self.contentView addSubview:self.birdLabel];
        
        UIImageView *leftImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(50), AutoSize6(0), AutoSize6(20), AutoSize6(104))];
        leftImageView.image = [UIImage imageNamed:@"detail_right"];
        leftImageView.contentMode = UIViewContentModeCenter;
        leftImageView.clipsToBounds = YES;
        [self.contentView addSubview:leftImageView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(_iconImageView.left, AutoSize6(104) - 0.5, SCREEN_WIDTH - _iconImageView.left, 0.5)];
        lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:lineView];
        
    }
    return self;
}


- (void)setModel:(ClassifyModel *)model {
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.nameBgImg] placeholderImage:[UIImage imageNamed:@""]];
    
    if (model.subject.length) {
        self.birdLabel.text = model.subject;
    } else if (model.family.length) {
        self.birdLabel.text = model.family;
    } else if (model.genus.length) {
        self.birdLabel.text = model.genus;
    }
    NSString *first = [self.birdLabel.text substringToIndex:1];//字符串开始
    self.titleLabel.text = first;
    
}
@end
