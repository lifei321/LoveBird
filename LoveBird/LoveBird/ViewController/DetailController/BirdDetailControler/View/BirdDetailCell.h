//
//  BirdDetailCell.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/2.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BirdDetailModel.h"

@interface BirdDetailCell : UITableViewCell


@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) BirdDetailModel *detailModel;


@property (nonatomic, copy) NSString *detail;

@property (nonatomic, assign) BOOL hasImage;

+ (CGFloat)getHeightWithModel:(BirdDetailModel *)model text:(NSString *)text img:(BOOL)img ;


@end
