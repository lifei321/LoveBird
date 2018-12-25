//
//  LogArticleCell.m
//  LoveBird
//
//  Created by 十八子飞 on 2018/12/24.
//  Copyright © 2018 shancheli. All rights reserved.
//

#import "LogArticleCell.h"

@interface LogArticleCell()

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIImageView *picImageView;

@end

@implementation LogArticleCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, AutoSize6(144))];
        self.picImageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_picImageView];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _picImageView.bottom + AutoSize6(20), self.width, AutoSize6(20))];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = kColorTextColor333333;
        _textLabel.font = kFont6(26);
        [self addSubview:_textLabel];
        
    }
    return self;
}

- (void)setModel:(LogExtendArticleModel *)model {
    _model = model;
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    _textLabel.text = model.title;
}

@end
