//
//  FinishHeaderView.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/17.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^mineHeaderBlock)(void);

@interface FinishHeaderView : UIView

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) mineHeaderBlock block;


@end
