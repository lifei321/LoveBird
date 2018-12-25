//
//  PublishEVController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "PublishEVController.h"
#import "AppTagsView.h"
#import "PublishDao.h"

@interface PublishEVController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation PublishEVController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生存环境";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self netForData];
    
}

- (void)netForData {
    [AppBaseHud showHudWithLoding:self.view];
    
    @weakify(self);
    [PublishDao getEVSuccessBlock:^(__kindof AppBaseModel *responseObject) {
        @strongify(self);
        [AppBaseHud hideHud:self.view];
        PublishEVDataModel *dataModel = (PublishEVDataModel *)responseObject;
        [self creatViewWithArray:dataModel.data];
        self.dataArray = [NSArray arrayWithArray:dataModel.data];
        
    } failureBlock:^(__kindof AppBaseModel *error) {
        @strongify(self);
        [AppBaseHud showHudWithfail:error.errstr view:self.view];
        
    }];
}


- (void)backViewDidClick:(UITapGestureRecognizer *)tap {
    
    UIView *cellView = tap.view;
    
    NSInteger index = cellView.tag - 100;
    
    PublishEVModel *model = self.dataArray[index];
    
    [self.navigationController popViewControllerAnimated:YES];
    if (self.viewControllerActionBlock) {
        self.viewControllerActionBlock(self, model);
    }
}


- (void)creatViewWithArray:(NSArray *)dataArray {
    CGFloat width = SCREEN_WIDTH / 3;
    CGFloat height = AutoSize6(118) + AutoSize6(15) + AutoSize6(40);

    for (int i = 0; i < dataArray.count; i++) {
        CGPoint point = CGPointMake(width * (i % 3), i / 3 *height + total_topView_height);
        
        UIView *cellView = [self makeViewWithPoint:point model:dataArray[i] tag:i];
        [self.view addSubview:cellView];
    }
}

- (UIView *)makeViewWithPoint:(CGPoint)point model:(PublishEVModel *)evModel tag:(NSInteger)tag {
    
    CGFloat width = SCREEN_WIDTH / 3;
    CGFloat height = AutoSize6(118) + AutoSize6(15) + AutoSize6(40);
    
    //
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(point.x, point.y, width, height)];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AutoSize6(68), AutoSize6(15), AutoSize6(118), AutoSize6(118))];
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:evModel.imgUrl] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    [backView addSubview:iconImageView];
    iconImageView.layer.cornerRadius = iconImageView.width / 2;
    iconImageView.clipsToBounds = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, iconImageView.bottom + AutoSize6(10), width, AutoSize6(20))];
    label.textColor = kColorTextColor333333;
    label.font = kFont6(25);
    label.textAlignment = NSTextAlignmentCenter;
    label.text = evModel.name;
    [backView addSubview:label];
    backView.tag = 100 + tag;
    
    backView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewDidClick:)];
    [backView addGestureRecognizer:tap];
    
    
    UIView *lineLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, height)];
    lineLeft.backgroundColor = kLineColoreDefaultd4d7dd;
    [backView addSubview:lineLeft];
    
    UIView *lineRight = [[UIView alloc] initWithFrame:CGRectMake(width, 0, 1, height)];
    lineRight.backgroundColor = kLineColoreDefaultd4d7dd;
    [backView addSubview:lineRight];
    
    UIView *lineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 1)];
    lineTop.backgroundColor = kLineColoreDefaultd4d7dd;
//    [backView addSubview:lineTop];
    
    UIView *lineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, height - 1, width, 1)];
    lineBottom.backgroundColor = kLineColoreDefaultd4d7dd;
    [backView addSubview:lineBottom];
    
    
    return backView;
}

@end
