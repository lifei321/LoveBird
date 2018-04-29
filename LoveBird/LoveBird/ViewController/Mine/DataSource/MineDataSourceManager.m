//
//  MineDataSourceManager.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "MineDataSourceManager.h"
#import "AppBaseCellModel.h"

#import "QuestionViewController.h"
#import "FeedBackViewController.h"
#import "AboutUsViewController.h"


@implementation MineDataSourceManager


+ (NSArray *)DataSource {
    
    NSMutableArray *tableListArray = [NSMutableArray arrayWithArray:@[[NSMutableArray new]]];
    
    AppBaseCellModel *cellModel7 = [[AppBaseCellModel alloc] init];
    cellModel7.title = @"常见问题";
    cellModel7.image = [UIImage imageNamed:@"question"];
    cellModel7.userInfo = @(NO);
    cellModel7.pushViewController = NSStringFromClass([QuestionViewController class]);
    [tableListArray[0] addObject:cellModel7];
    
    AppBaseCellModel *cellModel8 = [[AppBaseCellModel alloc] init];
    cellModel8.title = @"意见反馈";
    cellModel8.image = [UIImage imageNamed:@"feed_back"];
    cellModel8.userInfo = @(NO);
    cellModel8.pushViewController = NSStringFromClass([FeedBackViewController class]);
    [tableListArray[0] addObject:cellModel8];
    
    AppBaseCellModel *cellModel9 = [[AppBaseCellModel alloc] init];
    cellModel9.title = @"关于我们";
    cellModel9.image = [UIImage imageNamed:@"about_us"];
    cellModel9.userInfo = @(NO);
    cellModel9.pushViewController = NSStringFromClass([AboutUsViewController class]);
    [tableListArray[0] addObject:cellModel9];

    return tableListArray;

}

@end
