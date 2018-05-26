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

@end

@implementation MatchListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, AutoSize6(20), SCREEN_WIDTH, AutoSize6(442))];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_iconImageView];
        
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, _iconImageView.bottom, SCREEN_WIDTH, AutoSize6(115))];
        self.titleLable.font = kFont6(32);
        self.titleLable.textColor = UIColorFromRGB(0x333333);
        self.titleLable.textAlignment = NSTextAlignmentCenter;
        self.titleLable.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLable];
        
    }
    return self;
}

- (void)setModel:(AppBaseCellModel *)model {
    self.accessoryType = UITableViewCellStyleDefault;

    MatchModel *matchModel = (MatchModel *)model.userInfo;
    
    self.iconImageView.height = matchModel.imgHeight * (SCREEN_WIDTH / matchModel.imgWidth);
    self.titleLable.top = self.iconImageView.bottom;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:matchModel.imgUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLable.text = matchModel.title;
}

@end
