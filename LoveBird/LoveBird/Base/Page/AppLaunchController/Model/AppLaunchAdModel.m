//
//  AppLaunchAdModel.m
//  LoveBird
//
//  Created by ShanCheli on 2017/7/6.
//  Copyright © 2017年 shancheli. All rights reserved.
//

#import "AppLaunchAdModel.h"

@implementation AppLaunchAdModel

-(CGFloat)width
{
    return [[[self.contentSize componentsSeparatedByString:@"*"] firstObject] floatValue];
}
-(CGFloat)height
{
    return [[[self.contentSize componentsSeparatedByString:@"*"] lastObject] floatValue];
}

@end
