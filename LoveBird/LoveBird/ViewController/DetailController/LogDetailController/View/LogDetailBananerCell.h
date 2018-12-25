//
//  LogDetailBananerCell.h
//  LoveBird
//
//  Created by 十八子飞 on 2018/12/24.
//  Copyright © 2018 shancheli. All rights reserved.
//

#import "AppBaseTableViewCell.h"
#import "LogDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LogDetailBananerCell : UITableViewCell


@property (nonatomic, strong) NSArray *dataArray;


+ (CGFloat)getHeightWithArray:(NSArray *)array;


@end

NS_ASSUME_NONNULL_END
