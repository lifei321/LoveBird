//
//  RegInfoViewController.h
//  LoveBird
//
//  Created by ShanCheli on 2017/7/12.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppBaseTableViewController.h"
#import "PhoneTextField.h"


@interface RegInfoViewController : AppBaseTableViewController

@property (copy, nonatomic) NSString *inviterCode;   //默认邀请码


@property (nonatomic, strong) PhoneTextField *phoneText;


@end
