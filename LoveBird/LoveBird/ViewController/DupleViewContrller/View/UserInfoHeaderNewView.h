//
//  UserInfoHeaderNewView.h
//  LoveBird
//
//  Created by cheli shan on 2018/9/14.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UserHeaderViewBlock)(NSInteger tag);

@interface UserInfoHeaderNewView : UIView
@property (nonatomic, strong) UserHeaderViewBlock headerBlock;

- (void)reloadData:(UserModel *)model;

@end
