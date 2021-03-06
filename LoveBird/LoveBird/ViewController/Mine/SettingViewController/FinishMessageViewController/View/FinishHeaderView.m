//
//  FinishHeaderView.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/17.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FinishHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UserModel.h"

@interface FinishHeaderView()

@property (nonatomic, strong) UIButton *selectButton;


@end

@implementation FinishHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, AutoSize6(50), SCREEN_WIDTH, AutoSize6(30))];
        nameLabel.font = kFont6(30);
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.text = @"我的头像";
        [self addSubview:nameLabel];
        
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, nameLabel.bottom + AutoSize6(20), AutoSize6(155), AutoSize6(155))];
        self.headImageView.contentMode = UIViewContentModeScaleToFill;
        _headImageView.userInteractionEnabled = YES;
        [_headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headIconDidClick)]];

        _headImageView.centerX = self.centerX;
        _headImageView.layer.cornerRadius = _headImageView.width / 2;
        _headImageView.layer.masksToBounds = YES;
        [self addSubview:_headImageView];
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:[UserPage sharedInstance].userModel.head] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - AutoSize6(115), AutoSize6(480), AutoSize6(77))];
        titleView.centerX = self.centerX;
        titleView.layer.borderColor = kColorDefaultColor.CGColor;
        titleView.layer.borderWidth = 1;
        titleView.layer.cornerRadius = 5;
        titleView.clipsToBounds = YES;
        [self addSubview:titleView];
        
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleView.width / 3 - 1, titleView.height)];
        [leftButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
        [leftButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setTitle:@"男" forState:UIControlStateNormal];
        [leftButton setTitle:@"男" forState:UIControlStateSelected];
        leftButton.titleLabel.font = kFont6(24);
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftButton.tag = 100;
        [titleView addSubview:leftButton];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(leftButton.right, 0, 1, titleView.height)];
        line1.backgroundColor = kColorDefaultColor;
        [titleView addSubview:line1];
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(leftButton.right + 1, 0, titleView.width / 3 - 1, titleView.height)];
        [rightButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
        [rightButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:@"女" forState:UIControlStateNormal];
        [rightButton setTitle:@"女" forState:UIControlStateSelected];
        rightButton.titleLabel.font = kFont6(24);
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rightButton.tag = 200;
        
        [titleView addSubview:rightButton];
        
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(rightButton.right, 0, 1, titleView.height)];
        line2.backgroundColor = kColorDefaultColor;
        [titleView addSubview:line2];
        
        UIButton *scolreButton = [[UIButton alloc] initWithFrame:CGRectMake(rightButton.right + 1, 0, titleView.width / 3 - 1, titleView.height)];
        [scolreButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:kColorDefaultColor withSize:leftButton.size] forState:UIControlStateSelected];
        [scolreButton setBackgroundImage:[[UIImage alloc] drawImageWithBackgroudColor:[UIColor whiteColor] withSize:leftButton.size] forState:UIControlStateNormal];
        [scolreButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [scolreButton setTitle:@"保密" forState:UIControlStateNormal];
        [scolreButton setTitle:@"保密" forState:UIControlStateSelected];
        scolreButton.titleLabel.font = kFont6(24);
        [scolreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [scolreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        scolreButton.tag = 300;
        
        [titleView addSubview:scolreButton];
        
        NSString *gender = [UserPage sharedInstance].userModel.gender;
        if ([gender isEqualToString:@"男"]) {
            self.selectButton = leftButton;
        } else if ([gender isEqualToString:@"女"]) {
            self.selectButton = rightButton;
        } else {
            self.selectButton = scolreButton;
        }
        self.selectButton.selected = YES;
        
    }
    return self;
}

- (void)headIconDidClick {
    if (self.block) {
        self.block();
    }
}

- (void)buttonDidClick:(UIButton *)button {
    if (button.selected) {
        return;
    }
    
    self.selectButton.selected = NO;
    self.selectButton = button;
    self.selectButton.selected = YES;
}

- (NSString *)gender {
    if (self.selectButton.tag == 100) {
        return @"男";
    } else if (self.selectButton.tag == 100) {
        return @"女";
    } else {
        return @"保密";
    }
}

@end
