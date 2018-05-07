//
//  PublishDetailCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishDetailCell.h"

@interface PublishDetailCell()

@property (nonatomic, strong) UILabel *titleLabe;

@property (nonatomic, strong) UILabel *contentLabe;


@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation PublishDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, AutoSize6(150), AutoSize6(95))];
        self.titleLabe.textColor = [UIColor blackColor];
        self.titleLabe.textAlignment = NSTextAlignmentLeft;
        self.titleLabe.font = kFont6(30);
        [self.contentView addSubview:self.titleLabe];
        
        self.contentLabe = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(300), 0, AutoSize6(240), AutoSize6(95))];
        self.contentLabe.textColor = kColorTextColorLightGraya2a2a2;
        self.contentLabe.textAlignment = NSTextAlignmentRight;
        self.contentLabe.font = kFont6(26);
        [self.contentView addSubview:self.contentLabe];
        
        _arrowImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(46), 0, AutoSize6(15), AutoSize6(95))];
        _arrowImageView.contentMode = UIViewContentModeCenter;
        _arrowImageView.image = [UIImage imageNamed:@"left_arrow"];
        [self.contentView addSubview:_arrowImageView];
        
    }
    return self;
}

- (void)setDetailModel:(PublishDetailModel *)detailModel {
    self.accessoryType = UITableViewCellStyleDefault;

    _detailModel = detailModel;
    self.titleLabe.text = detailModel.title;
    self.contentLabe.text = detailModel.detailString;
}

@end
