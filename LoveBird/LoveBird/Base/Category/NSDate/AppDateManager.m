//
//  AppDateManager.m
//  LoveBird
//
//  Created by ShanCheli on 2018/5/9.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import "AppDateManager.h"

static AppDateManager *share = nil;


@implementation AppDateManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 默认formatter样式
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        self.dateFormatter = formatter;
    }
    return self;
}


/**
 *  获取当前时间，例如：20150730
 *
 *  @return 当前时间
 */
- (NSString *)getCurrentDate {
    NSDate *date = [NSDate date];
    [self.dateFormatter setDateFormat:DateFormatYMD1];
    NSString *strDate = [self.dateFormatter stringFromDate:date];
    return strDate;
}

- (NSString *)getDateWithTimeInterval:(NSInteger)timeInterval formatSytle:(NSString *)formatSytle {
    if (!formatSytle) {
        formatSytle = DateFormatMD;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    [self.dateFormatter setDateFormat:formatSytle];
    NSString *resultStr=[self.dateFormatter stringFromDate:date];
    return resultStr;
}

- (NSString *)getDateWithNSDate:(NSDate *)date formatSytle:(NSString *)formatSytle {
    if (!formatSytle) {
        formatSytle = DateFormatYMD2;
    }
    [self.dateFormatter setDateFormat:formatSytle];
    NSString *resultStr = [self.dateFormatter stringFromDate:date];
    return resultStr;
}

- (NSDate *)getDateWithString:(NSString *)timeString formatSytle:(NSString *)formatSytle {
    if (!formatSytle) {
        formatSytle = DateFormatYMD2;
    }
    [self.dateFormatter setDateFormat:formatSytle];
    NSDate *date = [self.dateFormatter dateFromString:timeString];
    
    return date;
}

+ (AppDateManager *)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[AppDateManager alloc] init];
    });
    return share;
}

- (NSTimeInterval)getCountdownTimeWithAmountTimeInterval:(NSTimeInterval)amountTimeInterval
                                               startTime:(NSTimeInterval)startTime
                                             formatSytle:(NSString *)formatSytle {
    
    self.dateFormatter.dateFormat = formatSytle;
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:startTime];
    
    NSTimeInterval haveTime = amountTimeInterval + [startDate timeIntervalSinceNow];
    
    if (haveTime < 0) {
        haveTime = -1;
    }
    return haveTime;
}

/**
 *  根据时间戳获取一定格式的日期
 *
 *  @param time  时间戳
 *  @param formatSytle 格式 eg: yyMMdd
 *
 *  @return 日期
 */
- (NSString *)getDateWithTime:(NSString *)time formatSytle:(NSString *)formatSytle {
    
    NSTimeInterval timeint = [time doubleValue];//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:timeint];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatSytle];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}
@end
