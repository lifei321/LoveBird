//
//  ShequZuzhiCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/19.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppTagsView.h"

@interface ShequZuzhiCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) BOOL isShow;


@property (nonatomic, assign) NSInteger cellType;


@property (nonatomic, strong) AppTagsViewBlock tagBlock;


@end
