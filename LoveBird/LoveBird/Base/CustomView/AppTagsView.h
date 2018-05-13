//
//  AppTagsView.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/13.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublishEVModel.h"

typedef void(^AppTagsViewBlock)(PublishEVModel *selectModel);

@interface AppTagsView : UIView

/**
 *  初始化
 *
 *  @param frame    frame
 *
 */
- (instancetype)initWithFrame:(CGRect)frame;

// 标签数组
@property (nonatomic,retain) NSArray* tagArray;

// 选中标签文字颜色
@property (nonatomic,retain) UIColor* textColorSelected;
// 默认标签文字颜色
@property (nonatomic,retain) UIColor* textColorNormal;

// 选中标签背景颜色
@property (nonatomic,retain) UIColor* backgroundColorSelected;
// 默认标签背景颜色
@property (nonatomic,retain) UIColor* backgroundColorNormal;

@property (nonatomic, strong) PublishEVModel *selectModel;

@property (nonatomic, strong) AppTagsViewBlock tagblock;

@end
