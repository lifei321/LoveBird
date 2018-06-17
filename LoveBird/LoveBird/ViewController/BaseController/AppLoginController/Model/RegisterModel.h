//
//  RegisterModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/18.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@class RegisterModel;
@interface RegisterDataModel : AppBaseModel

@property (nonatomic, strong) RegisterModel *userInfo;

@property (nonatomic, copy) NSString *showMessage;

@end



@interface RegisterModel : JSONModel

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *uid;


@end
