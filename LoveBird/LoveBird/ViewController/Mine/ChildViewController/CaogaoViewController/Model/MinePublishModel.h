//
//  MinePublishModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/8/12.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"
#import "PublishEditModel.h"
#import "PublishBirdInfoModel.h"

@protocol MinePublishBodyModel;
@protocol PublishBirdInfoModel;
@interface MinePublishModel : AppBaseModel

@property (nonatomic, strong) NSArray <PublishBirdInfoModel>* birdInfo;

@property (nonatomic, strong) NSArray <MinePublishBodyModel>* articleBody;

@property (nonatomic, copy) NSString * isSort;

@property (nonatomic, copy) NSString * author;

@property (nonatomic, copy) NSString * authorid;

@property (nonatomic, copy) NSString * authorHead;

@property (nonatomic, copy) NSString * coverImgUrl;

@property (nonatomic, copy) NSString * coverImgWidth;

@property (nonatomic, copy) NSString * coverImgHeight;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * status;

@property (nonatomic, copy) NSString * locale;

@property (nonatomic, copy) NSString * lat;

@property (nonatomic, copy) NSString * lng;

@property (nonatomic, copy) NSString * observeTime;

@property (nonatomic, copy) NSString * publishTime;

@property (nonatomic, copy) NSString * environmentId  ;

@property (nonatomic, copy) NSString * environmen   ;


@end

@protocol PublishEditModel;
@interface MinePublishBodyModel : JSONModel

@property (nonatomic, copy) NSString * pid;

@property (nonatomic, strong) NSArray <PublishEditModel> *postList;

@end
