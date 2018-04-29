//
//  UINavigationItem+CustomItem.m
//  loan
//
//  Created by ChenYanping on 2017/3/13.
//  Copyright © 2017年 renxin. All rights reserved.
//

#import "UINavigationItem+CustomItem.h"

@implementation UINavigationItem (CustomItem)
- (void)resetLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                        target:nil action:nil];
        negativeSpacer.width = -0;//左边补齐
        [self setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, leftBarButtonItem, nil]];
}

- (void)resetLeftBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIBarButtonItem *navLeftButton = [[UIBarButtonItem alloc] initWithImage:image
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:target
                                                                     action:action];
    [self setLeftBarButtonItems:@[navLeftButton]];
}


- (void)resetRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -10;
        [self setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, rightBarButtonItem, nil]];
}


- (void)resetRightBarButtonItemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIBarButtonItem *navRightButton = [[UIBarButtonItem alloc] initWithImage:image
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:target
                                                                     action:action];
    [self setRightBarButtonItem:navRightButton];
}


- (void)resetLeftBarButtonItems:(NSArray *)leftBarButtonItems {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                    target:nil action:nil];
    negativeSpacer.width = -0; //左边补齐
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:1];
    [tmpArray addObject:negativeSpacer];
    [tmpArray addObjectsFromArray:leftBarButtonItems];
    [self setLeftBarButtonItems:[NSArray arrayWithArray:tmpArray]];
}


- (void)resetRightBarButtonItems:(NSArray *)rightBarButtonItems {
        NSMutableArray *tmpArray = [NSMutableArray array];
        for (UIBarButtonItem *item in rightBarButtonItems) {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                               target:nil action:nil];
            negativeSpacer.width = -20;
            [tmpArray addObject:item];
            [tmpArray addObject:negativeSpacer];
        }
        [self setRightBarButtonItems:[NSArray arrayWithArray:tmpArray]];
}

@end
