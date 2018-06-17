//
//  AppBaseCellModel.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"
#import "AppTextField.h"

@class AppBaseCellModel;

/**
 *  cellModelblock
 */
typedef void(^LFCellUpdateBlock)(AppBaseCellModel *cellModel);


/**
 *  约束需要更新数据的block, 每次 tableview reload 的时会调用
 */
typedef void (^LFConstraintDataBlock) (AppBaseCellModel *cellModel);

@interface AppBaseCellModel : NSObject

/**
 *  text title
 */
@property (nonatomic, strong) NSString *title;

/**
 *  title color
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 *  detailText
 */
@property (nonatomic, strong) NSObject *detail;

/**
 *  detailColor
 */
@property (nonatomic, strong) UIColor *detailColor;

/**
 *  模型对应的cell类
 */
@property (nonatomic, strong) Class cellClass;

/**
 *  不需要push则留空
 */
@property (nonatomic, strong) NSString *pushViewController;

/**
 *  执行方法
 */
@property (nonatomic, strong) NSString *selector;

/**
 * left view
 */
@property (nonatomic, strong) UIView *leftView;

/**
 * left view
 */
@property (nonatomic, strong) UIView *rightView;

/**
 *  图标
 */
@property (nonatomic, strong) UIImage *image;

/**
 *  用户自定义字段
 */
@property (nonatomic, strong) NSObject *userInfo;

/**
 *  是否隐藏cell，如 hiden = YES, cell.hiden = YES;
 */
@property (nonatomic, assign) BOOL hidden;

// 是否选中
@property (nonatomic, assign) BOOL isSelect;


/**
 *  cell 样式
 */
@property (nonatomic, assign) UITableViewCellAccessoryType    accessoryType;

/**
 *  右侧表格 textfile, 会自动计算宽度, 只需指定 left 即可
 */
@property (nonatomic, strong) AppTextField *rightTextFile;

/**
 *  cell title 提示图标
 */
@property (nonatomic, strong) UIButton *titleIcon;

/**
 *  设置 cell title的提示 icon
 *
 *  @param iconImage icon的图片
 *  @param width     icon的宽度
 *  @param target    调用action方法的对象
 *  @param action    点击icon调用的方法
 */
- (void)addTitleIconWithImage:(UIImage *)iconImage width:(CGFloat)width addTarget:(id)target action:(SEL)action;

@property (nonatomic, strong) LFCellUpdateBlock cellUpdateBlock;

/**
 *  设置 block
 *
 *  @param cellUpdateBlock 每次tableView reload的时候 cell调用的block
 */
- (void)setCellUpdateBlock:(LFCellUpdateBlock)cellUpdateBlock;


/**
 *  模型表示,用来从字典里便取值
 */
@property (nonatomic, strong) NSString *modelID;

/**
 *  约束需要更新数据的block, 每次 tableview reload 的时会调用
 */
@property (nonatomic, strong) LFConstraintDataBlock constraintDataBlock;

- (void)setConstraintDataBlock:(LFConstraintDataBlock)constraintDataBlock;


@end
