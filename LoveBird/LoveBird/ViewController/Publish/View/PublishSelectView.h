//
//  PublishSelectView.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublishCell.h"

@interface PublishSelectView : UIView

@property (nonatomic, strong) PublishCellBlock lessblock;

@property (nonatomic, strong) PublishCellBlock addblock;

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, strong) UITextField *countTextField;



@end
