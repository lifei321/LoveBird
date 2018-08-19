//
//  FindHeadViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/19.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindHeadViewController.h"
#import "FindBodyResultController.h"
#import "FindDao.h"

@interface FindHeadViewController ()

@property (nonatomic, strong) UIButton *selectButton;

@end

@implementation FindHeadViewController

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
    titleLabel.text = @"嘴头之比？";
    titleLabel.font = kFontBold6(36);
    titleLabel.textColor = kColorTextColor333333;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    
    [self.view addSubview:[self makeCellView:CGPointMake(0, titleLabel.bottom + AutoSize6(37)) text:@"≤1比3" image:@"step_yes_1_1" selectImage:@"step_no_1_1" tag:401 enabel:@"step_1_1"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 3, titleLabel.bottom  + AutoSize6(37)) text:@"≤1比2" image:@"step_yes_1_2" selectImage:@"step_no_1_2" tag:402 enabel:@"step_1_2"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/3, titleLabel.bottom  + AutoSize6(37)) text:@"≤1比1" image:@"step_yes_1_3" selectImage:@"step_no_1_3" tag:403 enabel:@"step_1_3"]];
    [self.view addSubview:[self makeCellView:CGPointMake(0, AutoSize6(208) + titleLabel.bottom  + AutoSize6(37)) text:@"≤2比1" image:@"step_yes_1_4" selectImage:@"step_no_1_4" tag:404 enabel:@"step_1_4"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 3, AutoSize6(208) +  titleLabel.bottom  + AutoSize6(37)) text:@">2比1" image:@"step_yes_1_5" selectImage:@"step_no_1_5" tag:405 enabel:@"step_1_5"]];

    UIButton *footButton = [[UIButton alloc] initWithFrame:CGRectMake(AutoSize6(50), self.view.height - AutoSize6(150), SCREEN_WIDTH - AutoSize6(100), AutoSize6(84))];
    [footButton setTitle:@"下一步" forState:UIControlStateNormal];
    [footButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    footButton.backgroundColor = kColorDefaultColor;
    [self.view addSubview:footButton];
    [footButton addTarget:self action:@selector(footButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)rightButtonAction {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [FindDao getBirdBillCode:[self getKeyBill]
                       color:self.color
                      length:self.length
                       shape:self.shape
                        page:@"1"
                successBlock:^(__kindof AppBaseModel *responseObject) {
                    @strongify(self);
                    [AppBaseHud hideHud:self.view];
                    
                    FindBodyResultController *resultVC = [[FindBodyResultController alloc] init];
                    resultVC.dataModel = (FindSelectBirdDataModel *)responseObject;
                    [self.navigationController pushViewController:resultVC animated:YES];
                    
                } failureBlock:^(__kindof AppBaseModel *error) {
                    @strongify(self);
                    
                    [AppBaseHud showHudWithfail:error.errstr view:self.view];
                }];
}

- (void)footButtonDidClick {
    [self rightButtonAction];
}

- (NSString *)getKeyBill {
    NSString *length;
    if (!self.selectButton) {
        length = @"0";
    } else {
        length = [NSString stringWithFormat:@"%ld", (long)self.selectButton.tag];
    }
    
    return length;
}
- (UIView *)makeCellView:(CGPoint)point text:(NSString *)text image:(NSString *)image selectImage:(NSString *)selectImage tag:(NSInteger)tag enabel:(NSString *)enabel {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, SCREEN_WIDTH / 3, AutoSize6(208))];
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
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.5, AutoSize6(24), backView.width - 0.5, AutoSize6(126))];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:enabel] forState:UIControlStateDisabled];

    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    [backView addSubview:button];
    
    if ([self.shapeArray containsObject:[NSString stringWithFormat:@"%ld", tag]]) {
        button.enabled = YES;
    } else {
        button.enabled = NO;
    }
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, button.bottom, backView.width, AutoSize6(58))];
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
