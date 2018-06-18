//
//  GuideModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/6/18.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol GuideModel;
@interface GuideDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <GuideModel>*data;

@end

@interface GuideModel : AppBaseModel

@property (nonatomic, copy) NSString *cost;

@property (nonatomic, copy) NSString *dateEnd;

@property (nonatomic, copy) NSString *dateStart;


@property (nonatomic, copy) NSString *head;

@property (nonatomic, assign) CGFloat imgHeight;

@property (nonatomic, assign) CGFloat imgWidth;

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, assign) BOOL isFollow;

@property (nonatomic, copy) NSString *leader;

@property (nonatomic, copy) NSString *leaderGroupIcon;

@property (nonatomic, copy) NSString *leaderid;

@property (nonatomic, copy) NSString *places;

@property (nonatomic, copy) NSString *subject;

@property (nonatomic, copy) NSString *tid;

@property (nonatomic, copy) NSString *travelDate;


@end


//cost    价格    number    @mock=$order(12999,12999)
//dateEnd    开始时间（时间戳，暂无用）    number    @mock=$order(1523682872,1523682872)
//dateStart    结束时间（时间戳，暂无用）    number    @mock=$order(1518930872,1518930872)
//head    领队头像    string    @mock=$order('http://bbs.photofans.cn/uc_server/avatar.php?uid=380352&size=middle','http://bbs.photofans.cn/uc_server/avatar.php?uid=380352&size=middle')
//imgHeight    封面图高    number    @mock=$order(400,400)
//imgUrl    封面图地址    string    @mock=$order('http://www.yunyouse.cn/yunyouse/travels2017/09_s/1505718276_4524.jpg','http://www.yunyouse.cn/yunyouse/travels2017/09_s/1505718276_4524.jpg')
//imgWidth    封面图宽    number    @mock=$order(600,600)
//isFollow    是否关注了领队    number    @mock=$order(0,0)
//leader    领队名    string    @mock=$order('北京小龙女','北京小龙女')
//leaderGroupIcon    领队头衔标志url    number    @mock=$order(1,1)
//leaderid    领队id    string    @mock=$order('380352','380352')
//places    名额    number    @mock=$order(30,30)
//subject    标题    string    @mock=$order('爱鸟网旅行260','爱鸟网旅行257')
//tid    鸟导 id    string    @mock=$order('570012','570844')
//travelDate
