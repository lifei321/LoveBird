//
//  FindColorViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/20.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindColorViewController.h"

@interface FindColorViewController ()

@end

@implementation FindColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"体型查鸟";
    self.rightButton.title = @"完成";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), total_topView_height + AutoSize6(37), AutoSize6(40), AutoSize6(40))];
    stepLabel.text = @"4";
    stepLabel.font = kFont6(30);
    stepLabel.textColor = [UIColor whiteColor];
    stepLabel.textAlignment = NSTextAlignmentCenter;
    stepLabel.backgroundColor = kColorDefaultColor;
    stepLabel.layer.cornerRadius = stepLabel.width / 2;
    stepLabel.layer.masksToBounds = YES;
    [self.view addSubview:stepLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(stepLabel.right + AutoSize6(10), stepLabel.top, SCREEN_WIDTH - AutoSize6(100), AutoSize6(40))];
    titleLabel.text = @"它的颜色？";
    titleLabel.font = kFontBold6(36);
    titleLabel.textColor = kColorTextColor333333;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    
    [self.view addSubview:[self makeCellView:CGPointMake(0, titleLabel.bottom + AutoSize6(37)) text:@"黑色" image:@"step_4_1"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 3, titleLabel.bottom  + AutoSize6(37)) text:@"灰色" image:@"step_4_2"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/3, titleLabel.bottom  + AutoSize6(37)) text:@"白色" image:@"step_4_3"]];
    [self.view addSubview:[self makeCellView:CGPointMake(0, AutoSize6(172) + titleLabel.bottom  + AutoSize6(37)) text:@"红色" image:@"step_4_4"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 3, AutoSize6(172) +  titleLabel.bottom  + AutoSize6(37)) text:@"橙色" image:@"step_4_5"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/ 3, AutoSize6(172) + titleLabel.bottom + AutoSize6(37)) text:@"黄色" image:@"step_4_6"]];
    [self.view addSubview:[self makeCellView:CGPointMake(0, AutoSize6(344) + titleLabel.bottom + AutoSize6(37)) text:@"褐色" image:@"step_4_7"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 3, AutoSize6(344) + titleLabel.bottom + AutoSize6(37)) text:@"绿色" image:@"step_4_8"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH *2 / 3, AutoSize6(344) + titleLabel.bottom + AutoSize6(37)) text:@"蓝色" image:@"step_4_9"]];

    UIButton *footButton = [[UIButton alloc] initWithFrame:CGRectMake(AutoSize6(50), self.view.height - AutoSize6(300), SCREEN_WIDTH - AutoSize6(100), AutoSize6(84))];
    [footButton setTitle:@"下一步" forState:UIControlStateNormal];
    [footButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    footButton.backgroundColor = kColorDefaultColor;
    [self.view addSubview:footButton];
    [footButton addTarget:self action:@selector(footButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)footButtonDidClick {
//    FindBodyViewController *headvc = [[FindBodyViewController alloc] init];
//    [self.navigationController pushViewController:headvc animated:YES];
}

- (UIView *)makeCellView:(CGPoint)point text:(NSString *)text image:(NSString *)image {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, SCREEN_WIDTH / 3, AutoSize6(172))];
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
    
    UIView *lineright = [[UIView alloc] initWithFrame:CGRectMake(backView.width, 0, 0.5, backView.height)];
    lineright.backgroundColor = kColorTextColord2d2d2;
    [backView addSubview:lineright];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(75), AutoSize6(40), AutoSize6(98), AutoSize6(60))];
//    imageView.centerX = backView.centerX;
    imageView.image = [UIImage imageNamed:image];
    imageView.contentMode = UIViewContentModeCenter;
    [backView addSubview:imageView];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom, backView.width, AutoSize6(70))];
    stepLabel.text = text;
    stepLabel.font = kFont6(22);
    stepLabel.textColor = kColorTextColor333333;
    stepLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:stepLabel];
    
    return backView;
    
}



@end
