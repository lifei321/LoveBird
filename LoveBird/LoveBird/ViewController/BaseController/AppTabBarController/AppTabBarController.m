//
//  AppTabBarController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppTabBarController.h"
#import "AppBaseNavigationController.h"
#import "AppTabBar.h"

#import "DiscoverViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"
#import "FindViewController.h"
#import "GuideViewController.h"
#import "PublishViewController.h"
#import "NearController.h"

@interface AppTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, assign) NSInteger selectedItem;

@end

@implementation AppTabBarController


- (instancetype)init {
    
    self = [super init];
    if (self) {
        // 设置代理
        self.delegate = self;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOutNotifycation) name:kLogoutSuccessNotification object:nil];
    }
    return self;
}

- (void)logOutNotifycation {
    self.selectedIndex = 0;
    [self tabBarController:self didSelectViewController:[[UIViewController alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedItem = 0;
    
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
                                                   TabBarItemTitle:@"活动"
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

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    if (tabBarController.selectedIndex == 2) {
        
        [UserPage gotoLoinBlock:^{
            if (tabBarController.selectedIndex == 2) {
                PublishViewController *pubvc = [[PublishViewController alloc] init];
//                @weakify(self);
                pubvc.viewControllerActionBlock = ^(UIViewController *viewController, NSObject *userInfo) {
//                    @strongify(self);
                };
                [kViewController presentViewController:[[AppBaseNavigationController alloc] initWithRootViewController:pubvc] animated:NO completion:nil];
            }
        }];
        self.selectedIndex = self.selectedItem;
    } else if (tabBarController.selectedIndex == 4) {
        if ([UserPage sharedInstance].isLogin) {
            self.selectedItem = self.selectedIndex;

        } else {
            [UserPage gotoLoinBlock:^{
                self.selectedIndex = 4;
            }];
            self.selectedIndex = self.selectedItem;
        }
    } else {
        self.selectedItem = self.selectedIndex;
        if (tabBarController.selectedIndex == 0) {
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:kFirstLouchString] boolValue]) {
                
            } else {
                UIViewController *viewController = [UIViewController currentViewController].navigationController.childViewControllers.lastObject;
                if ([viewController isKindOfClass:[NearController class]]) {
                    [[UIViewController currentViewController].navigationController popViewControllerAnimated:YES];
                }
            }
        }
    }
}


@end
