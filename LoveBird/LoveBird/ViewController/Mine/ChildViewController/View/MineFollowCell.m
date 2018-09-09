//
//  MineFollowCell.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineFollowCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MineFollowCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *followButton;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *lineView;

@end


@implementation MineFollowCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        
        self.iconImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(22), AutoSize6(90), AutoSize6(90))];
        self.iconImageView.contentMode = UIViewContentModeScaleToFill;
        self.iconImageView.layer.cornerRadius = self.iconImageView.width / 2;
        self.iconImageView.clipsToBounds = YES;
        [self.contentView addSubview:self.iconImageView];
        
        self.iconImageView.userInteractionEnabled = YES;
        [self.iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headIconDidClick)]];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.right + AutoSize6(10), AutoSize6(0), SCREEN_WIDTH - AutoSize6(50) - self.iconImageView.right, AutoSize6(134))];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = kFont6(30);
        [self.contentView addSubview:self.titleLabel];
        
        self.followButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(30) - AutoSize6(113), AutoSize6(40), AutoSize6(113), AutoSize6(55))];
        [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.followButton setTitle:@"已关注" forState:UIControlStateSelected];
        self.followButton.titleLabel.font = kFont6(26);
        [self.followButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.followButton setTitleColor:kColorTextColorLightGraya2a2a2 forState:UIControlStateSelected];


        [self.followButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:self.followButton.frame.size] forState:UIControlStateNormal];
        [self.followButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kLineColoreLightGrayECECEC withSize:self.followButton.frame.size] forState:UIControlStateSelected];
        [self.followButton addTarget:self action:@selector(followButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        self.followButton.layer.cornerRadius = AutoSize6(3);
        self.followButton.clipsToBounds = YES;
        [self addSubview:self.followButton];
        
//        [self.followButton setImage:[UIImage imageNamed:@"follow_each"] forState:UIControlStateSelected];
//        [self.followButton setImage:nil forState:UIControlStateNormal];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(134) - 0.5, SCREEN_WIDTH - AutoSize6(30), 0.5)];
        self.lineView.backgroundColor = kLineColoreDefaultd4d7dd;
        [self.contentView addSubview:self.lineView];
        
    }
    return self;
}

- (void)followButtonDidClick:(UIButton *)button {
    [UserDao userFollow:self.followModel.uid successBlock:^(__kindof AppBaseModel *responseObject) {
        button.selected = !button.selected;
        [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshUserInfoNotification object:nil];
    } failureBlock:^(__kindof AppBaseModel *error) {
        [AppBaseHud showHudWithfail:error.errstr view:[UIViewController currentViewController].view];
    }];
}

- (void)setFollowModel:(UserFollowModel *)followModel {
    _followModel = followModel;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:followModel.head] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    self.titleLabel.text = followModel.username;
    self.followButton.selected = followModel.isFollow;
    
}

- (void)headIconDidClick {
    
    if ([self.followModel.uid isEqualToString:[UserPage sharedInstance].uid]) {
        
        ((UITabBarController *)(kTabBarController)).selectedIndex = 4;
        
        [[UIViewController currentViewController].navigationController popToRootViewControllerAnimated:NO];
        return;
    }
    
    UserInfoViewController *uservc = [[UserInfoViewController alloc] init];
    uservc.uid = self.followModel.uid;
    uservc.userName = self.followModel.username;
    [[UIViewController currentViewController].navigationController pushViewController:uservc animated:YES];
}
@end
