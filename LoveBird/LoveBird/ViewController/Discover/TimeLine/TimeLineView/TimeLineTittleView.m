//
//  TimeLineTittleView.m
//  LFBaseProject
//
//  Created by ShanCheli on 2018/1/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "TimeLineTittleView.h"
#import "UIImageView+WebCache.h"

@interface TimeLineTittleView()

@property (nonatomic, strong) UIImageView *headIcon;

@property (nonatomic, strong) UILabel *nickNameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

// 关注按钮
@property (nonatomic, strong) UIButton *followButton;


@end

@implementation TimeLineTittleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        // 头像
        self.headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize(10), AutoSize(12), AutoSize6(72), AutoSize6(72))];
        self.headIcon.contentMode = UIViewContentModeScaleToFill;
        self.headIcon.clipsToBounds = YES;
        self.headIcon.layer.cornerRadius = AutoSize6(36);
        [self addSubview:self.headIcon];
        
        self.headIcon.userInteractionEnabled = YES;
        [self.headIcon addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headIconDidClick)]];
        
        // 昵称
        self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headIcon.right + AutoSize(5), self.headIcon.top + AutoSize6(5), SCREEN_WIDTH / 2, self.headIcon.height / 2)];
        self.nickNameLabel.textColor = [UIColor blackColor];
        self.nickNameLabel.font = kFont6(28);
        self.nickNameLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.nickNameLabel];
        
        // 时间
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nickNameLabel.left, self.nickNameLabel.bottom, self.nickNameLabel.width, self.headIcon.height / 2)];
        self.timeLabel.textColor = UIColorFromRGB(0xa2a2a2);
        self.timeLabel.font = kFont6(18);
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.timeLabel];
        
        // 关注
        self.followButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - AutoSize6(30) - AutoSize(40), 0, AutoSize(40), AutoSize(60))];
        [self.followButton setTitle:@"关注" forState:UIControlStateNormal];
        [self.followButton setTitle:@"已关注" forState:UIControlStateSelected];
        self.followButton.titleLabel.font = kFont6(28);
        [self.followButton setTitleColor:UIColorFromRGB(0x7faf41) forState:UIControlStateNormal];
        [self.followButton setTitleColor:UIColorFromRGB(0xa2a2a2) forState:UIControlStateSelected];
        [self.followButton addTarget:self action:@selector(followButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        self.followButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:self.followButton];
        self.followButton.tag = 500;
    }
    return self;
}

- (void)followButtonDidClick:(UIButton *)button {
    
    [UserDao userFollow:self.contentModel.authorid successBlock:^(__kindof AppBaseModel *responseObject) {
        button.selected = !button.selected;
    } failureBlock:^(__kindof AppBaseModel *error) {
        [AppBaseHud showHudWithfail:error.errstr view:[UIViewController currentViewController].view];
    }];
    
//    if (self.followDelegate && [self.followDelegate respondsToSelector:@selector(followButtonDidClick:)]) {
//        [self.followDelegate followButtonClickDelegate:button];
//    }
}


- (void)setContentModel:(DiscoverContentModel *)contentModel {
    _contentModel = contentModel;
    self.nickNameLabel.text = contentModel.author;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:contentModel.head] placeholderImage:nil];
    self.followButton.selected = contentModel.is_follow;
    self.timeLabel.text = [[AppDateManager shareManager] getDateWithTime:contentModel.dateline formatSytle:DateFormatYMD];
    self.followButton.centerY = self.centerY - AutoSize6(5);
}

- (void)headIconDidClick {
    
    if ([self.contentModel.authorid isEqualToString:[UserPage sharedInstance].uid]) {
        
        ((UITabBarController *)(kTabBarController)).selectedIndex = 4;
        
        [[UIViewController currentViewController].navigationController popToRootViewControllerAnimated:NO];
        return;
    }
    
    UserInfoViewController *uservc = [[UserInfoViewController alloc] init];
    uservc.uid = self.contentModel.authorid;
    uservc.userName = self.contentModel.author;
    [[UIViewController currentViewController].navigationController pushViewController:uservc animated:YES];
}


@end
