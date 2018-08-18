//
//  BirdDetailGradeCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "BirdDetailGradeCell.h"

@interface BirdDetailGradeCell()


@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *worldLabel;

@property (nonatomic, strong) UILabel *wallxLabel;

@property (nonatomic, strong) UILabel *chinaLabel;


@end

@implementation BirdDetailGradeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        // 物种分类
        UIView *classBird = [self makeTitleView:@""];
        [self.contentView addSubview:classBird];
        
        UILabel *worldLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(60), classBird.bottom + AutoSize6(10), SCREEN_WIDTH / 2 - AutoSize6(60), AutoSize6(40))];
        worldLabel.font = kFont6(26);
        worldLabel.textColor = kColorTextColorLightGraya2a2a2;
        worldLabel.textAlignment = NSTextAlignmentLeft;
        worldLabel.text = @"世界自然保护联盟IUCN";
        [self.contentView addSubview:worldLabel];
        
        self.worldLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + AutoSize6(20), worldLabel.top, SCREEN_WIDTH / 2 - AutoSize6(50), AutoSize6(40))];
        self.worldLabel.textAlignment = NSTextAlignmentLeft;
        self.worldLabel.textColor = [UIColor blackColor];
        self.worldLabel.font = kFont6(26);
        [self.contentView addSubview:self.worldLabel];
        
        
        UILabel *wallxLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(60), worldLabel.bottom + AutoSize6(10), SCREEN_WIDTH / 2 - AutoSize6(60), AutoSize6(40))];
        wallxLabel.font = kFont6(26);
        wallxLabel.textColor = kColorTextColorLightGraya2a2a2;
        wallxLabel.textAlignment = NSTextAlignmentLeft;
        wallxLabel.text = @"世界自然保护联盟IUCN";
        [self.contentView addSubview:wallxLabel];
        
        self.wallxLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + AutoSize6(20), wallxLabel.top, SCREEN_WIDTH / 2 - AutoSize6(50), AutoSize6(40))];
        self.wallxLabel.textAlignment = NSTextAlignmentLeft;
        self.wallxLabel.textColor = [UIColor blackColor];
        self.wallxLabel.font = kFont6(26);
        [self.contentView addSubview:self.wallxLabel];
        
        
        UILabel *chinaLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(60), wallxLabel.bottom + AutoSize6(10), SCREEN_WIDTH / 2 - AutoSize6(60), AutoSize6(40))];
        chinaLabel.font = kFont6(26);
        chinaLabel.textColor = kColorTextColorLightGraya2a2a2;
        chinaLabel.textAlignment = NSTextAlignmentLeft;
        chinaLabel.text = @"华盛顿公约CITES";
        [self.contentView addSubview:chinaLabel];
        
        self.chinaLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + AutoSize6(20), chinaLabel.top, SCREEN_WIDTH / 2 - AutoSize6(50), AutoSize6(40))];
        self.chinaLabel.textAlignment = NSTextAlignmentLeft;
        self.chinaLabel.textColor = [UIColor blackColor];
        self.chinaLabel.font = kFont6(26);
        [self.contentView addSubview:self.chinaLabel];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
}

- (void)setWorld:(NSString *)world {
    _world = [world copy];
    self.worldLabel.text = world;
}

- (void)setWallx:(NSString *)wallx {
    _wallx = [wallx copy];
    self.wallxLabel.text = wallx;
}

- (void)setChina:(NSString *)china {
    _china = [china copy];
    self.chinaLabel.text = china;
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
