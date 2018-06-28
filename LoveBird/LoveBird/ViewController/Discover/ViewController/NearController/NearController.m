//
//  NearController.m
//  LoveBird
//
//  Created by cheli shan on 2018/6/18.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "NearController.h"
#import "MapDiscoverModel.h"
#import "DiscoverDao.h"
#import "MapDisCoverView.h"
#import "BDAnnotation.h"
#import "RoundAnnotationView.h"


#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件



@interface NearController () <BMKMapViewDelegate, BMKLocationServiceDelegate, UISearchBarDelegate>

//百度地图
@property (nonatomic, strong) BMKMapView *bMapView;

//定位服务
@property (nonatomic, strong) BMKLocationService *locService;

//移动或缩放前的比例尺
@property (nonatomic, assign) float zoomValue;

//地图移动前中心经纬度
@property (nonatomic, assign) CLLocationCoordinate2D oldCoor;

@property (nonatomic, assign) float lat;

@property (nonatomic, assign) float lng;

@property (nonatomic, assign) float radius;


@end

@implementation NearController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    UIButton *detailButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [detailButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    detailButton.frame = CGRectMake(0, 0, 15, 10);
    detailButton.contentEdgeInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    
    UIBarButtonItem *detailItem = [[UIBarButtonItem alloc] initWithCustomView:detailButton];
    [self.navigationBarItem setLeftBarButtonItems:[NSArray arrayWithObjects:detailItem,nil]];
    
    [self addUI];
}

- (void)viewWillAppear:(BOOL)animated {
    self.isCustomNavigation = YES;
    self.isNavigationTransparent = YES;
    
    [self.bMapView viewWillAppear];
    self.bMapView.delegate = self; //
    self.locService.delegate = self;
    [self.locService startUserLocationService];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.bMapView viewWillDisappear];
    self.bMapView.delegate = nil; // 不用时，置nil
    self.locService.delegate = nil;
    [self.locService stopUserLocationService];
    
    self.isCustomNavigation = NO;
    self.isNavigationTransparent = NO;
}

- (void)dealloc {
    if (self.bMapView) {
        self.bMapView = nil;
    }
    if (self.locService) {
        self.locService.delegate = nil;
    }
}

#pragma mark -- UI

/// 核心思想 是利用比例尺判断   采用真机调试
- (void)addUI {
    self.bMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight)];
    [self.view addSubview:self.bMapView];
    self.bMapView.delegate = self;
    self.bMapView.showsUserLocation = YES;
    self.bMapView.showMapScaleBar = YES;//显示比例尺
    self.bMapView.mapScaleBarPosition = CGPointMake(10, 75);//比例尺位置
    self.bMapView.minZoomLevel = 6;
    self.bMapView.maxZoomLevel = 18;///在手机上当前可使用的级别为3-21级
    self.bMapView.isSelectedAnnotationViewFront = YES;
    self.bMapView.userTrackingMode = BMKUserTrackingModeNone;
    
    self.locService = [[BMKLocationService alloc] init];
    self.locService.delegate = self;
    [self.locService startUserLocationService];
    
    self.zoomValue = 11;
    self.bMapView.zoomLevel = self.zoomValue;
    self.lat = 0;
    self.lng = 0;
    self.radius = 0;
}

#pragma mark -- 回到用户的位置。
- (void)backUserLocation {
    //移动到用户的位置
    [self.bMapView setCenterCoordinate:self.locService.userLocation.location.coordinate animated:YES];
}

#pragma mark -- 定位的代理

/**
 *在地图View将要启动定位时，会调用此函数
 */
- (void)willStartLocatingUser {
    NSLog(@"start locate");
}

/**
 *在地图View停止定位后，会调用此函数
 */
- (void)didStopLocatingUser {
    NSLog(@"stop locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    [self.bMapView updateLocationData:userLocation];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [self.bMapView updateLocationData:userLocation];

    if ((self.lat == 0) && (self.lng == 0) && (self.radius == 0)) {
        self.bMapView.centerCoordinate = userLocation.location.coordinate;
        self.lat = userLocation.location.coordinate.latitude;
        self.lng = userLocation.location.coordinate.longitude;
        [self setParamsOfRadius];
        [self netForBird];
    }
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"location error");
}

#pragma mark-- 区域变动的代理

- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
    self.zoomValue = mapView.zoomLevel;
    self.oldCoor = mapView.centerCoordinate;
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.lat = mapView.centerCoordinate.latitude;
    self.lng = mapView.centerCoordinate.longitude;
    [self setParamsOfRadius];
    
    if (mapView.zoomLevel > self.zoomValue) {
        NSLog(@"地图放大了");
    }else if (mapView.zoomLevel < self.zoomValue){
        NSLog(@"地图缩小了");
    }
    
    if (mapView.zoomLevel > 14) {
        
        //请求小区
        //当没有放大缩小 计算平移的距离。当距离小于2千米。不再进行计算  避免过度消耗
        float distance = [self distanceBetweenFromCoor:self.oldCoor toCoor:mapView.centerCoordinate];
        if (distance <= 1000 && mapView.zoomLevel == self.zoomValue) {
            return;
        }
        [self netForBird];
        
    } else if(mapView.zoomLevel <= 14) {
        if (mapView.zoomLevel == self.zoomValue) {//当平移地图。大区不再重复请求
            return;
        }
        
        [self netForBird];
    }
}

- (void)setParamsOfRadius {
    CLLocationCoordinate2D location = [self.bMapView convertPoint:CGPointMake(0, SCREEN_WIDTH / 2) toCoordinateFromView:self.bMapView];
    
    float distance = [self distanceBetweenFromCoor:self.bMapView.centerCoordinate toCoor:location];

    self.radius = distance;
}

