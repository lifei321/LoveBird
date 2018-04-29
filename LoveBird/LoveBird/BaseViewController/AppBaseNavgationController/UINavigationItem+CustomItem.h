//
//  UINavigationItem+CustomItem.h
//  loan
//
//  Created by ChenYanping on 2017/3/13.
//  Copyright © 2017年 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (CustomItem)

- (void)resetLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem;

- (void)resetLeftBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

- (void)resetRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;

- (void)resetRightBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action;

- (void)resetLeftBarButtonItems:(NSArray *)leftBarButtonItems;

- (void)resetRightBarButtonItems:(NSArray *)rightBarButtonItems;

@end
