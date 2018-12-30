//
//  MapDisCoverLocationView.h
//  LoveBird
//
//  Created by cheli shan on 2018/8/7.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Search/BMKPoiSearchResult.h>//只引入所需的单个头文件

typedef void(^MapSelectLocationBlock)(NSString *info, NSInteger index);

@interface MapDisCoverLocationView : UIView

@property (nonatomic, strong) NSMutableArray *dataArray;



@property (nonatomic, strong) MapSelectLocationBlock locationBlock;


@end
