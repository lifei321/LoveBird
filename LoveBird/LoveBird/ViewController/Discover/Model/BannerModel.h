//
//  BannerModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/3/3.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol BannerModel;

@interface BannerDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <BannerModel>*data;

@end


@interface BannerModel : JSONModel

@property (nonatomic, copy) NSString *aid;

@property (nonatomic, copy) NSString *img ;

@property (nonatomic, assign) CGFloat imgHeight ;

@property (nonatomic, assign) CGFloat imgWidth;

@property (nonatomic, copy) NSString *mid;

@property (nonatomic, copy) NSString *tid;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *view_status;

@end
