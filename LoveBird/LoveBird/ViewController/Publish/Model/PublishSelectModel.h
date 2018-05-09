//
//  PublishSelectModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/9.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PublishSelectModel : JSONModel

@property (nonatomic, copy) NSString *title;

// 是否是 选择
@property (nonatomic, assign) BOOL isSelect;

@end
