//
//  NSDate+DTTDate.m
//  Pods
//
//  Created by dtt on 16/6/7.
//
//

#import "NSDate+DTTDate.h"

/**
 分钟 转换为 秒
 */
NSUInteger dtt_oneMinuteToSeconds(void) {
    return 60;
}
NSUInteger dtt_muchMinitesToSeconds(NSUInteger numberOfMinites) {
    return numberOfMinites * 60;
}

/**
 小时 转换为 秒
 */
NSUInteger dtt_oneHourToSeconds(void) {
    return dtt_muchMinitesToSeconds(60);
}
NSUInteger dtt_muchHoursToSeconds(NSUInteger numberOfHours) {
    return dtt_oneHourToSeconds() * numberOfHours;
}

/**
 天 转换为 秒
 */
NSUInteger dtt_oneDayToSeconds(void) {
    return dtt_muchHoursToSeconds(24);
}
NSUInteger dtt_muchDaysToSeconds(NSUInteger numberOfDays) {
    return dtt_oneDayToSeconds() * numberOfDays;
}
/**
周
 */
NSUInteger dtt_oneWeekToSeconds(void) {
    return dtt_muchDaysToSeconds(7);
}
/**
 年 转换为 秒
 */
extern NSUInteger dtt_oneYearToSeconds(void) {
    return dtt_muchDaysToSeconds(365);
}
extern NSUInteger dtt_muchYearsToSeconds(NSUInteger numberOfYears) {
    return dtt_oneYearToSeconds() * numberOfYears;
}

/** 将秒数转变成时间格式 80 => 01:20    4020 => 01:05:20 */
extern NSString* dtt_convertToTimeFormat(NSTimeInterval timeSecond) {
    NSString *theLastTime = nil;
    long second = timeSecond;
    if (timeSecond < 0) {
        theLastTime = @"00:00";
    } else if (timeSecond < 60) {
        theLastTime = [NSString stringWithFormat:@"00:%02zd", second];
    } else if(timeSecond >= 60 && timeSecond < 3600){
        theLastTime = [NSString stringWithFormat:@"%02zd:%02zd", second / 60, second % 60];
    } else if(timeSecond >= 3600){
        theLastTime = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", second / 3600, second % 3600 / 60, second % 60];
    }
    return theLastTime;
}

@implementation NSDate (DTTDate)

+ (NSDate *)dtt_date {
    return [NSDate date];
}

+ (long long)dtt_convertToTimeStamp13:(long long)aTimeStamp {
    NSString * timeStampStr = NSStringFromunsignedLongLong(aTimeStamp);
    if (timeStampStr.length == 13) {
        return aTimeStamp;
    }

    if (timeStampStr.length == 10) {
        return [[timeStampStr dtt_appendString:@"000"] longLongValue];
    }

    return 0;
}
- (long long)dtt_convertToTimeStamp13:(long long)aTimeStamp {
    return [NSDate dtt_convertToTimeStamp13:aTimeStamp];
}
/*!
 *  当前时间戳,13位
 */
+ (long long)dtt_currentTimeStamp13 {
    return [self dtt_convertToTimeStamp13:[self dtt_currentTimeStamp10]];
}

/*!
 *  当前时间戳,10位
 */
+ (long long)dtt_currentTimeStamp10 {
    
    return [NSDate dtt_date].timeIntervalSince1970;
}

+ (NSString *)dtt_toRegularTime:(NSString *)timestamp {
    NSDate * date = [NSDate dtt_dateWithTimeStamp:timestamp];
    
    if ([date dtt_isToday]) { //今天
        return [NSString stringWithFormat:@"今天 %02ld:%02ld",(long)date.dtt_hour,(long)date.dtt_minute];
    } else if ([date dtt_isYesterday]) { //昨天
        return [NSString stringWithFormat:@"昨天 %02ld:%02ld",(long)date.dtt_hour,(long)date.dtt_minute];
    } else { //以前
        return [NSString stringWithFormat:@"%ld.%02ld.%02ld %02ld:%02ld",(long)date.dtt_year,(long)date.dtt_month,(long)date.dtt_day,(long)date.dtt_hour,(long)date.dtt_minute];
    }
}

+ (NSString *)dtt_tofutureTime:(NSString *)timestamp{
    NSDate * date = [NSDate dtt_dateWithTimeStamp:timestamp];
    return [NSString stringWithFormat:@"%02ld.%02ld %02ld:%02ld",(long)date.dtt_month,(long)date.dtt_day,(long)date.dtt_hour,(long)date.dtt_minute];
}

/**
 *当天的00时00分00秒 时间戳 10位
 */
+ (long long)dtt_todayStartTimeStamp10 {
    NSDate * date = [NSDate dtt_date];
    long long currentTime = [self dtt_currentTimeStamp10];
    long long leftTime = date.dtt_hour * dtt_oneHourToSeconds() + date.dtt_minute * dtt_oneMinuteToSeconds() + date.dtt_second;
    return currentTime - leftTime;
}

