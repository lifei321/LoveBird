//
//  SearchViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/20.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "SearchViewController.h"
#import "MineFollowController.h"
#import "FindBodyResultController.h"


@interface SearchViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *searchField;

@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, strong) MineFollowController *followController;
@property (nonatomic, strong) FindBodyResultController *birdClassController;

//@property (nonatomic, strong) MineFollowController *followController;
//@property (nonatomic, strong) MineFollowController *followController;

@property (nonatomic, strong) UIView *selectView;

@end

@implementation SearchViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = kColoreDefaultBackgroundColor;
    [self setNavigation];
    self.selectView = [self makeSelectView:CGRectMake(AutoSize6(0), total_topView_height, SCREEN_WIDTH, AutoSize6(70))];
    [self.view addSubview:self.selectView];
    
    self.followController = [[MineFollowController alloc] init];
    self.followController.type = 3;
    
    self.birdClassController = [[FindBodyResultController alloc] init];
}

- (void)netForData {
    
    if (!self.searchField.text.length) {
        [AppBaseHud showHudWithfail:@"请输入搜索内容" view:self.view];
        return;
    }
    
    NSInteger tag = self.selectButton.tag;
    if (tag == 101) {
        self.birdClassController.word = self.searchField.text;
        [self.view addSubview:self.birdClassController.view];
        self.birdClassController.view.frame = CGRectMake(0, AutoSize6(80), SCREEN_WIDTH, self.view.height - AutoSize6(80));
        
    } else if (tag == 102) {
        
    } else if (tag == 103) {
        self.followController.word = self.searchField.text;
        [self.view addSubview:self.followController.view];
        self.followController.view.frame = CGRectMake(0, AutoSize6(80), SCREEN_WIDTH, self.view.height - AutoSize6(80));
        
    } else if (tag == 104) {
        
    }
    [self.view bringSubviewToFront:self.selectView];
}

- (void)selectButtonDidClick:(UIButton *)button {
    if (button.selected) {
        return;
    }
    button.selected = YES;
    self.selectButton.selected = NO;
    self.selectButton = button;
    
    [self netForData];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.searchField endEditing:YES];
    [self netForData];
}

- (UIView *)makeSelectView:(CGRect)frame {
    UIView *backView = [[UIView alloc] initWithFrame:frame];
    backView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [self makeButton:@"鸟种" image:@"search_no" selectImage:@"search_yes" tag:101];
    button1.frame = CGRectMake(AutoSize6(40), 0, AutoSize6(100), backView.height);
    [backView addSubview:button1];
    self.selectButton = button1;
    button1.selected = YES;
    
    UIButton *button2 = [self makeButton:@"话题" image:@"search_no" selectImage:@"search_yes" tag:102];
    button2.frame = CGRectMake(button1.right, 0, AutoSize6(100), backView.height);
    [backView addSubview:button2];

    UIButton *button3 = [self makeButton:@"用户" image:@"search_no" selectImage:@"search_yes" tag:103];
    button3.frame = CGRectMake(button2.right, 0, AutoSize6(100), backView.height);
    [backView addSubview:button3];

    UIButton *button4 = [self makeButton:@"资讯.装备" image:@"search_no" selectImage:@"search_yes" tag:104];
    button4.frame = CGRectMake(button3.right, 0, AutoSize6(165), backView.height);
    [backView addSubview:button4];

    
    return backView;
}

- (UIButton *)makeButton:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage tag:(NSInteger)tag {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kColorTextColorLightGraya2a2a2 forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    btn.tag = tag;
    btn.titleLabel.font = kFont6(27);
    [btn addTarget:self action:@selector(selectButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)setNavigation {
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - AutoSize6(100), AutoSize6(60))];
    _searchField.placeholder = @"请输入...";
    _searchField.layer.cornerRadius = _searchField.height / 2;
    _searchField.backgroundColor = [UIColor whiteColor];
    _searchField.font = kFont6(26);
    _searchField.layer.borderColor = (kLineColoreDefaultd4d7dd).CGColor;
    _searchField.layer.borderWidth = 1;
    _searchField.layer.cornerRadius = 3;
    _searchField.delegate = self;
    
    CGRect frame = _searchField.frame;
    frame.size.width = AutoSize6(15);// 距离左侧的距离
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    _searchField.leftViewMode = UITextFieldViewModeAlways;
    _searchField.leftView = leftview;
    
    CGRect rightframe = _searchField.frame;
    rightframe.size.width = AutoSize(35);// 距离左侧的距离
    UIImageView *rightview = [[UIImageView alloc] initWithFrame:rightframe];
    rightview.image = [UIImage imageNamed:@"pub_search"];
    rightview.contentMode = UIViewContentModeCenter;
    _searchField.rightViewMode = UITextFieldViewModeAlways;
    _searchField.rightView = rightview;
    
    self.navigationItem.titleView = _searchField;
    
    self.leftButton.image = [UIImage imageNamed:@""];
    [self.rightButton setTitle:@"返回"];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    
    self.navigationBar.backgroundColor = kLineColoreDefaultd4d7dd;
}

- (void)rightButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end