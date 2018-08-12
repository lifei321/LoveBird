//
//  CaogaoTableViewCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/8/11.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseTableViewCell.h"
#import "MineCaogaoModel.h"

@class CaogaoTableViewCell;
@protocol CaogaoDelegate <NSObject>

- (void)caogaoCellEditDidClick:(CaogaoTableViewCell *)cell;

- (void)caogaoCellPublishDidClick:(CaogaoTableViewCell *)cell;

@end

@interface CaogaoTableViewCell : UITableViewCell

@property (nonatomic, strong) MineCaogaoModel *caogaomodel;

@property (nonatomic, weak) id<CaogaoDelegate>delegate;

@end
