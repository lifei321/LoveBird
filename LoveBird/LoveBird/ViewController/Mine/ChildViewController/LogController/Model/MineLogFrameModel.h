//
//  MineLogFrameModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/26.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ShequModel.h"

@interface MineLogFrameModel : NSObject

@property (nonatomic, strong) ShequModel *shequModel;


// cell的高度
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGRect backViewFrame;

@property (nonatomic, assign) CGRect titleLabelFrame;

@property (nonatomic, assign) CGRect dayLabelFrame;

@property (nonatomic, assign) CGRect monthLabelFrame;

@property (nonatomic, assign) CGRect lineViewFrame;

@property (nonatomic, assign) CGRect contentImageViewFrame;

@property (nonatomic, assign) CGRect subjectLabelFrame;

@property (nonatomic, assign) CGRect countLabelFrame;


@property (nonatomic, assign) CGRect timeLabelFrame;

@property (nonatomic, assign) CGRect moreButtonFrame;

@property (nonatomic, assign) BOOL isFirst;


@end
