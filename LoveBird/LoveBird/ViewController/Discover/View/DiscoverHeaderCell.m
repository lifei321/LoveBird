//
//  DiscoverHeaderCell.m
//  LoveBird
//
//  Created by ShanCheli on 2018/2/1.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "DiscoverHeaderCell.h"

@interface DiscoverHeaderCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation DiscoverHeaderCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AutoSize(36), AutoSize(36))];
        _iconImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_iconImageView];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _iconImageView.bottom + AutoSize(0), AutoSize(36), AutoSize(25))];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = kColorTextColor7f7f7f;
        _textLabel.font = kFont(11);
        [self addSubview:_textLabel];
    }
    return self;
}

- (void)setModel:(DiscoverListModel *)model {
    _model = model;
    self.iconImageView.image = [UIImage imageNamed:model.imageString];
    self.textLabel.text = model.text;
}

@end
