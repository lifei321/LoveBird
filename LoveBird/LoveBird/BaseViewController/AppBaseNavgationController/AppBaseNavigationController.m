//
//  AppBaseNavigationController.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/7.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseNavigationController.h"


//获取图片资源
#define kLFImageNamed(imageName) [UIImage imageNamed:imageName]

// navigationBar 背景图片
//蓝色
#define kLFNavigationBarBackgroundImageBlue kLFImageNamed(@"navigationbarbg_blue")

//透明
#define kLFNavigationBarBackgroundImage kLFImageNamed(@"navigationBarBg")

//模糊
#define kLFNavigationBarBackgroundImageAlpha kLFImageNamed(@"navigationbarbg_alpha")



@interface AppBaseNavigationController ()

@end

@implementation AppBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self.navigationBar setBackgroundImage:kLFNavigationBarBackgroundImageBlue forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)setTransparent:(BOOL)transparent {
    _transparent = transparent;
    if (transparent) {
        
        [self.navigationBar setBackgroundImage:kLFNavigationBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:kLFNavigationBarBackgroundImage];
        
    } else {
        
        [self.navigationBar setBackgroundImage:kLFNavigationBarBackgroundImageBlue forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)setTransparentAlpha:(CGFloat)transparentAlpha {
    _transparentAlpha = transparentAlpha;
    [self.navigationBar setBackgroundImage:kLFNavigationBarBackgroundImageAlpha forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [super setNavigationBarHidden:hidden animated:animated];
    _alphaView.hidden = hidden;
    
}

@end
