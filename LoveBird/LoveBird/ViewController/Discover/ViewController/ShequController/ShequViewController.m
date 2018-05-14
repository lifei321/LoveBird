//
//  ShequViewController.m
//  LoveBird
//
//  Created by cheli shan on 2018/5/14.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ShequViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

@interface ShequViewController ()<SDCycleScrollViewDelegate>

// 轮播图
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;



@end

@implementation ShequViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setTableView];
    
    
}

#pragma mark-- tableview 代理
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AutoSize6(20);
    }
    
    return 0.01f;
}


#pragma mark - 轮播图代理

// 图片滚动
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

// 图片点击
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}


#pragma mark-- UI
- (void)setNavigation {
    self.navigationItem.title = @"社区";
    [self.rightButton setImage:[UIImage imageNamed:@"shequ_right"]];
}


- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = kColoreDefaultBackgroundColor;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView registerClass:[PublishSelectCell class] forCellReuseIdentifier:NSStringFromClass([PublishSelectCell class])];
//    [self.tableView registerClass:[PublishDetailCell class] forCellReuseIdentifier:NSStringFromClass([PublishDetailCell class])];
//    [self.tableView registerClass:[PublishCell class] forCellReuseIdentifier:NSStringFromClass([PublishCell class])];
    
    self.cycleScrollView.delegate = self;
    self.tableView.tableHeaderView = self.cycleScrollView;
    
}



- (SDCycleScrollView *)cycleScrollView {
    
    if (_cycleScrollView == nil) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(400)) delegate:self placeholderImage:[UIImage imageNamed:@""]];
        _cycleScrollView.backgroundColor = [UIColor orangeColor];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    }
    return _cycleScrollView;
}

@end
