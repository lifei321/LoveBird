//
//  MineCaogaoModel.h
//  LoveBird
//
//  Created by cheli shan on 2018/8/12.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppBaseModel.h"

@protocol MineCaogaoModel;
@interface MineCaogaoDataModel : AppBaseModel

@property (nonatomic, strong) NSArray <MineCaogaoModel>*data;

@end



@interface MineCaogaoModel : JSONModel
@property (nonatomic, copy) NSString *dateline;

@property (nonatomic, assign) CGFloat imgHeight;


@property (nonatomic, assign) CGFloat imgWidth;


@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, copy) NSString *tid;

@property (nonatomic, copy) NSString *title;

@end



//dateline    草稿时间    string    @mock=$order('1524814607','1524816236','1524816240','1524816244')
//imgHeight    封面图高度    number    @mock=$order(400,400,400,400)
//imgUrl    封面图url    string    @mock=$order('http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg','http://www.fansimg.com/forum/201801/08/125057lgui7i10s1guuqbi.jpg')
//imgWidth    封面图宽度    number    @mock=$order(600,600,600,600)
//tid    草稿id(这个和已成文id是同一id)    string    @mock=$order('1100473','1100489','1100490','1100491')
//title
