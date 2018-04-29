//
//  AppBaseTableViewController.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseViewController.h"
#import "AppBaseTableViewCell.h"
#import "AppBaseTableDataSource.h"
#import "AppBaseTableViewController+From.h"

typedef void (^LFBaseTableViewCellCallBack) (NSArray *cellsArray);

@interface AppBaseTableViewController : AppBaseViewController<UITableViewDelegate>


@property (nonatomic, strong) UITableView *tableView;


/**
 *  下滑线颜色
 */
@property (nonatomic, strong) UIColor *separatorColor;

/**
 *  右侧索引字体颜色
 */
@property (nonatomic, strong) UIColor *sectionIndexColor;

@property (nonatomic, assign) UITableViewStyle style;

//所有数据
@property (nonatomic, strong) NSArray *dataSourceArray;

//底部分割线 离左边距离
@property (nonatomic, assign) CGFloat leftSpaceForBottomLine;



@property (nonatomic, strong) AppBaseTableDataSource *dataSource;

/**
 自定义初始化TableView的方法
 
 @param style TableView的样式
 @return instancetype
 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

/**
 *  刷新表单
 */
- (void)reloadData;

/**
 *  设置tableHeaderView文案
 *
 *  @param headerTipsString 文案内容
 *  @param textColor        文案颜色
 *  @param textFont         文案字体大小
 */
- (void)setHeaderTipsString:(NSString *)headerTipsString textColor:(UIColor *)textColor textFont:(UIFont *)textFont;

/**
 *  设置tableFooterView文案
 *
 *  @param footerTipsString 文案内容
 *  @param textColor        文案颜色
 *  @param textFont         文案字体大小
 */
- (void)setFooterTipsString:(NSString *)footerTipsString textColor:(UIColor *)textColor textFont:(UIFont *)textFont;


- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier dataSource:(AppBaseTableDataSource *)datSource;

/**
 *  tablieView footView 设置一个 button
 *
 *  @param buttonText button 标题
 *  @param target     调用action方法的对象
 *  @param action     点击button所调用的方法
 */
- (void)addFootViewWithButton:(NSString *)buttonText addTarget:(id)target action:(SEL)action;

/**
 *  tablieView footView 设置一个 button
 *
 *  @param buttonText button 标题
 *  @param action
 */
//- (void)addFootViewWithButton:(NSString *)buttonText addTarget:(id)target action:(SEL)action;

/**
 *  去掉 cell 选中状态
 */
- (void)deselect;

/**
 *  更新cell model
 *
 *  @param indexPathsArray indexPaths array
 *  @param viewCell callBack回调
 */
- (void)updateDataSourceFormCellAtIndexPath:(NSArray *)indexPathsArray viewCellsBlock:(LFBaseTableViewCellCallBack)viewCell;
@end
