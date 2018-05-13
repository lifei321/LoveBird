//
//  PublishSelectCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseTableViewCell.h"
#import "FindSelectBirdModel.h"

@class PublishSelectCell;
@protocol PublishSelectDelegate<NSObject>

- (void)publishSelectCellLessDelegate:(PublishSelectCell *)cell;

- (void)publishSelectCellAddDelegate:(PublishSelectCell *)cell;

- (void)publishSelectCellDeleteDelegate:(PublishSelectCell *)cell;

@end


@interface PublishSelectCell : AppBaseTableViewCell

@property (nonatomic, strong) FindSelectBirdModel *selectModel;

@property (nonatomic, weak) id<PublishSelectDelegate>delegate;

@end
