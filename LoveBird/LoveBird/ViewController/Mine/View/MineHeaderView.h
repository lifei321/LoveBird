//
//  MineHeaderView.h
//  LoveBird
//
//  Created by cheli shan on 2018/4/29.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MineHeaderViewBlock)(NSInteger tag);

@interface MineHeaderView : UIView

@property (nonatomic, strong) MineHeaderViewBlock headerBlock;

@end
