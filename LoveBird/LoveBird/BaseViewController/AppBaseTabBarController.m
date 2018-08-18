//
//  AppBaseTabBarController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseTabBarController.h"


@implementation AppBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 * set方法， 同时创建子控制器并赋值
 */
- (void)setSubControllerAttributes:(NSArray<SubControllerAttribute *> *)subControllerAttributes {
    
    _subControllerAttributes = subControllerAttributes;
    
    NSMutableArray *navArr = [NSMutableArray array];
    for (SubControllerAttribute *att in subControllerAttributes) {
        UIViewController *subViewController = [[att.controllerClass alloc] init];
        
        Class navControllerClass = (att.navigationClass == nil) ? self.commonNavControllerClass : att.navigationClass;
        
        // 需要导航栏
        if (navControllerClass != nil)
            subViewController = [[navControllerClass alloc] initWithRootViewController:subViewController];
        
        subViewController.tabBarItem = [self getTabBarItemWithAttribute:att];
        
//        [subViewController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor], NSForegroundColorAttributeName, kFont6(30),NSFontAttributeName,nil] forState:UIControlStateSelected];
        

        [navArr addObject:subViewController];
    }
    
    self.viewControllers = navArr;
}

/**
 * 根据属性获取对应TabBarItem
 */
- (UITabBarItem *)getTabBarItemWithAttribute:(SubControllerAttribute *)att {
    
    UIImage *originalImage = nil;
    if (att.image != nil) {
        originalImage = [[UIImage imageNamed:att.image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UIImage *originalSelectImage = nil;
    if (att.selectImage != nil) {
        originalSelectImage = [[UIImage imageNamed:att.selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return [[UITabBarItem alloc] initWithTitle:att.title image:originalImage selectedImage:originalSelectImage];
}

@end

//----------------SubControllerAttribute类----------------
#pragma mark - SubControllerAttribute类
@implementation SubControllerAttribute

+ (instancetype)attributeWithClass:(Class)class NavigationClass:(Class)navigationClass TabBarItemTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    
    SubControllerAttribute *subControllerAttribute = [SubControllerAttribute attributeWithClass:class
                                                                                TabBarItemTitle:title
                                                                                          image:image
                                                                                    selectImage:selectImage];
    subControllerAttribute.navigationClass = navigationClass;
    return subControllerAttribute;
}

+ (instancetype)attributeWithClass:(Class)class TabBarItemTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage {
    
    SubControllerAttribute *subControllerAttribute = [[SubControllerAttribute alloc] init];
    subControllerAttribute.controllerClass = class;
    subControllerAttribute.title = title;
    subControllerAttribute.image = image;
    subControllerAttribute.selectImage = selectImage;
    return subControllerAttribute;
}



@end
