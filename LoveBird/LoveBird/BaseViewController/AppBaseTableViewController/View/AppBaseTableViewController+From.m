//
//  AppBaseTableViewController+From.m
//  LoveBird
//
//  Created by ShanCheli on 2017/11/17.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController+From.h"
#import <objc/runtime.h>
#import "AppBaseCellModel.h"
#import "AppBaseTextField.h"

char* const LEFTSPACING = "leftSpacing";

char* const VALIDITYARRAY = "validityArray";

char* const VALIDITYSUCCESS = "validitySuccess";

char* const VALIDITYFALI = "validityFali";

char* const TEXTFIELDDICT = "textFieldDict";

char* const TEXTFILED = "textFiledCount";


@implementation AppBaseTableViewController (From)

#pragma mark 设置属性

- (void)setTextFiledCount:(NSInteger)textFiledCount {
    
    objc_setAssociatedObject(self, TEXTFILED, @(textFiledCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)textFiledCount {
    
    return [objc_getAssociatedObject(self, TEXTFILED) floatValue];
}

- (void)setLeftSpacing:(CGFloat)leftSpacing {
    
    objc_setAssociatedObject(self, LEFTSPACING, @(leftSpacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)leftSpacing {
    
    return [objc_getAssociatedObject(self, LEFTSPACING) floatValue];
}

- (void)setValidityArray:(NSMutableArray *)validityArray {
    
    objc_setAssociatedObject(self, VALIDITYARRAY, validityArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)validityArray {
    
    return objc_getAssociatedObject(self, VALIDITYARRAY);
    
}

- (void)setValiditySuccess:(validitySuccessBlock)validitySuccess {
    
    objc_setAssociatedObject(self, VALIDITYSUCCESS, validitySuccess, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (validitySuccessBlock)validitySuccess {
    
    return objc_getAssociatedObject(self, VALIDITYSUCCESS);
}

- (void)setValidityFail:(validityFailBlock)validityFail {
    
    objc_setAssociatedObject(self, VALIDITYFALI, validityFail, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (validityFailBlock)validityFail {
    
    return objc_getAssociatedObject(self, VALIDITYFALI);
}

- (void)setTextFieldDict:(NSMutableDictionary *)textFieldDict {
    
    objc_setAssociatedObject(self, TEXTFIELDDICT, textFieldDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)textFieldDict {
    
    return objc_getAssociatedObject(self, TEXTFIELDDICT);
}


- (void)createPrepare:(NSInteger)section {
    
    if (self.validityArray == nil) {
        
        self.validityArray = [NSMutableArray new];
    }
    
    if (self.textFieldDict == nil) {
        
        self.textFieldDict = [NSMutableDictionary new];
    }
    
    if (section > (int)self.dataSource.tableListArray.count - 1) {
        
        [self.dataSource.tableListArray addObject:[NSMutableArray new]];
    }
}

#pragma mark 表单

/**
 *  创建 自定义textFiled控件的 cell
 *
 *  @param title        标题
 *  @param placeholder  默认显示文字
 *  @param modelID      model唯一表示
 *  @param textFileClass testFiled 的
 *  @param section      所在 tablieview 组
 *  @param isValid      是否进行数据校验
 *
 */
- (AppBaseCellModel *)addFromTextFiledWithTitle:(NSString *)title
                                         placeholder:(NSString *)placeholder
                                             modelID:(NSString *)modelID
                                       textFileClass:(Class)textFileClass
                                           inSection:(NSInteger)section
                                             isValid:(BOOL)isValid {
    
    [self createPrepare:section];
    
    
    AppBaseCellModel *cellModel = [[AppBaseCellModel alloc] init];
    cellModel.title = title;
    cellModel.modelID = modelID;
    
    // 如果需要校验,则赋值1, 否则为0, 下边会对数组求和
    if (isValid) {
        
        [self.validityArray addObject:@(1)];
        
    } else {
        
        [self.validityArray addObject:@(0)];
    }
    
    if (textFileClass != nil) {
        
        cellModel.rightTextFile = [[textFileClass alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        cellModel.rightView = cellModel.rightTextFile;
    }
    
    cellModel.rightTextFile.placeholder = placeholder;
    cellModel.rightTextFile.tag = self.textFiledCount;
    [self.textFieldDict setObject:cellModel.rightTextFile forKey:modelID];
    
    if (isValid) {
        
        [cellModel.rightTextFile addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [cellModel.rightTextFile.clearButton addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    cellModel.rightView.left = self.leftSpacing;
    
    [self.dataSource.tableListArray[section] addObject:cellModel];
    
    self.textFiledCount++;
    return cellModel;
}


/**
 *  创建 自定义验证码控件的 cell
 *
 *  @param title        标题
 *  @param placeholder  默认显示文字
 *  @param modelID      model唯一表示
 *  @param textFileClass testFiled 的
 *  @param section      所在 tablieview 组
 *  @param isValid      是否进行数据校验
 *
 */
- (AppBaseCellModel *)addFromTextFiledWithVertifyCode:(NSString *)title
                                               placeholder:(NSString *)placeholder
                                                   modelID:(NSString *)modelID
                                             textFileClass:(Class)textFileClass
                                                 inSection:(NSInteger)section
                                                   isValid:(BOOL)isValid {
    
    
    [self createPrepare:section];
    
    
    AppBaseCellModel *cellModel = [[AppBaseCellModel alloc] init];
    cellModel.title = title;
    cellModel.modelID = modelID;
    
    // 如果需要校验,则赋值1, 否则为0, 下边会对数组求和
    if (isValid) {
        
        [self.validityArray addObject:@(1)];
        
    } else {
        
        [self.validityArray addObject:@(0)];
    }
    
//    if (textFileClass == nil) {
//
//        textFileClass = [LFBaseVerifiCodeView class];
//    }
//
//    LFBaseVerifiCodeView *viewCodeView = [[textFileClass alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//
//    viewCodeView.verifiCode.placeholder = placeholder;
//    [self.textFieldDict setObject:viewCodeView.verifiCode forKey:modelID];
//    if (isValid) {
//
//        [viewCodeView.verifiCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        [viewCodeView.verifiCode.clearButton addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    cellModel.rightView = viewCodeView;
//    viewCodeView.verifiCode.tag = self.textFiledCount;
    
    
    cellModel.rightView.left = self.leftSpacing;
    
    [self.dataSource.tableListArray[section] addObject:cellModel];
    
    self.textFiledCount++;
    return cellModel;
}


/**
 *  创建 自定义图片验证码控件的 cell
 *
 *  @param title        标题
 *  @param placeholder  默认显示文字
 *  @param modelID      model唯一表示
 *  @param textFileClass testFiled 的
 *  @param section      所在 tablieview 组
 *  @param isValid      是否进行数据校验
 *
 */
- (AppBaseCellModel *)addFromTextFiledWithImageCode:(NSString *)title
                                             placeholder:(NSString *)placeholder
                                                 modelID:(NSString *)modelID
                                           textFileClass:(Class)textFileClass
                                               inSection:(NSInteger)section
                                                 isValid:(BOOL)isValid {
    
    
    [self createPrepare:section];
    
    
    AppBaseCellModel *cellModel = [[AppBaseCellModel alloc] init];
    cellModel.title = title;
    cellModel.modelID = modelID;
    
    // 如果需要校验,则赋值1, 否则为0, 下边会对数组求和
    if (isValid) {
        
        [self.validityArray addObject:@(1)];
        
    } else {
        
        [self.validityArray addObject:@(0)];
    }
    
//    if (textFileClass == nil) {
//
//        textFileClass = [LFBaseImageCodeView class];
//    }
//
//
//    LFBaseImageCodeView *viewCodeView = [[textFileClass alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    viewCodeView.verifiCode.placeholder = placeholder;
//    [self.textFieldDict setObject:viewCodeView.verifiCode forKey:modelID];
//    if (isValid) {
//
//        [viewCodeView.verifiCode addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        [viewCodeView.verifiCode.clearButton addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
//    }
//
//    cellModel.rightView = viewCodeView;
//    viewCodeView.verifiCode.tag = self.textFiledCount;
    
    
    cellModel.rightView.left = self.leftSpacing;
    
    [self.dataSource.tableListArray[section] addObject:cellModel];
    
    self.textFiledCount++;
    return cellModel;
}

/**
 *  创建 自定义右侧 button控件的 cell
 *
 *  @param title        标题
 *  @param placeholder  默认显示文字
 *  @param modelID      model唯一表示
 *  @param textFileClass testFiled 的
 *  @param section      所在 tablieview 组
 *  @param isValid      是否进行数据校验
 *
 */
- (AppBaseCellModel *)addFromTextFiledWithCustomButton:(NSString *)title
                                                placeholder:(NSString *)placeholder
                                                    modelID:(NSString *)modelID
                                              textFileClass:(Class)textFileClass
                                                  inSection:(NSInteger)section
                                                    isValid:(BOOL)isValid {
    
    
    [self createPrepare:section];
    
    
    AppBaseCellModel *cellModel = [[AppBaseCellModel alloc] init];
    cellModel.title = title;
    cellModel.modelID = modelID;
    
    // 如果需要校验,则赋值1, 否则为0, 下边会对数组求和
    if (isValid) {
        
        [self.validityArray addObject:@(1)];
        
    } else {
        
        [self.validityArray addObject:@(0)];
    }
    
//    LFBaseCustomRightButton *viewCodeView = [[LFBaseCustomRightButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0) textFieldClass:textFileClass];
//    viewCodeView.textField.placeholder = placeholder;
//    [self.textFieldDict setObject:viewCodeView.textField forKey:modelID];
//    if (isValid) {
//
//        [viewCodeView.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        [viewCodeView.textField.clearButton addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventTouchUpInside];
//    }
//
//    cellModel.rightView = viewCodeView;
//    viewCodeView.textField.tag = self.textFiledCount;
    
    
    cellModel.rightView.left = self.leftSpacing;
    
    [self.dataSource.tableListArray[section] addObject:cellModel];
    
    self.textFiledCount++;
    return cellModel;
}


/**
 *  添加 非 textFiled cell
 */
- (AppBaseCellModel *)addFromCellWith:(NSString *)title
                                    detail:(NSString *)detail
                        pushviewController:(NSString *)viewController
                                  selector:(NSString *)selector
                                 inSection:(NSInteger)section {
    
    [self createPrepare:section];
    
    AppBaseCellModel *cellModel = [[AppBaseCellModel alloc] init];
    cellModel.title = title;
    cellModel.detail = detail;
    
    if (viewController != nil) {
        
        cellModel.pushViewController = viewController;
    }
    
    if (selector != nil) {
        
        cellModel.selector = selector;
        cellModel.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [self.dataSource.tableListArray[section] addObject:cellModel];
    
    return cellModel;
}

- (AppBaseCellModel *)addFromPushWith:(NSString *)title
                                    detail:(NSString *)detail
                            viewController:(NSString *)viewController
                                 inSection:(NSInteger)section {
    
    return [self addFromCellWith:title detail:detail pushviewController:viewController selector:nil inSection:section];
}

/**
 *  添加 detail 类型的 cell
 */
- (AppBaseCellModel *)addFromPushWith:(NSString *)title
                                    detail:(NSString *)detail
                                 inSection:(NSInteger)section {
    
    
    return [self addFromCellWith:title detail:detail pushviewController:nil selector:nil inSection:section];
}

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
                                     inSection:(NSInteger)section {
    
    return [self addFromCellWith:title detail:detail pushviewController:nil selector:selector inSection:section];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    @weakify(self);
    [self.textFieldDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        @strongify(self); if (!self) return;
        AppBaseTextField *textFiled = obj;
        if (![textFiled.text isBlankString] && [self.validityArray objectAtIndex:textFiled.tag]) {
            
            [self.validityArray replaceObjectAtIndex:textFiled.tag withObject:@(0)];
            
        }
    }];
    
    NSNumber *sum = [self.validityArray valueForKeyPath:@"@sum.floatValue"];
    
    if ([sum intValue] == 0 && self.validitySuccess) {
        
        self.validitySuccess();
        
    } else if (self.validityFail) {
        
        self.validityFail();
    }
}

#pragma mark 监控 textfile 输入
- (void)textFieldDidChange:(AppBaseTextField *)textFile {
    
    if ([textFile isKindOfClass:[UIButton class]]) {
        
        textFile = (AppBaseTextField *)textFile.superview;
    }
    
    if (![textFile.text isBlankString]) {
        
        [self.validityArray replaceObjectAtIndex:textFile.tag withObject:@(0)];
        
    } else {
        [self.validityArray replaceObjectAtIndex:textFile.tag withObject:@(1)];
    }
    
    NSNumber *sum = [self.validityArray valueForKeyPath:@"@sum.floatValue"];
    
    if ([sum intValue] == 0 && self.validitySuccess) {
        
        self.validitySuccess();
        
    } else if (self.validityFail) {
        
        self.validityFail();
    }
}

#pragma mark block

- (void)setValidityBlock:(validityFailBlock)validityFail validitySuccess:(validitySuccessBlock)validitySuccess {
    
    self.validitySuccess = validitySuccess;
    self.validityFail = validityFail;
}


#pragma mark 提交表单

/**
 *  提交
 */
- (void)submitFrom {
    
}

@end
