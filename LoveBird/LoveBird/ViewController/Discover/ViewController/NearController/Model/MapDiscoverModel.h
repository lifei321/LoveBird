//
//  MapDiscoverModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/18.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol MapDiscoverGpsModel;
@interface MapDiscoverDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <MapDiscoverGpsModel>*data;

@end

@class MapDiscoverModel;
@interface MapDiscoverGpsModel : JSONModel

@property (nonatomic, strong) MapDiscoverModel *gpsInfo;

@end

@protocol MapDiscoverInfoModel;
@interface MapDiscoverModel : JSONModel

@property (nonatomic, copy) NSString *lat;

@property (nonatomic, copy) NSString *lng;

@property (nonatomic, strong) NSArray <MapDiscoverInfoModel>*birdInfo;


@end

@interface MapDiscoverInfoModel : JSONModel

@property (nonatomic, copy) NSString *csp_code;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *name_la;

@property (nonatomic, copy) NSString *imgUrl;

// 是否是 选择
@property (nonatomic, assign) BOOL isSelect;
@end
