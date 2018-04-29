//
//  AppBaseTableViewController+From.h
//  LoveBird
//
//  Created by ShanCheli on 2017/11/17.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController.h"
#import "AppBaseCellModel.h"
#import "NSMutableDictionary+from.h"


/**
 *  成功回调
 */
typedef void(^validitySuccessBlock)(void);

/**
 *  失败回调
 */
typedef void(^validityFailBlock)(void);

@interface AppBaseViewController (From) <UITextFieldDelegate>

/**
 *  textFiled 计数
 */
@property (nonatomic, assign) NSInteger textFiledCount;

/**
 *  left 间距
 */
@property (nonatomic, assign) CGFloat leftSpacing;

/**
 *  设置左侧间距
 */
- (void)setLeftSpacing:(CGFloat)leftSpacing;

/**
 *  添加 detail 类型的 cell
 *
 *  @param title   标题文案
 *  @param detail  详情文案
 *  @param section 所属的section
 *
 */
- (AppBaseCellModel *)addFromPushWith:(NSString *)title
                                    detail:(NSString *)detail
                                 inSection:(NSInteger)section;

/**
 *  添加 push 类型的 cell
 *
 *  @param title           标题文案
 *  @param detail          详情文案
 *  @param viewController  点击时跳转的controller
 *  @param section         所属的section
 *
 */
- (AppBaseCellModel *)addFromPushWith:(NSString *)title
                                    detail:(NSString *)detail
                            viewController:(NSString *)viewController
                                 inSection:(NSInteger)section;


/**
 *  添加 selector 类型的
 *
 *  @param title     标题文案
 *  @param detail    详情文案
 *  @param selector  点击时执行的方法所对应的selector
 *  @param section   所属的section
 *
 */
- (AppBaseCellModel *)addFromSelectorWith:(NSString *)title
                                        detail:(NSString *)detail
                                      selector:(NSString *)selector
                                     inSection:(NSInteger)section;


/**
 *  添加 非 textFiled cell
 *
 *  @param title            标题文案
 *  @param detail           详情文案
 *  @param viewController   点击时跳转的controller
 *  @param selector         点击时执行的方法所对应的selector
 *  @param section          所属的section
 *
 */
- (AppBaseCellModel *)addFromCellWith:(NSString *)title
                                    detail:(NSString *)detail
                        pushviewController:(NSString *)viewController
                                  selector:(NSString *)selector
                                 inSection:(NSInteger)section;



/**
 *  创建 自定义textFiled控件的 cell
 *
 *  @param title         标题文案
 *  @param placeholder   textField的placeholder
 *  @param modelID       model唯一表示
 *  @param textFileClass 自定义testFiled对应的class对象
 *  @param section       所在 tablieview 组
 *  @param isValid       是否进行数据校验
 *
 */
- (AppBaseCellModel *)addFromTextFiledWithTitle:(NSString *)title
                                         placeholder:(NSString *)placeholder
                                             modelID:(NSString *)modelID
                                       textFileClass:(Class)textFileClass
                                           inSection:(NSInteger)section
                                             isValid:(BOOL)isValid;


/**
 *  创建 自定义验证码控件的 cell
 *
 *  @param title         标题文案
 *  @param placeholder   验证码textField的placeholder
 *  @param modelID       model唯一表示
 *  @param textFileClass 自定义testFiled对应的class对象
 *  @param section       所在 tablieview 组
 *  @param isValid       是否进行数据校验
 *
 */
- (AppBaseCellModel *)addFromTextFiledWithVertifyCode:(NSString *)title
                                               placeholder:(NSString *)placeholder
                                                   modelID:(NSString *)modelID
                                             textFileClass:(Class)textFileClass
                                                 inSection:(NSInteger)section
                                                   isValid:(BOOL)isValid;


/**
 *  创建 自定义图片验证码控件的 cell
 *
 *  @param title         标题文案
 *  @param placeholder   验证码textField的placeholder
 *  @param modelID       model唯一表示
 *  @param textFileClass 自定义testFiled对应的class对象
 *  @param section       所在 tablieview 组
 *  @param isValid       是否进行数据校验
 *
 */
- (AppBaseCellModel *)addFromTextFiledWithImageCode:(NSString *)title
                                             placeholder:(NSString *)placeholder
                                                 modelID:(NSString *)modelID
                                           textFileClass:(Class)textFileClass
                                               inSection:(NSInteger)section
                                                 isValid:(BOOL)isValid;


/**
 *  创建 自定义右侧 button控件的 cell
 *
 *  @param title         标题文案
 *  @param placeholder   textField的placeholder
 *  @param modelID       model唯一表示
 *  @param textFileClass 自定义testFiled对应的class对象
 *  @param section       所在 tablieview 组
 *  @param isValid       是否进行数据校验
 *
 */
- (AppBaseCellModel *)addFromTextFiledWithCustomButton:(NSString *)title
                                                placeholder:(NSString *)placeholder
                                                    modelID:(NSString *)modelID
                                              textFileClass:(Class)textFileClass
                                                  inSection:(NSInteger)section
                                                    isValid:(BOOL)isValid;

//VertifyCode

/**
 *  该数组存储每个 textfile 的合法性,默认为 no
 */
@property (nonatomic, strong) NSMutableArray *validityArray;

- (void)setValidityArray:(NSMutableArray *)validityArray;


/**
 *  成功 block
 */
@property (nonatomic, strong) validitySuccessBlock validitySuccess;

/**
 *  失败 block
 */
@property (nonatomic, strong) validityFailBlock validityFail;

/**
 *  设置 block
 *
 *  @param validityFail    数据校验失败调用的block
 *  @param validitySuccess 数据校验成功调用的block
 */
- (void)setValidityBlock:(validityFailBlock)validityFail validitySuccess:(validitySuccessBlock)validitySuccess;


/**
 *  字典,存放所有的 textField;
 */
@property (nonatomic, strong) NSMutableDictionary *textFieldDict;

/**
 *  提交
 */
- (void)submitFrom;

@end
