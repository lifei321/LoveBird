//
//  PublishBirdInfoModel.h
//  LoveBird
//
//  Created by ShanCheli on 2018/5/10.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PublishBirdInfoModel : JSONModel

// 编号
@property (nonatomic, copy) NSString *cspCode;

// 数量
@property (nonatomic, assign) NSInteger num;


@end
