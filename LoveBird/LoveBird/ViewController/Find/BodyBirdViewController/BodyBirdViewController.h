//
//  BodyBirdViewController.h
//  LoveBird
//
//  Created by cheli shan on 2018/4/30.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseViewController.h"

typedef NS_ENUM(NSInteger, BodyBirdType) {
    
    BodyBirdTypeOne = 1,
    BodyBirdTypeTwo,
    BodyBirdTypeThree,
    BodyBirdTypeFour,
    BodyBirdTypeFive,
};


@interface BodyBirdViewController : AppBaseViewController

@property (nonatomic, assign) BodyBirdType type;

@end
