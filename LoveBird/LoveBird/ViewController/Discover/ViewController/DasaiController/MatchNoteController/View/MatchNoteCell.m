//
//  MatchNoteCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/10.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MatchNoteCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface MatchNoteCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLable;

@property (nonatomic, strong) UILabel *timeLable;

@property (nonatomic, strong) UIView *backView;

// 内容图片
@property (nonatomic, strong) UIImageView *contentImageView;

@property (nonatomic, strong) UIImageView *locationImageView;

@property (nonatomic, strong) UILabel *locationLable;

@property (nonatomic, strong) UIImageView *moreImageView;

@end

@implementation MatchNoteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), 0, AutoSize6(64), AutoSize6(64))];
        self.iconImageView.contentMode = UIViewContentModeScaleToFill;
        self.iconImageView.layer.cornerRadius = self.iconImageView.width / 2;
        self.iconImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.iconImageView.layer.borderWidth = 1;
        self.iconImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.iconImageView];
        
        self.iconImageView.userInteractionEnabled = YES;
        [self.iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headIconDidClick)]];
        
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.right + AutoSize6(10), 0, AutoSize6(100), self.iconImageView.height)];
        self.nameLable.font = kFont6(26);
        self.nameLable.textColor = UIColorFromRGB(0x333333);
        self.nameLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.nameLable];
        
        self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.backView.width - AutoSize6(40), self.iconImageView.height)];
        self.timeLable.font = kFont6(20);
        self.timeLable.textColor = kColorTextColorLightGraya2a2a2;
        self.timeLable.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.timeLable];
        
        self.backView = [[UIView alloc] initWithFrame:CGRectMake(self.iconImageView.right, self.iconImageView.bottom, SCREEN_WIDTH - self.iconImageView.right - AutoSize6(30), AutoSize6(252))];
        self.backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.backView];
    
        
        self.contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(20), AutoSize6(20), AutoSize6(320), AutoSize6(212))];
        self.contentImageView.contentMode = UIViewContentModeScaleToFill;
        [self.backView addSubview:self.contentImageView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(61), self.iconImageView.bottom + AutoSize6(3), 2, AutoSize6(338) - self.iconImageView.bottom - AutoSize6(3))];
        lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:lineView];
        
        self.locationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentImageView.right + AutoSize6(20), self.backView.height - AutoSize6(50), AutoSize6(21), AutoSize6(35))];
        self.locationImageView.image = [UIImage imageNamed:@"detail_adress"];
        self.locationImageView.contentMode = UIViewContentModeCenter;
        [self.backView addSubview:self.locationImageView];
        
        self.locationLable = [[UILabel alloc] initWithFrame:CGRectMake(self.locationImageView.right + AutoSize6(5), self.locationImageView.top, AutoSize6(240), self.locationImageView.height)];
        self.locationLable.font = kFont6(22);
        self.locationLable.textColor = kColorTextColorLightGraya2a2a2;
        self.locationLable.textAlignment = NSTextAlignmentLeft;
        self.locationLable.numberOfLines = 0;
        [self.backView addSubview:self.locationLable];
        
        self.moreImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.moreImageView.image = [UIImage imageNamed:@"detail_more"];
        self.moreImageView.contentMode = UIViewContentModeRight;
        [self.backView addSubview:self.moreImageView];
    }
    return self;
}

- (void)setModel:(MatchArticleModel *)model {
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.nameLable.text = model.author;
    [self.nameLable sizeToFit];
    self.nameLable.centerY = self.iconImageView.centerY;
    
    self.timeLable.text = [[AppDateManager shareManager] getDateWithTime:model.dateline formatSytle:DateFormatYMD];
    [self.timeLable sizeToFit];
    self.timeLable.left = self.nameLable.right + AutoSize6(10);
    self.timeLable.centerY = self.nameLable.centerY;
    
    CGFloat locationHeight = [model.locale getTextHeightWithFont:self.locationLable.font withWidth:AutoSize6(240)];
    if (locationHeight > self.locationImageView.height) {
        self.locationLable.top = self.locationImageView.top - AutoSize6(30);
        self.locationLable.height = locationHeight;

    } else {
        self.locationLable.top = self.locationImageView.top;
        self.locationLable.height = self.locationImageView.height;
    }
    self.locationLable.text = model.locale;
    
    NSInteger count = 0;
    for (int i = 0; i < model.genus.count; i++) {
        MatchArticleGusModel *gmodel = model.genus[i];
        [self.backView addSubview:[self makeViewTop:i * (AutoSize6(28) + AutoSize6(20)) model:gmodel]];
        count = i;
        if (i  == 2) {
            break;
        }
    }
    
    count += 1;
    if (model.genus.count) {
        self.moreImageView.frame = CGRectMake(self.backView.width - AutoSize6(53), self.contentImageView.top + count * (AutoSize6(28) + AutoSize6(20)), AutoSize6(23), AutoSize6(10));
    }
    
}

- (UIView *)makeViewTop:(CGFloat)top model:(MatchArticleGusModel *)model {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(self.contentImageView.right + AutoSize6(30), self.contentImageView.top + top, AutoSize6(240), AutoSize6(28))];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backView.width / 2, backView.height)];
    textLabel.font = kFont6(26);
    textLabel.textColor = UIColorFromRGB(0x333333);
    textLabel.textAlignment = NSTextAlignmentLeft;
    textLabel.text = model.name;
    [backView addSubview:textLabel];
    
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(backView.width / 2, 0, backView.width / 2, backView.height)];
    countLabel.font = kFont6(25);
    countLabel.textColor = kColorTextColorLightGraya2a2a2;
    countLabel.textAlignment = NSTextAlignmentRight;
    countLabel.text = [NSString stringWithFormat:@"%@只", model.number];
    [backView addSubview:countLabel];
    
    return backView;
}

- (void)headIconDidClick {
    
    if ([self.model.authorid isEqualToString:[UserPage sharedInstance].uid]) {
        
        ((UITabBarController *)(kTabBarController)).selectedIndex = 4;
        
        [[UIViewController currentViewController].navigationController popToRootViewControllerAnimated:NO];
        return;
    }
    
    UserInfoViewController *uservc = [[UserInfoViewController alloc] init];
    uservc.uid = self.model.authorid;
    uservc.userName = self.model.author;
    [[UIViewController currentViewController].navigationController pushViewController:uservc animated:YES];
}


@end