/**
 当前的23时59分59秒  时间戳 10位
 */
+ (long long)dtt_todayEndTimeStamp10 {
    return [self dtt_todayStartTimeStamp10] + dtt_oneDayToSeconds() - 1;
}

/**
 *当天的00时00分00秒 时间戳 13位
 */
+ (long long)dtt_todayStartTimeStamp13 {
    return [self dtt_convertToTimeStamp13:[self dtt_todayStartTimeStamp10]];
}

/**
 当前的23时59分59秒  时间戳 13位
 */
+ (long long)dtt_todayEndTimeStamp13 {
    return [self dtt_convertToTimeStamp13:[self dtt_todayEndTimeStamp10]];
}

- (long long)dtt_todayStartTimeStamp10 {
    long long dateStamp = [self timeIntervalSince1970];
    long long leftTime = self.dtt_hour * dtt_oneHourToSeconds() + self.dtt_minute * dtt_oneMinuteToSeconds() + self.dtt_second;
    return dateStamp - leftTime;
}

- (NSDate *)dtt_todayStartTimeDate {
    return [NSDate dtt_dateWithTimeStamp:@([self dtt_todayStartTimeStamp10]).stringValue];
}

/**
 当前的23时59分59秒 时间戳 10位
 */
- (long long)dtt_todayEndTimeStamp10 {
    return [self dtt_todayStartTimeStamp10] + dtt_oneDayToSeconds() - 1;
}

- (NSDate *)dtt_todayEndTimeDate {
    return [NSDate dtt_dateWithTimeStamp:@([self dtt_todayEndTimeStamp10]).stringValue];
}

- (long long)dtt_startTimeStamp13 {
    return [NSDate dtt_convertToTimeStamp13:[self dtt_todayStartTimeStamp10]];
}
/**
 *当周的00时00分00秒 时间戳 10位 从周日开始
 */
+ (long long)dtt_currentWeekStartTimeStamp10FromSunday {
    return [[NSDate dtt_date] dtt_weekStartTimeStamp10FromSunday];
}
/**
 *当周最后一天的23:59:59 时间戳 10位 从周日开始
 */
+ (long long)dtt_currentWeekEndTimeStamp10FromSunday {
    return [self dtt_currentWeekStartTimeStamp10FromSunday] + dtt_oneWeekToSeconds() - 1;
}
/**
 *当周的00时00分00秒 时间戳 13位 从周日开始
 */
+ (long long)dtt_currentWeekStartTimeStamp13FromSunday {
    return [self dtt_convertToTimeStamp13:[self dtt_currentWeekStartTimeStamp10FromSunday]];
}
/**
 *当周的00时00分00秒 时间戳 10位 从周一开始
 */
+ (long long)dtt_currentWeekStartTimeStamp10FromMonday {
    return [[NSDate dtt_date] dtt_weekStartTimeStamp10FromMonday];
}
+ (NSDate *)dtt_currentWeekStartDateFromMonday {
    return [self dtt_dateWithTimeStamp:@([self dtt_currentWeekStartTimeStamp10FromMonday]).stringValue];
}
/**
 *当周最后一天的23时59分59秒 时间戳 10位 从周一开始
 */
+ (long long)dtt_currentWeekEndTimeStamp10FromMonday {
    return [self dtt_currentWeekStartTimeStamp10FromMonday] + dtt_oneWeekToSeconds() - 1;
}
+ (NSDate *)dtt_currentWeekEndDateFromMonday {
    return [self dtt_dateWithTimeStamp:@([self dtt_currentWeekEndTimeStamp10FromMonday]).stringValue];
}
/**
 *当周的00时00分00秒 时间戳 13位 从周一开始
 */
+ (long long)dtt_currentWeekStartTimeStamp13FromMonday {
    return [self dtt_convertToTimeStamp13:[self dtt_currentWeekStartTimeStamp10FromMonday]];
}

    //给定时间的00时00分00秒 时间戳
- (long long)dtt_weekStartTimeStamp10FromSunday {
    NSUInteger dayOfWeek = self.dtt_dayOfWeek; //周一为 第2天
    //当前时间 - 多余的时间
    return self.dtt_todayStartTimeStamp10 - (dayOfWeek - 1) * dtt_oneDayToSeconds();
}

- (long long)dtt_weekEndTimeStamp10FromSunday {
    return [self dtt_weekStartTimeStamp10FromSunday] + dtt_oneWeekToSeconds() - 1;
}

- (long long)dtt_weekStartTimeStamp13FromSunday {
    return [self dtt_convertToTimeStamp13:[self dtt_weekStartTimeStamp10FromSunday]];
}

