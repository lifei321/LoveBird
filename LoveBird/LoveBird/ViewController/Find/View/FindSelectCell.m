//
//  FindSelectCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/3/17.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindSelectCell.h"
#import "UIImageView+WebCache.h"

@interface FindSelectCell()

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation FindSelectCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, AutoSize(97))];
        _picImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_picImageView];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _picImageView.bottom + AutoSize(3), self.width, AutoSize(20))];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = kColorTextColor333333;
        _textLabel.font = kFont(14);
        [self addSubview:_textLabel];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _textLabel.bottom + AutoSize(2), self.width, AutoSize(10))];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = kColorTextColorLightGraya2a2a2;
        _nameLabel.font = kFont(9);
        [self addSubview:_nameLabel];
        
    }
    return self;
}

- (void)setModel:(FindSelectModel *)model {
    _model = model;
    _textLabel.text = model.name;
    _nameLabel.text = [NSString stringWithFormat:@"%@%@", @"作者:", model.author];
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];
}








@end
