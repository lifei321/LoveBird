//
//  AppBaseTabBarController.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SubControllerAttribute;


@interface AppBaseTabBarController : UITabBarController

/**
 * 控制器的公共导航控制器类，如果没有按照系统导航控制器创建
 */
@property (nonatomic, strong) Class commonNavControllerClass;

/**
 * 控制器属性数组
 */
@property (nonatomic, strong) NSArray<SubControllerAttribute *> *subControllerAttributes;

@end



//----------------SubControllerAttribute类----------------
#pragma mark - SubControllerAttribute类

//属性类，存储控制器需要添加的控制器的属性
@interface SubControllerAttribute : NSObject

/**
 * 导航控制器的类
 */
@property (nonatomic, strong) Class navigationClass;

/**
 * 子控制器的类
 */
@property (nonatomic, strong) Class controllerClass;

/**
 * TabbarItem的标题
 */
@property (nonatomic, strong) NSString *title;

/**
 * TabbarItem的正常图片
 */
@property (nonatomic, strong) NSString *image;

/**
 * TabbarItem的选中图片
 */
@property (nonatomic, strong) NSString *selectImage;

/**
 * 类方法创建属性对象
 */
+ (instancetype)attributeWithClass:(Class)controllerClass TabBarItemTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage;

/**
 * 类方法创建属性对象
 */
+ (instancetype)attributeWithClass:(Class)class NavigationClass:(Class)navigationClass TabBarItemTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage;

@end
