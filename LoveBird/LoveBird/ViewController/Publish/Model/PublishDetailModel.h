//
//  PublishDetailModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PublishDetailModel : JSONModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *detailString;

@end
