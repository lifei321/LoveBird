//
//  ShequFrameModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/15.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShequModel.h"

@interface ShequFrameModel : NSObject

@property (nonatomic, strong) ShequModel *shequModel;


// cell的高度
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGRect headViewFrame;

@property (nonatomic, assign) CGRect backViewFrame;

@property (nonatomic, assign) CGRect titleLabelFrame;

@property (nonatomic, assign) CGRect lineViewFrame;

@property (nonatomic, assign) CGRect contentImageViewFrame;

@property (nonatomic, assign) CGRect bottomViewFrame;

@property (nonatomic, assign) CGRect timeLabelFrame;

@end
