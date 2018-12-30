//
//  MatchDetailNoteTableView.h
//  LoveBird
//
//  Created by 十八子飞 on 2018/12/30.
//  Copyright © 2018 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatchDetailNoteTableView : UIView<JXPagerViewListViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;

@property (nonatomic, copy) NSString *matchid;

@end

NS_ASSUME_NONNULL_END
