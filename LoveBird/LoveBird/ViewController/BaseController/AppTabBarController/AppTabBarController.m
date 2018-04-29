//
//  AppTabBarController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppTabBarController.h"
#import "AppBaseNavigationController.h"

#import "DiscoverViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"
#import "FindViewController.h"
#import "GuideViewController.h"
#import "PublishViewController.h"


@interface AppTabBarController ()<UITabBarControllerDelegate>

@end

@implementation AppTabBarController


- (instancetype)init {
    
    self = [super init];
    if (self) {
        // 设置代理
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //公共的导航控制器
    self.commonNavControllerClass = [AppBaseNavigationController class];
    
    NSArray *attArr = @[[SubControllerAttribute attributeWithClass:[DiscoverViewController class]
                                                   TabBarItemTitle:@"发现"
                                                             image:@"sub_discover"
                                                       selectImage:@"sub_discovered"],
                        
                        [SubControllerAttribute attributeWithClass:[FindViewController class]
                                                   TabBarItemTitle:@"查鸟"
                                                             image:@"sub_find_bird"
                                                       selectImage:@"sub_find_birded"],
                        
                        [SubControllerAttribute attributeWithClass:[PublishViewController class]
                                                   TabBarItemTitle:@""
                                                             image:@"sub_release"
                                                       selectImage:@"sub_release"],
                        
                        [SubControllerAttribute attributeWithClass:[GuideViewController class]
                                                   TabBarItemTitle:@"向导"
                                                             image:@"sub_bird_nav"
                                                       selectImage:@"sub_bird_naved"],
                        
                        [SubControllerAttribute attributeWithClass:[MineViewController class]
                                                   TabBarItemTitle:@"我的"
                                                             image:@"sub_mine"
                                                       selectImage:@"sub_mined"]
                        ];
    //赋值属性数组
    self.subControllerAttributes = attArr;
    
    //设置Tabbar属性
    //字体颜色
    self.tabBar.unselectedItemTintColor = kColorTarBarTitleNormorlColor;
    
    //选中字体颜色
    self.tabBar.tintColor = kColorTarBarTitleHighlightColor;

    //tabbar背景颜色
    self.tabBar.barTintColor = [UIColor whiteColor];
}

#pragma mark --UITabBarControllerDelegate

/**
 *  在点击tabbarButton的时候调用
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(nonnull UIViewController *)viewController {
    
//    LoginViewController *loginVC = [[LoginViewController alloc] init];
//    [kViewController presentViewController:[[AppBaseNavigationController alloc] initWithRootViewController:loginVC] animated:YES completion:nil];
    return YES;
}




@end
