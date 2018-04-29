//
//  AppBaseTableDataSource.h
//  LoveBird
//
//  Created by ShanCheli on 2017/11/17.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void (^LFDeleteCellBlock) (void);


@protocol LFBaseTableDataSourceDelegate <NSObject>

- (void)didDeleteTableCell:(UITableView *)tableView object:(NSObject *)object deleCellBlock:(LFDeleteCellBlock)deleCellBlock;

@end

@interface AppBaseTableDataSource : NSObject<UITableViewDataSource>


@property (nonatomic, weak) id delegate;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property (nonatomic, strong) UISearchDisplayController *searchControl;
#pragma clang diagnostic pop


/**
 *  tableview 可变数组
 */
@property (nonatomic, strong) NSMutableArray *tableListArray;

/**
 *  cell标示
 */
@property (nonatomic, strong) NSString *identifier;

/**
 *  是否编辑
 */
@property (nonatomic, assign) BOOL isEdit;

/**
 * 设定cell对应的类, 如果有多种cell, 请使用cellModel的cellClass属性
 */

@property (nonatomic, strong) Class cellClass;

/**
 *  搜索数据源
 */
@property (nonatomic, strong) NSMutableArray *searchDataArray;

/**
 *  过滤数据
 */
-(void)filteredFriendArray;

@end
