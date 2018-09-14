//
//  LogTableView.h
//  LoveBird
//
//  Created by cheli shan on 2018/9/14.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"

@interface LogTableView : UIView<JXPagerViewListViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;


@property (nonatomic, copy) NSString *taid;

@property (nonatomic, copy) NSString *matchid;


@end