//使用苹果原生库计算两个经纬度直接的距离
- (double)distanceBetweenFromCoor:(CLLocationCoordinate2D)coor1 toCoor:(CLLocationCoordinate2D)coor2 {
    CLLocation *curLocation = [[CLLocation alloc] initWithLatitude:coor1.latitude longitude:coor1.longitude];
    CLLocation *otherLocation = [[CLLocation alloc] initWithLatitude:coor2.latitude longitude:coor2.longitude];
    double distance  = [curLocation distanceFromLocation:otherLocation];
    return distance;
}

#pragma mark -- 大头针的代理

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {

}


- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation {
    BDAnnotation *anno = (BDAnnotation *)annotation;
    
    // 检查是否有重用的缓存
    RoundAnnotationView *annotationView = (RoundAnnotationView *)[view dequeueReusableAnnotationViewWithIdentifier:@"round"];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[RoundAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"round"];
        annotationView.paopaoView = nil;
    }
    
    annotationView.title = anno.title;
    annotationView.imgUrl = anno.imgUrl;
    
    annotationView.annotation = anno;
    annotationView.canShowCallout = NO;
    
    return annotationView;
    
}

//点击了大头针
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    if (view.annotation.coordinate.latitude == self.locService.userLocation.location.coordinate.latitude) {//个人位置特殊处理，否则类型不匹配崩溃
        NSLog(@"点击了个人位置");
        return;
    }
    BDAnnotation *annotation = (BDAnnotation *)view.annotation;
//
//    //拿到大头针经纬度，放大地图。然后重新计算小区
//    [mapView setCenterCoordinate:annotation.coordinate animated:NO];
//    [mapView setZoomLevel:16];
    
    MapDisCoverView *birdView = [[MapDisCoverView alloc] initWithFrame:CGRectMake(AutoSize6(30), AutoSize6(100), SCREEN_WIDTH - AutoSize6(60), SCREEN_HEIGHT - AutoSize6(100) - kTabBarHeight - AutoSize6(100))];
    [self.view addSubview:birdView];
    [self.view bringSubviewToFront:birdView];
    
    birdView.dataArray = [NSMutableArray arrayWithArray:annotation.birdArray];
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view {

}


#pragma mark-- 数据相关
- (void)netForBird {
    @weakify(self);
    [DiscoverDao getNearBird:[NSString stringWithFormat:@"%f", self.lat]
                        type:[NSString stringWithFormat:@"%f", self.lng]
                      radius:[NSString stringWithFormat:@"%f", self.radius]
                successBlock:^(__kindof AppBaseModel *responseObject) {
                    @strongify(self);
                    
                    MapDiscoverDataModel *data = (MapDiscoverDataModel *)responseObject;
                    
                    for (MapDiscoverGpsModel *gpsModel in data.data) {
                        
                        BDAnnotation *an = [[BDAnnotation alloc] init];
                        CLLocationCoordinate2D coor;
                        coor.latitude = gpsModel.gpsInfo.lat.floatValue ;
                        coor.longitude = gpsModel.gpsInfo.lng.floatValue;
                        an.coordinate = coor;
                        an.birdArray = [NSArray arrayWithArray:gpsModel.gpsInfo.birdInfo];
                        if (gpsModel.gpsInfo.birdInfo.count > 100) {
                            an.title = @"100+";
                        } else {
                            an.title = [NSString stringWithFormat:@"%ld", gpsModel.gpsInfo.birdInfo.count];
                        }
                        an.imgUrl = ((MapDiscoverInfoModel *)gpsModel.gpsInfo.birdInfo.firstObject).imgUrl;
                        [self.bMapView addAnnotation:an];
                    }
                    
                } failureBlock:^(__kindof AppBaseModel *error) {
                    @strongify(self);
                    [AppBaseHud showHudWithfail:error.errstr view:self.view];
                }];
}



//地图渲染完毕
- (void)mapViewDidFinishRendering:(BMKMapView *)mapView {
    
//    //避免屏幕内没有房源-->计算屏幕右上角、左下角经纬度-->获取这个区域内所有的大头针-->判断有没有大头针-->若屏幕内没有，但整个地图中存在大头针-->移动中心点到这个大头针
//    BMKCoordinateBounds coorbBound;
//    CLLocationCoordinate2D northEast;
//    CLLocationCoordinate2D southWest;
//    northEast = [mapView convertPoint:CGPointMake(SCREEN_WIDTH, 0) toCoordinateFromView:mapView];
//    southWest = [mapView convertPoint:CGPointMake(0, SCREEN_HEIGHT) toCoordinateFromView:mapView];
//    coorbBound.northEast = northEast;
//    coorbBound.southWest = southWest;
//    NSArray *annotations = [mapView annotationsInCoordinateBounds:coorbBound];
//    if (annotations.count == 0 && mapView.annotations.count > 0 && mapView.zoomLevel != self.zoomValue) {
//        BDAnnotation *firstAnno = mapView.annotations.firstObject;
//        //如果是个人位置的大头针。那么如果地图中大头针个数又大于1.取最后一个；否则return
//        if (firstAnno.coordinate.latitude == self.locService.userLocation.location.coordinate.latitude) {
//            NSLog(@"这是个个人位置大头针");
//            if (mapView.annotations.count > 1) {
//                firstAnno = mapView.annotations.lastObject;
//            }else {
//                return;
//            }
//        }
//        [mapView setCenterCoordinate:firstAnno.coordinate animated:NO];
//    }
    
}



@end
