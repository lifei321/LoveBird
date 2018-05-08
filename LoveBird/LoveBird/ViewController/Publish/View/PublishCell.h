//
//  PublishCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublishEditModel.h"

typedef void(^PublishCellBlock)();


@class PublishCell;
@protocol PublishCellDelegate<NSObject>

- (void)publishCellCloseDelegate:(PublishCell *)cell ;

- (void)publishCellUpDelegate:(PublishCell *)cell ;

- (void)publishCellDownDelegate:(PublishCell *)cell ;

- (void)publishCellTextDelegate:(PublishCell *)cell ;

- (void)publishCellImageDelegate:(PublishCell *)cell ;

- (void)publishCellAddDelegate:(PublishCell *)cell ;

@end


@interface PublishCell : UITableViewCell

@property (nonatomic, strong) PublishEditModel *editModel;

@property (nonatomic, weak) id<PublishCellDelegate>delegate;

@end
