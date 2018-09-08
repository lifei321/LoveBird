//
//  MineDetailView.h
//  LoveBird
//
//  Created by cheli shan on 2018/9/8.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineDetailView : UIView

@property (nonatomic, strong) NSMutableArray *dataArray;


@property (nonatomic, strong) UIView *backView;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *head;

@property (nonatomic, copy) NSString *grade;

@property (nonatomic, strong) UserModel *userModel;



@end
