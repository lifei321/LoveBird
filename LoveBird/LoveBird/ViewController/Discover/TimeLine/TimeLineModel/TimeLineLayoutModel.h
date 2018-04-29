//
//  TimeLineLayoutModel.h
//  LFBaseProject
//
//  Created by ShanCheli on 2018/1/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscoverContentModel.h"

@interface TimeLineLayoutModel : NSObject

@property (nonatomic, strong) DiscoverContentModel *contentModel;

// cell的高度
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGRect topViewFrame;

@property (nonatomic, assign) CGRect titleViewFrame;

@property (nonatomic, assign) CGRect contentImageViewFrame;

@property (nonatomic, assign) CGRect titleLabelFrame;

@property (nonatomic, assign) CGRect contentLabelFrame;

@property (nonatomic, assign) CGRect toolViewFrame;

@property (nonatomic, assign) CGRect bottomViewFrame;


@end
