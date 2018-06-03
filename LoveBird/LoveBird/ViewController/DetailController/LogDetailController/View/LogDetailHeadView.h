//
//  LogDetailHeadView.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/28.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogDetailModel.h"
#import "LogContentModel.h"

@interface LogDetailHeadView : UIView

@property (nonatomic, strong) LogDetailModel *detailModel;

@property (nonatomic, strong) LogContentModel *contentModel;

- (CGFloat)getHeight;

@end
