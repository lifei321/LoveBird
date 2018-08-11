//
//  ShequZuzhiController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/19.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "ShequZuzhiController.h"
#import "ShequZuzhiCell.h"
#import "AppTagsView.h"
#import "ShequZuzhiModel.h"

@interface ShequZuzhiController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ShequZuzhiController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    
    // 设置UI
    [self setTableView];
    
}

#pragma mark-- tabelView 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShequZuzhiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShequZuzhiCell class]) forIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        cell.isShow = NO;

        cell.dataArray = [self.dataModel.group copy];
        
    } else {
        cell.isShow = YES;
        cell.dataArray = [self.dataModel.sort copy];
    }
    
    @weakify(cell);
    cell.tagBlock = ^(NSInteger selectIndex) {
        @strongify(cell);
        if (cell.isShow) {
            self.sortId = ((ShequZuzhiModel *)self.dataModel.sort[selectIndex]).birdId;
        } else {
            self.groupId = ((ShequZuzhiModel *)self.dataModel.group[selectIndex]).birdId;
        }
        [self rightButtonAction];
    };
    return cell;
}

- (void)rightButtonAction {
    if (self.viewControllerActionBlock) {
        self.viewControllerActionBlock(self, nil);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *array = [NSMutableArray new];

    if (indexPath.section == 1) {
        for (ShequZuzhiModel *model in self.dataModel.group) {
            [array addObject:model.name];
        }
    } else {
        for (ShequZuzhiModel *model in self.dataModel.sort) {
            [array addObject:model.name];
        }
    }
    return [AppTagsView getHeight:array width:SCREEN_WIDTH] + AutoSize6(10);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return AutoSize6(70);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(70))];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(30), SCREEN_WIDTH -  AutoSize6(60), AutoSize6(40))];
    label.font = kFont6(26);
    label.textColor = UIColorFromRGB(0x7f7f7f);
    [headView addSubview:label];
    
    if (section == 0) {
        label.text = @"分类";
    } else if (section == 1) {
        label.text = @"大家都在搜";
    }
    
    return headView;
}

- (void)setNavigation {
    
    self.title = @"社区";
    
//    self.rightButton.title = @"完成";
//    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateNormal];
//    [self.rightButton setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName: kFont6(30)} forState:UIControlStateHighlighted];
    
    
}

- (void)setTableView {
    
    self.tableView.top = total_topView_height;
    self.tableView.height = SCREEN_HEIGHT - total_topView_height;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ShequZuzhiCell class] forCellReuseIdentifier:NSStringFromClass([ShequZuzhiCell class])];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize6(50))];
    
}

@end
