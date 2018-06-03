//
//  BirdDetailClassCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailClassCell.h"

@interface BirdDetailClassCell()


@property (nonatomic, strong) UILabel *birdClassLabel;

@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation BirdDetailClassCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        // 物种分类
        UIView *classBird = [self makeTitleView:@""];
        [self.contentView addSubview:classBird];
        
        self.birdClassLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(60), classBird.bottom + AutoSize6(10), SCREEN_WIDTH - AutoSize6(90), AutoSize6(40))];
        self.birdClassLabel.textAlignment = NSTextAlignmentLeft;
        self.birdClassLabel.textColor = [UIColor blackColor];
        self.birdClassLabel.font = kFont6(30);
        [self.contentView addSubview:self.birdClassLabel];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
}

- (void)setDetail:(NSString *)detail {
    _detail = [detail copy];
    self.birdClassLabel.text = detail;
}

- (UIView *)makeTitleView:(NSString *)title {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(68))];
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(20), 0, AutoSize6(35), backView.height)];
    icon.image = [UIImage imageNamed:@"detail_icon"];
    icon.contentMode = UIViewContentModeCenter;
    [backView addSubview:icon];
    
    UILabel *detailTextLable = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(63), AutoSize6(0), SCREEN_WIDTH - AutoSize6(78), backView.height)];
    detailTextLable.textAlignment = NSTextAlignmentLeft;
    detailTextLable.textColor = kColorDefaultColor;
    detailTextLable.font = kFont6(30);
    detailTextLable.text = title;
    [backView addSubview:detailTextLable];
    self.titleLabel = detailTextLable;
    
    return backView;
    
}

@end
