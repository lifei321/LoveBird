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

- (NSString *)getCurrentYear {
    NSDate *date = [NSDate date];
    [self.dateFormatter setDateFormat:DateFormatY];
    NSString *strDate = [self.dateFormatter stringFromDate:date];
    return strDate;
}

- (NSString *)getCurrentDateWithFormatStyle:(NSString *)formatSytle {
    NSDate *date = [NSDate date];
    [self.dateFormatter setDateFormat:formatSytle];
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

- (NSString *)getDateWithTime1000:(NSString *)time formatSytle:(NSString *)formatSytle {
    
    NSTimeInterval timeint = [time doubleValue] / 1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:timeint];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:formatSytle];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}


- (NSString *)getMonthWithTime:(NSString *)time {
    
    NSString *month = [[AppDateManager shareManager] getDateWithTime:time formatSytle:DateFormatM];
    if ([month isEqualToString:@"01"]) {
        return @"一月";
    }
    
    if ([month isEqualToString:@"02"]) {
        return @"二月";
    }

    if ([month isEqualToString:@"03"]) {
        return @"三月";
    }

    if ([month isEqualToString:@"04"]) {
        return @"四月";
    }

    if ([month isEqualToString:@"05"]) {
        return @"五月";
    }

    if ([month isEqualToString:@"06"]) {
        return @"六月";
    }

    if ([month isEqualToString:@"07"]) {
        return @"七月";
    }

    if ([month isEqualToString:@"08"]) {
        return @"八月";
    }

    if ([month isEqualToString:@"09"]) {
        return @"九月";
    }

    if ([month isEqualToString:@"10"]) {
        return @"十月";
    }
    if ([month isEqualToString:@"11"]) {
        return @"十一月";
    }
    
    if ([month isEqualToString:@"12"]) {
        return @"十二月";
    }

    return @"";
}


//将某个时间转化成 时间戳

#pragma mark - 将某个时间转化成 时间戳

- (NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{

    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSString *timeSp = [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];

    
    
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    
    
    return timeSp;
    
}


//获取当前系统时间的时间戳

#pragma mark - 获取当前时间的 时间戳

- (NSString *)getNowTimestamp{
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间
    
    
    
    NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    
    //时间转时间戳的方法:
    
    
    NSString *timeSp = [NSString stringWithFormat:@"%f",[datenow timeIntervalSince1970]];

    
    
    
    return timeSp;
    
}



@end
