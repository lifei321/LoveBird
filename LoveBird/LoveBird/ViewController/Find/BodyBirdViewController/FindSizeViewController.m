//
//  FindSizeViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/19.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "FindSizeViewController.h"

@interface FindSizeViewController ()

@property (nonatomic, strong) UIButton *buttonOne;

@property (nonatomic, strong) UIButton *buttonTwo;

@property (nonatomic, strong) UIButton *buttonThree;

@property (nonatomic, strong) UIButton *buttonFoure;

@property (nonatomic, strong) UIView *hightLightView;


@end

@implementation FindSizeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"体型查鸟";
    self.rightButton.title = @"完成";
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), total_topView_height + AutoSize6(37), AutoSize6(40), AutoSize6(40))];
    stepLabel.text = @"1";
    stepLabel.font = kFont6(36);
    stepLabel.textColor = [UIColor whiteColor];
    stepLabel.textAlignment = NSTextAlignmentCenter;
    stepLabel.backgroundColor = kColorDefaultColor;
    stepLabel.layer.cornerRadius = stepLabel.width / 2;
    stepLabel.layer.masksToBounds = YES;
    [self.view addSubview:stepLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(stepLabel.right + AutoSize6(10), stepLabel.top, SCREEN_WIDTH - AutoSize6(100), AutoSize6(40))];
    titleLabel.text = @"它的大小？";
    titleLabel.font = kFontBold6(36);
    titleLabel.textColor = kColorTextColor333333;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLabel];
    
    
    CGFloat height = AutoSize6(500) + total_topView_height;
    // 图片
    self.buttonOne = [self makeButton:CGRectMake(AutoSize6(108), height - AutoSize6(56), AutoSize6(136), AutoSize6(56)) image:@"0-30_black" selectImage:@"0-30_green" sel:@selector(buttonOneDidClick:)];
    [self.view addSubview:self.buttonOne];
    [self.view addSubview: [self creatLineView:self.buttonOne.left]];
    self.buttonOne.tag = 100;
    [self.view addSubview:[self makeLabel:self.buttonOne.left text:@"0-30"]];
    
    self.buttonTwo = [self makeButton:CGRectMake(self.buttonOne.right, height - AutoSize6(84), AutoSize6(136), AutoSize6(84)) image:@"30-60_black" selectImage:@"30-60_green" sel:@selector(buttonOneDidClick:)];
    [self.view addSubview:self.buttonTwo];
    [self.view addSubview: [self creatLineView:self.buttonTwo.left]];
    self.buttonTwo.tag = 200;
    [self.view addSubview:[self makeLabel:self.buttonTwo.left text:@"30-60"]];

    
    self.buttonThree = [self makeButton:CGRectMake(self.buttonTwo.right, height - AutoSize6(124), AutoSize6(136), AutoSize6(124)) image:@"60-90_black" selectImage:@"60-90_green" sel:@selector(buttonOneDidClick:)];
    [self.view addSubview:self.buttonThree];
    [self.view addSubview: [self creatLineView:self.buttonThree.left]];
    self.buttonThree.tag = 300;
    [self.view addSubview:[self makeLabel:self.buttonThree.left text:@"60-90"]];

    
    self.buttonFoure = [self makeButton:CGRectMake(self.buttonThree.right, height - AutoSize6(178), AutoSize6(136), AutoSize6(178)) image:@"90_black" selectImage:@"90_green" sel:@selector(buttonOneDidClick:)];
    [self.view addSubview:self.buttonFoure];
    [self.view addSubview: [self creatLineView:self.buttonFoure.left]];
    self.buttonFoure.tag = 400;
    [self.view addSubview:[self makeLabel:self.buttonFoure.left text:@">90"]];

    self.hightLightView = [self creatHightLineView:-1000];
    [self.view addSubview:self.hightLightView];
    
    UIButton *footButton = [[UIButton alloc] initWithFrame:CGRectMake(AutoSize6(50), self.view.height - AutoSize6(300), SCREEN_WIDTH - AutoSize6(100), AutoSize6(84))];
    [footButton setTitle:@"下一步" forState:UIControlStateNormal];
    [footButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    footButton.backgroundColor = kColorDefaultColor;
    [self.view addSubview:footButton];
    [footButton addTarget:self action:@selector(footButtonDidClick) forControlEvents:UIControlEventTouchUpInside];

}

