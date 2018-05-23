//
//  MineLogViewController.m
//  LoveBird
//
//  Created by ShanCheli on 2018/5/23.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "MineLogViewController.h"

@interface MineLogViewController ()

@end

@implementation MineLogViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [self arndomColor];

}

- (UIColor *)arndomColor {
    CGFloat red = arc4random_uniform(256)/ 255.0;
    CGFloat green = arc4random_uniform(256)/ 255.0;
    CGFloat blue = arc4random_uniform(256)/ 255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    return color;
}

@end
