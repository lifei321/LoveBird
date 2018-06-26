//
//  FindBodyViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/19.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindBodyViewController.h"
#import "FindColorViewController.h"
#import "FindBodyResultController.h"
#import "FindDao.h"
#import "FindDisplayShapeModel.h"

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
    stepLabel.text = @"2";
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
    
    [self.view addSubview:[self makeCellView:CGPointMake(0, titleLabel.bottom + AutoSize6(37)) text:@"燕子形" image:@"find_4_1" selectImage:@"find_4_yes_1" tag:201 enabel:@"find_4_no_1"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 4, titleLabel.bottom + AutoSize6(37)) text:@"喜鹊形" image:@"find_4_2"selectImage:@"find_4_yes_2" tag:202 enabel:@"find_4_no_2"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/4, titleLabel.bottom + AutoSize6(37)) text:@"山雀形" image:@"find_4_3"selectImage:@"find_4_yes_3" tag:203 enabel:@"find_4_no_3"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 3/4, titleLabel.bottom + AutoSize6(37)) text:@"啄木鸟形" image:@"find_4_4"selectImage:@"find_4_yes_4" tag:204 enabel:@"find_4_no_4"]];
    [self.view addSubview:[self makeCellView:CGPointMake(0, AutoSize6(187) + titleLabel.bottom  + AutoSize6(37)) text:@"麻雀形" image:@"find_4_5"selectImage:@"find_4_yes_5" tag:205 enabel:@"find_4_no_5"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 4, AutoSize6(187) +  titleLabel.bottom  + AutoSize6(37)) text:@"海鸥形" image:@"find_4_6"selectImage:@"find_4_yes_6" tag:206 enabel:@"find_4_no_6"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/4, AutoSize6(187) +  titleLabel.bottom  + AutoSize6(37)) text:@"天鹅形" image:@"find_4_7"selectImage:@"find_4_yes_7" tag:207 enabel:@"find_4_no_7"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 3/4, AutoSize6(187) +  titleLabel.bottom  + AutoSize6(37)) text:@"鸡形" image:@"find_4_8"selectImage:@"find_4_yes_8" tag:208 enabel:@"find_4_no_8"]];
    [self.view addSubview:[self makeCellView:CGPointMake(0, AutoSize6(374) +  titleLabel.bottom  + AutoSize6(37)) text:@"鸭子形" image:@"find_4_9"selectImage:@"find_4_yes_9" tag:209 enabel:@"find_4_no_9"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 4, AutoSize6(374) +  titleLabel.bottom  + AutoSize6(37)) text:@"鹦鹉形" image:@"find_4_10"selectImage:@"find_4_yes_10" tag:210 enabel:@"find_4_no_10"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/4, AutoSize6(374) +  titleLabel.bottom  + AutoSize6(37)) text:@"鸽子形" image:@"find_4_11"selectImage:@"find_4_yes_11" tag:211 enabel:@"find_4_no_11"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 3/4, AutoSize6(374) +  titleLabel.bottom  + AutoSize6(37)) text:@"猫头鹰形" image:@"find_4_12"selectImage:@"find_4_yes_12" tag:212 enabel:@"find_4_no_12"]];
    [self.view addSubview:[self makeCellView:CGPointMake(0, AutoSize6(561) +  titleLabel.bottom  + AutoSize6(37)) text:@"鹰形" image:@"find_4_13"selectImage:@"find_4_yes_13" tag:213 enabel:@"find_4_no_13"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 4, AutoSize6(561) +  titleLabel.bottom  + AutoSize6(37)) text:@"鹤形" image:@"find_4_14"selectImage:@"find_4_yes_14" tag:214 enabel:@"find_4_no_14"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/4, AutoSize6(561) +  titleLabel.bottom  + AutoSize6(37)) text:@" 鸻鹬形" image:@"find_4_15"selectImage:@"find_4_yes_15" tag:215 enabel:@"find_4_no_15"]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 3/4, AutoSize6(561) +  titleLabel.bottom  + AutoSize6(37)) text:@"其他" image:@"find_4_16"selectImage:@"find_4_yes_16" tag:2400 enabel:@"find_4_no_16"]];

    UIButton *footButton = [[UIButton alloc] initWithFrame:CGRectMake(AutoSize6(50), self.view.height - AutoSize6(300), SCREEN_WIDTH - AutoSize6(100), AutoSize6(84))];
    [footButton setTitle:@"下一步" forState:UIControlStateNormal];
    [footButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    footButton.backgroundColor = kColorDefaultColor;
    [self.view addSubview:footButton];
    [footButton addTarget:self action:@selector(footButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)rightButtonAction {
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [FindDao getBirdBillCode:nil
                       color:nil
                      length:self.length
                       shape:[self getKeyShape]
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

- (NSString *)getKeyShape {
    NSString *length;
    if (!self.selectButton) {
        length = @"0";
    } else {
        length = [NSString stringWithFormat:@"%ld", self.selectButton.tag];
    }
    
    return length;
}

- (void)footButtonDidClick {
    
    [AppBaseHud showHudWithLoding:self.view];
    @weakify(self);
    [FindDao getBirdDisplayColor:self.length shape:[self getKeyShape] successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        
        FindColorViewController *headvc = [[FindColorViewController alloc] init];
        headvc.shape = [self getKeyShape];
        headvc.length = self.length;
        
        NSMutableArray *temp = [NSMutableArray new];
        for (id object in ((FindDisplayColorModel *)responseObject).color_code) {
            [temp addObject:[NSString stringWithFormat:@"%@", object]];
        }
        headvc.shapeArray = [NSArray arrayWithArray:temp];
        [self.navigationController pushViewController:headvc animated:YES];

    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
}

- (UIView *)makeCellView:(CGPoint)point text:(NSString *)text image:(NSString *)image selectImage:(NSString *)selectImage tag:(NSInteger)tag enabel:(NSString *)enabel {
    
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
    
//    UIView *lineright = [[UIView alloc] initWithFrame:CGRectMake(backView.width - 0.5, 0, 0.5, backView.height)];
//    lineright.backgroundColor = kColorTextColord2d2d2;
//    [backView addSubview:lineright];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.5, AutoSize6(22), backView.width - 0.5, AutoSize6(122))];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
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
