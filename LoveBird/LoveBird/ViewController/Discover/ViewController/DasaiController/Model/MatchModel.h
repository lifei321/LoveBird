//
//  MatchModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/5/20.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol MatchModel;
@interface MatchListModel : AppBaseModel

@property (nonatomic, strong) NSArray <MatchModel> *data;
@end

@interface MatchModel : AppBaseModel

@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *matchid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) CGFloat imgHeight;

@property (nonatomic, assign) CGFloat imgWidth;

@property (nonatomic, assign) BOOL isSelected;




//imgHeight    封面图高度    number    @mock=$order(400,400,400)
//imgUrl    封面图    string    @mock=$order('http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg')
//imgWidth        number    @mock=$order(600,600,600)
//matchid    大赛id    string    @mock=$order('1','2','3')
//title

@end
