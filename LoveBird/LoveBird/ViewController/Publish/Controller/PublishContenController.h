//
//  PublishContenController.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/8.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseViewController.h"
typedef void(^PublishContentBlock)(NSString *contentString);

@interface PublishContenController : AppBaseViewController

@property (nonatomic, strong) PublishContentBlock contentblock;

@property (nonatomic, copy) NSString *text;

@end
