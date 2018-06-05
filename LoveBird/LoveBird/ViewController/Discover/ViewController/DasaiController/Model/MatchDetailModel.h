//
//  MatchDetailModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/5.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@interface MatchDetailModel : AppBaseModel

@property (nonatomic, copy) NSString *aid;

@property (nonatomic, copy) NSString *articleNum;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imgUrl;

@end


//aid    大赛详情文章id    number
//articleNum    大赛文章总数    number    @mock=3343
//summary    大赛简介    string    @mock=中国上海观鸟大年
//title
