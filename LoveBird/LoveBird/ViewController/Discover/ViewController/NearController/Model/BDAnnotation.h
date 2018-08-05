
#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>
#import "MapDiscoverModel.h"

/// 基于BaiduMapKit
@interface BDAnnotation : NSObject <BMKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imgUrl;

@property (nonatomic, strong) MapDiscoverModel *mapModel;

@property (nonatomic, strong) NSArray *birdArray;

@end
