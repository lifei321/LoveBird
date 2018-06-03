//
//  ClassifyBirdViewController.h
//  LoveBird
//
//  Created by cheli shan on 2018/3/18.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController.h"

typedef NS_ENUM(NSInteger, FindClassType) {
    FindClassTypeMu = 1,
    FindClassTypeKe,
    FindClassTypeShu,
};

@interface ClassifyBirdViewController : AppBaseTableViewController

@property (nonatomic, assign) FindClassType type;

@property (nonatomic, copy) NSString *family;

@property (nonatomic, copy) NSString *subject;

@end
