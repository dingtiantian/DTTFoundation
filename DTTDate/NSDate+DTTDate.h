//
//  NSDate+DTTDate.h
//  Pods
//
//  Created by majian on 16/6/7.
//
//

#import <Foundation/Foundation.h>
#import <DTTFoundation/NSDate+DTTTimeStamp.h>

/** 分钟 转换为 秒 */
extern NSUInteger dtt_oneMinuteToSeconds(void);
extern NSUInteger dtt_muchMinitesToSeconds(NSUInteger numberOfMinites);

/** 小时 转换为 秒 */
extern NSUInteger dtt_oneHourToSeconds(void);
extern NSUInteger dtt_muchHoursToSeconds(NSUInteger numberOfHours);

/** 天 转换为 秒 */
extern NSUInteger dtt_oneDayToSeconds(void);
extern NSUInteger dtt_muchDaysToSeconds(NSUInteger numberOfDays);

/** 周 */
extern NSUInteger dtt_oneWeekToSeconds(void);

/** 年 转换为 秒 */
extern NSUInteger dtt_oneYearToSeconds(void);
extern NSUInteger dtt_muchYearsToSeconds(NSUInteger numberOfYears);

/** 将秒数转变成时间格式 80 => 01:20    4020 => 01:05:20 */
extern NSString* dtt_convertToTimeFormat(NSTimeInterval timeSecond);

NS_ASSUME_NONNULL_BEGIN
@interface NSDate (DTTDate)

+ (NSDate *)dtt_date;

/**
 将 时间戳 转成 13位
 10 --> 13
 13 --> 13
 其他 --> 0
 */
+ (long long)dtt_convertToTimeStamp13:(long long)aTimeStamp;
- (long long)dtt_convertToTimeStamp13:(long long)aTimeStamp;
/*! *  当前时间戳,13位 */
+ (long long)dtt_currentTimeStamp13;

/*! *  当前时间戳,10位 */
+ (long long)dtt_currentTimeStamp10;

/** @timestamp 时间戳
 @result    当天: 今天8:00      昨天: 11:11  前天以前: 12.4 11:11
 */
+ (NSString *)dtt_toRegularTime:(NSString *)timestamp;

+ (NSString *)dtt_tofutureTime:(NSString *)timestamp;

/** *当天的00时00分00秒 时间戳 10位 */
+ (long long)dtt_todayStartTimeStamp10;
/** 当前的23时59分59秒  时间戳 10位 */
+ (long long)dtt_todayEndTimeStamp10;
/** *当天的00时00分00秒 时间戳 13位 */
+ (long long)dtt_todayStartTimeStamp13;
/** 当前的23时59分59秒  时间戳 13位 */
+ (long long)dtt_todayEndTimeStamp13;

/** 给定时间 当天的起始时间 时间戳 10位 */
- (long long)dtt_todayStartTimeStamp10;
- (NSDate *)dtt_todayStartTimeDate;
/** 当前的23时59分59秒 时间戳 10位 */
- (long long)dtt_todayEndTimeStamp10;
- (NSDate *)dtt_todayEndTimeDate;
/** 给定时间 当天的起始时间 时间戳 13位 */
- (long long)dtt_startTimeStamp13;

/** *当周的00时00分00秒 时间戳 10位 从周日开始 */
+ (long long)dtt_currentWeekStartTimeStamp10FromSunday;
/** *当周最后一天的23:59:59 时间戳 10位 从周日开始 */
+ (long long)dtt_currentWeekEndTimeStamp10FromSunday;
/** *当周的00时00分00秒 时间戳 13位 从周日开始 */
+ (long long)dtt_currentWeekStartTimeStamp13FromSunday;
/** *当周的00时00分00秒 时间戳 10位 从周一开始 */
+ (long long)dtt_currentWeekStartTimeStamp10FromMonday;
+ (NSDate *)dtt_currentWeekStartDateFromMonday;
/** *当周最后一天的23时59分59秒 时间戳 10位 从周一开始 */
+ (long long)dtt_currentWeekEndTimeStamp10FromMonday;
+ (NSDate *)dtt_currentWeekEndDateFromMonday;
/** *当周的00时00分00秒 时间戳 13位 从周一开始 */
+ (long long)dtt_currentWeekStartTimeStamp13FromMonday;
//给定时间的00时00分00秒 时间戳
- (long long)dtt_weekStartTimeStamp10FromSunday;
- (long long)dtt_weekEndTimeStamp10FromSunday;
- (long long)dtt_weekStartTimeStamp13FromSunday;
- (long long)dtt_weekStartTimeStamp10FromMonday;
- (NSDate *)dtt_weekStartDateFromMonday;
- (long long)dtt_weekEndTimeStamp10FromMonday;
- (NSDate *)dtt_weekEndDateFromMonday;
- (long long)dtt_weekStartTimeStamp13FromMonday;

+ (NSDate *)dtt_monthStartDateForYear:(NSUInteger)year month:(NSUInteger)month;
+ (NSDate *)dtt_monthEndDateForYear:(NSUInteger)year month:(NSUInteger)month;

+ (NSDate *)dtt_yearStartDateForYear:(NSUInteger)year;
+ (NSDate *)dtt_yearEndDateForYear:(NSUInteger)year;

// 月
- (NSDate *)dtt_monthStartDate;
- (NSDate *)dtt_monthEndTimeDate;

//年
- (NSDate *)dtt_yearStartDate;
- (NSDate *)dtt_yearEndDate;

/** 获取当月的天数 */
- (NSUInteger)dtt_daysOfCurrentMonth;

@end

@interface NSString (DTTDateTime)

/**  将字符串转成 00:00:00 */
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString * _Nonnull convertToTime;

- (NSString *)dtt_toRegularTime;

@end
NS_ASSUME_NONNULL_END
