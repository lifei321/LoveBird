//
//  BirdDetailTextCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailTextCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BirdDetailTextCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *tagLabel;


@end

@implementation BirdDetailTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, SCREEN_WIDTH - AutoSize6(230), AutoSize6(92))];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = kFont6(32);
        [self.contentView addSubview:self.titleLabel];
        
        
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(100), 0, AutoSize6(70), AutoSize6(92))];
        _iconImageView.contentMode = UIViewContentModeRight;
        [self.contentView addSubview:_iconImageView];
        
        self.tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(255), 0, AutoSize6(200), AutoSize6(92))];
        self.tagLabel.textAlignment = NSTextAlignmentRight;
        self.tagLabel.textColor = kColorTextColorLightGraya2a2a2;
        self.tagLabel.font = kFont6(30);
        [self.contentView addSubview:self.tagLabel];
        
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
    self.iconImageView.hidden = YES;
}

- (void)setDetail:(NSString *)detail {
    self.iconImageView.hidden = NO;
    self.iconImageView.image = [UIImage imageNamed:@"detail_right"];
    self.tagLabel.text = detail;
}

- (void)setHasImage:(BOOL)hasImage {
    self.iconImageView.hidden = NO;
    self.iconImageView.image = [UIImage imageNamed:@"detail_song"];
}

@end
