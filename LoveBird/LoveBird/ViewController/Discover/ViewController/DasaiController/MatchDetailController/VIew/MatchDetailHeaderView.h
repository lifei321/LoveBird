//
//  MatchDetailHeaderView.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/6.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchDetailModel.h"



@interface MatchDetailHeaderView : UIView

@property (nonatomic, strong) MatchDetailModel *detailModel;

- (CGFloat)getHeight;
@end