- (long long)dtt_weekStartTimeStamp10FromMonday {
    NSUInteger dayOfWeek =self.dtt_dayOfWeek; //周一为 第2天
    if (dayOfWeek == 1) {
            //这里的周日 也就是第一天实际为上周的最后一天
            //当前时间 - 多余时间
        return self.dtt_todayStartTimeStamp10 - 6 * dtt_oneDayToSeconds();
    }

        //当前时间 - 多余的时间
    return self.dtt_todayStartTimeStamp10 - (dayOfWeek - 2) * dtt_oneDayToSeconds();
}

- (NSDate *)dtt_weekStartDateFromMonday {
    return [NSDate dtt_dateWithTimeStamp:@([self dtt_weekStartTimeStamp10FromMonday]).stringValue];
}

- (long long)dtt_weekEndTimeStamp10FromMonday {
    return [self dtt_weekStartTimeStamp10FromMonday] + dtt_oneWeekToSeconds() - 1;
}

- (NSDate *)dtt_weekEndDateFromMonday {
    return [NSDate dtt_dateWithTimeStamp:@([self dtt_weekEndTimeStamp10FromMonday]).stringValue];
}

- (long long)dtt_weekStartTimeStamp13FromMonday {
    return [self dtt_convertToTimeStamp13:[self dtt_weekStartTimeStamp10FromMonday]];
}

+ (NSDate *)dtt_monthStartDateForYear:(NSUInteger)year month:(NSUInteger)month {
    NSDateComponents * dateCom = [[NSDateComponents alloc] init];
    dateCom.year = year;
    dateCom.month = month;
    dateCom.day = 1;
    dateCom.hour = 0;
    dateCom.minute = 0;
    dateCom.second = 0;
    dateCom.calendar = [NSCalendar currentCalendar];
    return dateCom.date;
}

- (NSUInteger)dtt_daysOfCurrentMonth {
    NSUInteger year = self.dtt_year;
    NSUInteger month = self.dtt_month;
    NSUInteger days = 31;
    switch (month) {
        case 4:
        case 6:
        case 9:
        case 11:
            days = 30;
            break;
        case 2:
            if ((year % 4 ==0 && year % 100 != 0) || year % 400 == 0) {
                days = 29;
            } else {
                days  = 28;
            }
            break;
        default:
            break;
    }

    return days;
}

+ (NSDate *)dtt_monthEndDateForYear:(NSUInteger)year month:(NSUInteger)month {
    NSUInteger lastDay = 31;
    switch (month) {
        case 4:
        case 6:
        case 9:
        case 11:
            lastDay = 30;
            break;
        case 2:
            if ((year / 100 == 0 && year / 400 == 0) || year % 4 == 0) {
                lastDay = 29;
            } else {
                lastDay = 28;
            }
            break;
        default:
            break;
    }

    NSDateComponents * dateCom = [[NSDateComponents alloc] init];
    dateCom.year = year;
    dateCom.month = month;
    dateCom.day = lastDay;
    dateCom.hour = 23;
    dateCom.minute = 59;
    dateCom.second = 59;
    dateCom.calendar = [NSCalendar currentCalendar];
    return dateCom.date;
}

+ (NSDate *)dtt_yearStartDateForYear:(NSUInteger)year {
    NSDateComponents * dateCom = [[NSDateComponents alloc] init];
    dateCom.year = year;
    dateCom.month = 1;
    dateCom.day = 1;
    dateCom.hour = 0;
    dateCom.minute = 0;
    dateCom.second = 0;
    dateCom.calendar = [NSCalendar currentCalendar];
    return dateCom.date;
}
+ (NSDate *)dtt_yearEndDateForYear:(NSUInteger)year {
    NSDateComponents * dateCom = [[NSDateComponents alloc] init];
    dateCom.year = year;
    dateCom.month = 12;
    dateCom.day = 31;
    dateCom.hour = 23;
    dateCom.minute = 59;
    dateCom.second = 59;
    dateCom.calendar = [NSCalendar currentCalendar];
    return dateCom.date;
}

    // 月
- (NSDate *)dtt_monthStartDate {
    return [NSDate dtt_monthStartDateForYear:self.dtt_year month:self.dtt_month];
}
- (NSDate *)dtt_monthEndTimeDate {
    return [NSDate dtt_monthEndDateForYear:self.dtt_year month:self.dtt_month];
}

    //年
- (NSDate *)dtt_yearStartDate {
    return [NSDate dtt_yearStartDateForYear:self.dtt_year];
}
- (NSDate *)dtt_yearEndDate {
    return [NSDate dtt_yearEndDateForYear:self.dtt_year];
}

@end

@implementation NSString (DTTDateTime)

/**
 *  将字符串转成 00:00:00
 */
- (NSString *)convertToTime {
    
    //判断是否是整数
    //判断是否符合转成时间的规则
    //转换
    
    return self;
}

- (NSString *)dtt_toRegularTime {
    return [NSDate dtt_toRegularTime:self];
}

@end

