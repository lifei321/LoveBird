//
//  AppBaseTableDataSource.m
//  LoveBird
//
//  Created by ShanCheli on 2017/11/17.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseTableDataSource.h"
#import "AppBaseCellModel.h"
#import "AppBaseTableViewCell.h"


@implementation AppBaseTableDataSource


- (NSMutableArray *)tableListArray {
    
    if (_tableListArray == nil) {
        _tableListArray = [NSMutableArray new];
    }
    return _tableListArray;
}

#pragma mark UITableViewDataSourceDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _tableListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tableListArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppBaseCellModel *cellModel;
    if ([tableView isMemberOfClass:[UITableView class]]) {
        cellModel = _tableListArray[indexPath.section][indexPath.row];
    } else  {
        cellModel = self.searchDataArray[indexPath.row];
    }
    
    if (cellModel.cellClass == nil) {
        //对cell类型没有要求,只有一种cell
        _identifier = NSStringFromClass(_cellClass);
        [tableView registerClass:_cellClass forCellReuseIdentifier:_identifier];
    } else {
        //多种
        _identifier = NSStringFromClass(cellModel.cellClass);
        [tableView registerClass:cellModel.cellClass forCellReuseIdentifier:_identifier];
    }
    
    // 如果有约束数据,则执行约束 block
    if (cellModel.constraintDataBlock) {
        
        cellModel.constraintDataBlock(cellModel);
    }
    
    AppBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier forIndexPath:indexPath];
    cell.model = cellModel;
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return _isEdit;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSObject *object = _tableListArray[indexPath.section][indexPath.row];
        
        
        [_delegate didDeleteTableCell:tableView object:object deleCellBlock:^{
            
            [_tableListArray[indexPath.section] removeObjectAtIndex:indexPath.row];
            
            if ([_tableListArray[indexPath.section] count] == 0) {
                [_tableListArray removeObjectAtIndex:indexPath.section];
                [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
            } else  {
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
    }
}

#pragma mark filteredFriendArray

/**
 *  获取输入的数组
 */
-(void)filteredFriendArray {
    
    // 子类实现
    
    
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


@end
