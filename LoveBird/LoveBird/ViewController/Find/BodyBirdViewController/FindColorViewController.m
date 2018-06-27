//
//  FindColorViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/20.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindColorViewController.h"
#import "FindHeadViewController.h"
#import "FindBodyResultController.h"
#import "FindDao.h"
#import "FindDisplayShapeModel.h"

@interface FindColorViewController ()
@property (nonatomic, strong) UIButton *selectButton;

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
    stepLabel.text = @"3";
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
    
    [self.view addSubview:[self makeCellView:CGPointMake(0, titleLabel.bottom + AutoSize6(37)) text:@"黑色" image:@"step_4_1" selectImage:@"step_yes_4_1" enabel:@"step_no_4_1" tag:301]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 3, titleLabel.bottom  + AutoSize6(37)) text:@"灰色" image:@"step_4_2" selectImage:@"step_yes_4_2" enabel:@"step_no_4_2" tag:302]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/3, titleLabel.bottom  + AutoSize6(37)) text:@"白色" image:@"step_4_3" selectImage:@"step_yes_4_3" enabel:@"step_no_4_3" tag:303]];
    [self.view addSubview:[self makeCellView:CGPointMake(0, AutoSize6(172) + titleLabel.bottom  + AutoSize6(37)) text:@"红色" image:@"step_4_4" selectImage:@"step_yes_4_4" enabel:@"step_no_4_4" tag:304]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 3, AutoSize6(172) +  titleLabel.bottom  + AutoSize6(37)) text:@"橙色" image:@"step_4_5" selectImage:@"step_yes_4_5" enabel:@"step_no_4_5" tag:305]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH * 2/ 3, AutoSize6(172) + titleLabel.bottom + AutoSize6(37)) text:@"黄色" image:@"step_4_6" selectImage:@"step_yes_4_6" enabel:@"step_no_4_6" tag:306]];
    [self.view addSubview:[self makeCellView:CGPointMake(0, AutoSize6(344) + titleLabel.bottom + AutoSize6(37)) text:@"褐色" image:@"step_4_7" selectImage:@"step_yes_4_7" enabel:@"step_no_4_7" tag:307]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH / 3, AutoSize6(344) + titleLabel.bottom + AutoSize6(37)) text:@"绿色" image:@"step_4_8" selectImage:@"step_yes_4_8" enabel:@"step_no_4_8" tag:308]];
    [self.view addSubview:[self makeCellView:CGPointMake(SCREEN_WIDTH *2 / 3, AutoSize6(344) + titleLabel.bottom + AutoSize6(37)) text:@"蓝色" image:@"step_4_9" selectImage:@"step_yes_4_9" enabel:@"step_no_4_9" tag:309]];

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
                       color:[self getKeyColor]
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

- (NSString *)getKeyColor {
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
    [FindDao getBirdDisplayHead:self.length shape:self.length color:[self getKeyColor] successBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        
        FindHeadViewController *headvc = [[FindHeadViewController alloc] init];
        headvc.shape = self.shape;
        headvc.color = [self getKeyColor];
        headvc.length = self.length;
        
        NSMutableArray *temp = [NSMutableArray new];
        for (id object in ((FindDisplayHeadModel *)responseObject).bill_code) {
            [temp addObject:[NSString stringWithFormat:@"%@", object]];
        }
        headvc.shapeArray = [NSArray arrayWithArray:temp];
        [self.navigationController pushViewController:headvc animated:YES];

    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
    }];
    

}

- (UIView *)makeCellView:(CGPoint)point text:(NSString *)text image:(NSString *)image selectImage:(NSString *)selectImage enabel:(NSString *)enabel tag:(NSInteger)tag {
    
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
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(AutoSize6(75), AutoSize6(40), AutoSize6(98), AutoSize6(60))];
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
    
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(75), AutoSize6(40), AutoSize6(98), AutoSize6(60))];
//    imageView.image = [UIImage imageNamed:image];
//    imageView.contentMode = UIViewContentModeCenter;
//    [backView addSubview:imageView];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, button.bottom, backView.width, AutoSize6(70))];
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
