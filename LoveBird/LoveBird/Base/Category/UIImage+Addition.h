//
//  UIImage+Addition.h
//  loan
//
//  Created by ChenYanping on 12/11/15.
//  Copyright © 2015 renxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

/**
 *  UIIamge 带背景色
 *
 *  @param color 背景色
 *  @param size  画布大小
 *
 *  @return 新的UIImage
 */
- (UIImage *)drawImageWithBackgroudColor:(UIColor *)color withSize:(CGSize)size;

/**
 *  指定大小切图
 */
- (UIImage *)croppedImage:(CGRect)bounds;

//等比例缩小图片 使其大小不超过指定的大小
- (UIImage *)compressImage:(UIImage *)image withMaxSize:(CGSize)size;

//修正照片方向
- (UIImage *)fixOrientation;

//等比例缩放图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

/**
 *  图片默认背景图
 *
 *  @param size 大小
 *
 *  @return UIIamge
 */
+ (UIImage *)backgroundPlaceHolerView:(CGSize)size;

/**
 *  根据url 去下载图片 并且存储
 */
+ (void)saveImageWithURL:(NSString *)url;


/**
 *  根据url 去获取图片
 */
+ (UIImage *)getImageFromURL:(NSString *)fileURL ;


- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;

@end
