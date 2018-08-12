//
//  AppDateManager.h
//  LoveBird
//
//  Created by ShanCheli on 2018/5/9.
//  Copyright © 2018年 shancheli. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *DateFormatYMDHMS = @"yyyy-MM-dd HH:mm:ss";

static NSString *DateFormatYMDHM = @"yyyy-MM-dd HH:mm";

static NSString *DateFormatMDHM = @"MM-dd HH:mm";

static NSString *DateFormatYMD = @"yyyy-MM-dd";

static NSString *DateFormatYMD1 = @"yyyyMMdd";

static NSString *DateFormatYMD2 = @"yyyy/MM/dd";

static NSString *DateFormatMD = @"MM-dd";

static NSString *DateFormatMD2 = @"MM/dd";

static NSString *DateFormatD = @"dd";

static NSString *DateFormatM = @"MM";

@interface AppDateManager : NSObject

// 时间样式
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

+ (AppDateManager *)shareManager;

/**
 *  获取当前时间，例如：20150730
 *
 *  @return 当前时间
 */
- (NSString *)getCurrentDate;

/**
 *  获取当前时间，例如：20150730
 *
 *  @return 当前时间
 */
- (NSString *)getCurrentDateWithFormatStyle:(NSString *)formatSytle;

/**
 *  get date by dateFormat MM-dd, for example 07-06
 */
- (NSString *)getDateWithTimeInterval:(NSInteger)timeInterval formatSytle:(NSString *)formatSytle;

/**
 *  格式化时间戳
 *
 *  @param date        NSDate格式
 *  @param formatSytle 格式 eg: yy/MM/dd
 *
 *  @return NSString
 */
- (NSString *)getDateWithNSDate:(NSDate *)date formatSytle:(NSString *)formatSytle;

/**
 *  根据string获取nsdate
 *
 *  @param timeString  时间string
 *  @param formatSytle 格式 eg: yyMMdd
 *
 *  @return NSDate
 */
- (NSDate *)getDateWithString:(NSString *)timeString formatSytle:(NSString *)formatSytle;



/**
 *  获取倒计时剩余的时间
 *
 *  @param amountTimeInterval 倒计时多长时间, eg:倒计时8小时 给 8*60*60
 *  @param startTime    时间戳 1970
 *  @param formatSytle 格式 eg: yyMMdd
 *
 *  @return 返回值为 倒计时剩余多少秒, 如果倒计时已过,返回 -1
 */
- (NSTimeInterval)getCountdownTimeWithAmountTimeInterval:(NSTimeInterval)amountTimeInterval
                                               startTime:(NSTimeInterval)startTime
                                             formatSytle:(NSString *)formatSytle;

/**
 *  根据时间戳获取一定格式的日期
 *
 *  @param time  时间戳
 *  @param formatSytle 格式 eg: yyMMdd
 *
 *  @return 日期
 */
- (NSString *)getDateWithTime:(NSString *)time formatSytle:(NSString *)formatSytle;

- (NSString *)getDateWithTime1000:(NSString *)time formatSytle:(NSString *)formatSytle;


/**
 *  根据时间戳获取一定格式的日期
 *
 *  @param time  时间戳
 *
 *  @return 一月  二月
 */
- (NSString *)getMonthWithTime:(NSString *)time;


- (NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

- (NSString *)getNowTimestamp;

@end
