//
//  FindBodyViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/19.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindBodyViewController.h"
#import "FindColorViewController.h"

@interface FindBodyViewController ()
@property (nonatomic, strong) UIButton *selectButton;


@end

@implementation FindBodyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"体型查鸟";
    self.rightButton.title = @"完成";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), total_topView_height + AutoSize6(37), AutoSize6(40), AutoSize6(40))];
    stepLabel.text = @"3";
    stepLabel.font = kFont6(30);
    stepLabel.textColor = [UIColor whiteColor];
    stepLabel.textAlignment = NSTextAlignmentCenter;
    stepLabel.backgroundColor = kColorDefaultColor;
    stepLabel.layer.cornerRadius = stepLabel.width / 2;
    stepLabel.layer.masksToBounds = YES;
    [self.view addSubview:stepLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(stepLabel.right + AutoSize6(10), stepLabel.top, SCREEN_WIDTH - AutoSize6(100), AutoSize6(40))];
    titleLabel.text = @"它的体型？";
    titleLabel.font = kFontBold6(36);
    titleLabel.textColor = kColorTextColor333333;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    
    [self.view addSubview:[self makeCellView:CGPointMake(0, titleLabel.bottom + AutoSize6(37)) text:@"燕子形" image:@"find_4_1" selectImage:@"" tag:101]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 4, titleLabel.bottom + AutoSize6(37)) text:@"喜鹊形" image:@"find_4_2"selectImage:@"" tag:102]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/4, titleLabel.bottom + AutoSize6(37)) text:@"山雀形" image:@"find_4_3"selectImage:@"" tag:103]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 3/4, titleLabel.bottom + AutoSize6(37)) text:@"啄木鸟形" image:@"find_4_4"selectImage:@"" tag:104]];
    [self.view addSubview:[self makeCellView:CGPointMake(0, AutoSize6(187) + titleLabel.bottom  + AutoSize6(37)) text:@"麻雀形" image:@"find_4_5"selectImage:@"" tag:105]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 4, AutoSize6(187) +  titleLabel.bottom  + AutoSize6(37)) text:@"海鸥形" image:@"find_4_6"selectImage:@"" tag:106]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/4, AutoSize6(187) +  titleLabel.bottom  + AutoSize6(37)) text:@"天鹅形" image:@"find_4_7"selectImage:@"" tag:107]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 3/4, AutoSize6(187) +  titleLabel.bottom  + AutoSize6(37)) text:@"鸡形" image:@"find_4_8"selectImage:@"" tag:108]];
    [self.view addSubview:[self makeCellView:CGPointMake(0, AutoSize6(374) +  titleLabel.bottom  + AutoSize6(37)) text:@"鸭子形" image:@"find_4_9"selectImage:@"" tag:109]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 4, AutoSize6(374) +  titleLabel.bottom  + AutoSize6(37)) text:@"鹦鹉形" image:@"find_4_10"selectImage:@"" tag:110]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/4, AutoSize6(374) +  titleLabel.bottom  + AutoSize6(37)) text:@"鸽子形" image:@"find_4_11"selectImage:@"" tag:111]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 3/4, AutoSize6(374) +  titleLabel.bottom  + AutoSize6(37)) text:@"猫头鹰形" image:@"find_4_12"selectImage:@"" tag:112]];
    [self.view addSubview:[self makeCellView:CGPointMake(0, AutoSize6(561) +  titleLabel.bottom  + AutoSize6(37)) text:@"鹰形" image:@"find_4_13"selectImage:@"" tag:10]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 4, AutoSize6(561) +  titleLabel.bottom  + AutoSize6(37)) text:@"鹤形" image:@"find_4_14"selectImage:@"" tag:113]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/4, AutoSize6(561) +  titleLabel.bottom  + AutoSize6(37)) text:@" 鸻鹬形" image:@"find_4_15"selectImage:@"" tag:114]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 3/4, AutoSize6(561) +  titleLabel.bottom  + AutoSize6(37)) text:@"其他" image:@"find_4_16"selectImage:@"" tag:115]];

    UIButton *footButton = [[UIButton alloc] initWithFrame:CGRectMake(AutoSize6(50), self.view.height - AutoSize6(300), SCREEN_WIDTH - AutoSize6(100), AutoSize6(84))];
    [footButton setTitle:@"下一步" forState:UIControlStateNormal];
    [footButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    footButton.backgroundColor = kColorDefaultColor;
    [self.view addSubview:footButton];
    [footButton addTarget:self action:@selector(footButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)footButtonDidClick {
    FindColorViewController *headvc = [[FindColorViewController alloc] init];
    [self.navigationController pushViewController:headvc animated:YES];
}

- (UIView *)makeCellView:(CGPoint)point text:(NSString *)text image:(NSString *)image selectImage:(NSString *)selectImage tag:(NSInteger)tag {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, SCREEN_WIDTH / 4, AutoSize6(187))];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIView *linetop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backView.width, 0.5)];
    linetop.backgroundColor = kColorTextColord2d2d2;
    [backView addSubview:linetop];
    
    UIView *linebottom = [[UIView alloc] initWithFrame:CGRectMake(0, backView.height, backView.width, 0.5)];
    linebottom.backgroundColor = kColorTextColord2d2d2;
    [backView addSubview:linebottom];
    
    UIView *lineleft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, backView.height)];
    lineleft.backgroundColor = kColorTextColord2d2d2;
    [backView addSubview:lineleft];
    
    UIView *lineright = [[UIView alloc] initWithFrame:CGRectMake(backView.width - 0.5, 0, 0.5, backView.height)];
    lineright.backgroundColor = kColorTextColord2d2d2;
    [backView addSubview:lineright];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, AutoSize6(22), backView.width, AutoSize6(122))];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateSelected];
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    [backView addSubview:button];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, button.bottom + AutoSize6(10), backView.width, AutoSize6(23))];
    stepLabel.text = text;
    stepLabel.font = kFont6(22);
    stepLabel.textColor = kColorTextColor333333;
    stepLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:stepLabel];
    
    return backView;
    
}

- (void)buttonDidClick:(UIButton *)button {
    
    if (button.tag == self.selectButton.tag) {
        return;
    }
    self.selectButton.selected = NO;
    button.selected = YES;
    self.selectButton = button;
    
}

@end