- (void)footButtonDidClick {
    
}

- (UIButton *)makeButton:(CGRect)frame image:(NSString *)image selectImage:(NSString *)selectImage sel:(SEL)action {
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void)buttonOneDidClick:(UIButton *)button {
    UIButton *selectButton = [self getButtonSelected];
    if (selectButton) {
        selectButton.selected = NO;
    }
    
    button.selected = YES;
    
    
    if (button.tag == 100) {
        self.hightLightView.left = self.buttonOne.left;
    } else if (button.tag == 200) {
        self.hightLightView.left = self.buttonTwo.left;
    }  else if (button.tag == 300) {
        self.hightLightView.left = self.buttonThree.left;
    }  else if (button.tag == 400) {
        self.hightLightView.left = self.buttonFoure.left;
    }
}

- (UIButton *)getButtonSelected {
    if (self.buttonOne.selected) {
        return self.buttonOne;
    }
    
    if (self.buttonTwo.selected) {
        return self.buttonTwo;
    }
    
    if (self.buttonThree.selected) {
        return self.buttonThree;
    }
    
    if (self.buttonFoure.selected) {
        return self.buttonFoure;
    }
    
    return nil;
}


- (UIView *)creatLineView:(CGFloat)left {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(left, AutoSize6(541) + total_topView_height, AutoSize6(136), 1)];
    lineView.backgroundColor = UIColorFromRGB(0xb2b2b2);
    
    UIView *roundView1 = [[UIView alloc] initWithFrame:CGRectMake(- AutoSize6(8), - AutoSize6(8), AutoSize6(15), AutoSize6(15))];
    roundView1.layer.cornerRadius = roundView1.width / 2;
    roundView1.layer.masksToBounds = YES;
    roundView1.backgroundColor = UIColorFromRGB(0xb2b2b2);
    [lineView addSubview:roundView1];
    
    UIView *roundView2 = [[UIView alloc] initWithFrame:CGRectMake(lineView.width - AutoSize6(8), - AutoSize6(8), AutoSize6(15), AutoSize6(15))];
    roundView2.layer.cornerRadius = roundView1.width / 2;
    roundView2.layer.masksToBounds = YES;
    roundView2.backgroundColor = UIColorFromRGB(0xb2b2b2);
    [lineView addSubview:roundView2];
    
    return lineView;
}


- (UIView *)creatHightLineView:(CGFloat)left {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(left, AutoSize6(541) + total_topView_height, AutoSize6(136), 1)];
    lineView.backgroundColor = kColorDefaultColor;
    
    UIView *roundView1 = [[UIView alloc] initWithFrame:CGRectMake(- AutoSize6(9), - AutoSize6(9), AutoSize6(19), AutoSize6(19))];
    roundView1.layer.cornerRadius = roundView1.width / 2;
    roundView1.layer.masksToBounds = YES;
    roundView1.backgroundColor = kColorDefaultColor;
    [lineView addSubview:roundView1];
    
    UIView *roundView2 = [[UIView alloc] initWithFrame:CGRectMake(lineView.width - AutoSize6(9), - AutoSize6(9), AutoSize6(19), AutoSize6(19))];
    roundView2.layer.cornerRadius = roundView1.width / 2;
    roundView2.layer.masksToBounds = YES;
    roundView2.backgroundColor = kColorDefaultColor;
    [lineView addSubview:roundView2];
    
    return lineView;
}


- (UILabel *)makeLabel:(CGFloat)left text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left, AutoSize6(551) + total_topView_height, AutoSize6(136), AutoSize6(50))];
    label.text = text;
    label.font = kFont6(26);
    label.textColor = kColorTextColor333333;
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

@end
