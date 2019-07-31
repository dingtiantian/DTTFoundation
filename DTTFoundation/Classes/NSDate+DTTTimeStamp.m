//
//  NSDate+DTTTimeStamp.m
//  Pods
//
//  Created by dtt on 16/6/7.
//
//

#import "NSDate+DTTTimeStamp.h"

NSUInteger dtt_kDefaultReturnTimeInterval = NSUIntegerMax;

static NSInteger secondsOfOneDay = 24 * 60 * 60; //一天的"秒"总数
//static NSInteger milliSecondsOfOneDay = 24 * 60 * 60 * 1000; //一天的"毫秒"总数

/*!
 *  秒级的长度
 */
unsigned int dtt_kTimeStampSecondLength = 10;

/*!
 *  毫秒级的长度
 */
unsigned int dtt_kTimeStampMilliSecondLength = 13;

/*!
 *  转成字符串型的时间戳
 */
NSString * dtt_ConvertToStringTimeStamp(id aTimeStamp) {
    
    NSString * timeStamp = aTimeStamp;
    if ([aTimeStamp isKindOfClass:[NSNumber class]]) {
        
        timeStamp = [aTimeStamp stringValue];
    }
    
    if ([timeStamp isKindOfClass:[NSString class]]) {
        if ([timeStamp containsString:@"."]) {
            timeStamp = [timeStamp componentsSeparatedByString:@"."].firstObject;
        }
        
        return timeStamp;
    }
    
    //打印错误提示日志
    
    return @"";
}

/*!
 *  是否是正常的时间戳（字符串)
 */
BOOL dtt_IsNormalTimeStampString(NSString * aTimeStamp) {
    NSString * timeStamp = dtt_ConvertToStringTimeStamp(aTimeStamp);
    
    return (timeStamp.length == dtt_kTimeStampSecondLength ||
            timeStamp.length == dtt_kTimeStampMilliSecondLength);
}

/*!
 *  是否是正常的时间戳(NSNumber型)
 */
BOOL dtt_IsNormalTimeStampNumber(NSNumber * aTimeStamp) {
    NSString * timeStamp = dtt_ConvertToStringTimeStamp(aTimeStamp);
    
    if (timeStamp.length <= 0) {
        return NO;
    }
    
    return dtt_IsNormalTimeStampString(timeStamp);
}

@implementation NSDate (DTTTimeStamp)

- (NSInteger)dtt_year {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:self];
}

- (NSInteger)dtt_month {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMonth fromDate:self];
}

- (NSInteger)dtt_day {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self];
}

- (NSInteger)dtt_hour {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitHour fromDate:self];
}

- (NSInteger)dtt_minute {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitMinute fromDate:self];
}

- (NSInteger)dtt_second {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitSecond fromDate:self];
}

- (NSInteger)dtt_dayOfWeek {
    return [[NSCalendar currentCalendar] component:NSCalendarUnitWeekday fromDate:self];
}

- (NSInteger)dtt_dayOfWeekChinese {
//    return (self.dtt_dayOfWeek - 1 + 7) % 7;
    NSUInteger index = self.dtt_dayOfWeek;
    if (index == 1) {
        return 7;
    }

    return index - 1;
}

- (NSInteger)dtt_weekOfMonth {
//    return [self dtt_weekOfMonthChinese];
//    return [self dtt_weekOfMonthChinese];
    return [[NSCalendar currentCalendar] component:NSCalendarUnitWeekOfMonth fromDate:self];
}

- (NSInteger)dtt_weekOfMonthChinese {
//    NSDate * date = [self dateByAddingTimeInterval:dtt_oneDayToSeconds()];
//    NSInteger weekOfMonth = [[NSCalendar currentCalendar] component:NSCalendarUnitWeekOfMonth fromDate:date];
//    return weekOfMonth;
//    [[NSCalendar currentCalendar] setFirstWeekday:5];
    return [[NSCalendar currentCalendar] component:NSCalendarUnitWeekOfMonth fromDate:self];
}

//- (NSInteger)dtt_dayOfMonth {
//    
//}

static NSArray * dayOfWeekZhouArray;
__attribute__((constructor)) static void initDayOfWeekZhouArray() {
    dayOfWeekZhouArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
}
- (NSString *)dtt_dayOfWeekZhou {
    NSUInteger dayOfWeek = self.dtt_dayOfWeek;
    if ([dayOfWeekZhouArray dtt_isValidIndex:dayOfWeek - 1]) {
        return dayOfWeekZhouArray[dayOfWeek - 1];
    }
    
    return @"未知";
}

static NSArray * dayOfWeekXingQiArray;
__attribute__((constructor)) static void initDayOfWeekXingQiArray() {
    dayOfWeekXingQiArray = @[@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
}
- (NSString *)dtt_dayOfWeekXingQi {
    NSUInteger dayOfWeek = self.dtt_dayOfWeek;
    if ([dayOfWeekXingQiArray dtt_isValidIndex:dayOfWeek - 1]) {
        return dayOfWeekXingQiArray[dayOfWeek - 1];
    }
    
    return @"未知";
}

- (NSInteger)dtt_weekOfYear {
    NSUInteger weekOfYear = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitYear forDate:self];
//    NSUInteger weekOfYear = [[NSCalendar currentCalendar] component:NSCalendarUnitWeekOfYear fromDate:self];
    return weekOfYear;
}

+ (NSDate *)dtt_dateWithTimeStamp:(NSString *)timeStamp {
    
    if (DTTIsEmptyString(timeStamp)) {
        return nil;
    }
    
    NSString * aTimeStamp = timeStamp;
    if (aTimeStamp.length != 13 && aTimeStamp.length != 10) {
        //可能包含小数
        if ([aTimeStamp containsString:DTTDotString()]) {
            NSArray * timeStampArrayI = [aTimeStamp componentsSeparatedByString:DTTDotString()];
            
            if (timeStampArrayI.count >= 1) {
                aTimeStamp = timeStampArrayI.firstObject;
            } else {
                aTimeStamp = [NSString emptyString];
            }
        }
    }
    
    if (aTimeStamp.length == 13) {
        aTimeStamp = [aTimeStamp dtt_removeLastCharacterWithCount:3];
    }
    
    //如果不加长度和是否全是数字的判断，返回的NSDate会非常奇怪
    //长度不为10，则时间为任意一个时间
    //如果不全是数字，则时间为1970年
    if (aTimeStamp.length != 10 || [aTimeStamp dtt_isIntegerValue] == NO) {
        return nil;
    }
    
    return [NSDate dateWithTimeIntervalSince1970:aTimeStamp.longLongValue];
}

#pragma mark - 今天
+ (BOOL)dtt_isTodayWithTimeStamp:(NSString *)timeStamp {
    return [self dtt_isTodayWithDate:[NSDate dtt_dateWithTimeStamp:timeStamp]];
}

+ (BOOL)dtt_isTodayWithDate:(NSDate *)aDate {
    return [[NSDate dtt_date] dtt_isSameDayWithDate:aDate];
}

- (BOOL)dtt_isToday {
    return [[self class] dtt_isTodayWithDate:self];
}

#pragma mark - 昨天
+ (BOOL)dtt_isYesterdayWithTimeStamp:(NSString *)timeStamp {
    return [self dtt_isYesterdayWithDate:[NSDate dtt_dateWithTimeStamp:timeStamp]];
}

+ (BOOL)dtt_isYesterdayWithDate:(NSDate *)date {
    return [self dtt_isTodayWithDate:[date dateByAddingTimeInterval:secondsOfOneDay]];
}

- (BOOL)dtt_isYesterday {
    return [[self class] dtt_isYesterdayWithDate:self];
}

#pragma mark - 明天
+ (BOOL)dtt_isTomorrowWithTimeStamp:(NSString *)timeStamp {
    return [self dtt_isTomorrowWithDate:[NSDate dtt_dateWithTimeStamp:timeStamp]];
}

+ (BOOL)dtt_isTomorrowWithDate:(NSDate *)date {
    return [self dtt_isTodayWithDate:[date dateByAddingTimeInterval:-secondsOfOneDay]];
}

- (BOOL)dtt_isTomorrow {
    return [[self class] dtt_isTomorrowWithDate:self];
}

#pragma mark - 同一个星期
+ (BOOL)dtt_isDateInWeekendWithTimeStamp:(NSString *)timeStamp {
    return [self dtt_isDateInWeekendWithTimeStamp:timeStamp toTimeStamp:(@([NSDate dtt_date].timeIntervalSince1970)).stringValue];
}

+ (BOOL)dtt_isDateInWeekendWithTimeStamp:(NSString *)aTimeStamp toTimeStamp:(NSString *)bTimeStamp {
    NSDate * aDate = [NSDate dtt_dateWithTimeStamp:aTimeStamp];
    NSDate * bDate = [NSDate dtt_dateWithTimeStamp:bTimeStamp];
    return (aDate.dtt_year == bDate.dtt_year &&
            aDate.dtt_weekOfYear == bDate.dtt_weekOfYear);
}

#pragma mark - 同一天
+ (BOOL)dtt_isSameDayWithTimeStamp:(NSString *)aTimeStamp toDay:(NSString *)bTimeStamp {
    return [[NSDate dtt_dateWithTimeStamp:aTimeStamp] dtt_isSameDayWithDate:[NSDate dtt_dateWithTimeStamp:bTimeStamp]];
}

- (BOOL)dtt_isSameDayWithDate:(NSDate *)aDate {
    return [NSDate dtt_isSameDayWithDate:aDate toDay:self];
}

+ (BOOL)dtt_isSameDayWithDate:(NSDate *)aDate toDay:(NSDate *)bDate {
    return (aDate.dtt_year == bDate.dtt_year &&
            aDate.dtt_month == bDate.dtt_month &&
            aDate.dtt_day == bDate.dtt_day);
}

#pragma mark - 时间间隔
/*!
 *  根据传入的时间戳计算时间间隔,用现在的时间减去传入的时间
 *  discussion : 如果传入的是10位，则返回间隔"秒",如果传入的是13位，则返回间隔是“微秒”
 */
+ (long long)dtt_timeIntervalSinceTimeStamp:(NSString *)aTimeStamp {
    
    NSTimeInterval nowTimeStamp = [NSDate dtt_date].timeIntervalSince1970;
    return [self dtt_timeIntervalBetweenTimeStamp:@(nowTimeStamp).stringValue andTimeStamp:aTimeStamp];
}

/*!
 *  计算两个时间戳的差值: aTimeStamp - bTimeStamp
 */
+ (long long)dtt_timeIntervalBetweenTimeStamp:(NSString *)aTimeStamp
                                 andTimeStamp:(NSString *)bTimeStamp {
    
    NSString * timeStampA = dtt_ConvertToStringTimeStamp(aTimeStamp);
    NSString * timeStampB = dtt_ConvertToStringTimeStamp(bTimeStamp);
    
    if (timeStampA.length == dtt_kTimeStampMilliSecondLength) {
        timeStampA = [timeStampA dtt_removeLastCharacterWithCount:3];
    }
    
    if (timeStampB.length == dtt_kTimeStampMilliSecondLength) {
        timeStampB = [timeStampB dtt_removeLastCharacterWithCount:3];
    }
    
    if (timeStampA.length != dtt_kTimeStampSecondLength ||
        timeStampB.length != dtt_kTimeStampSecondLength) {
        
        return dtt_kDefaultReturnTimeInterval;
    }
    
    return timeStampA.longLongValue - timeStampB.longLongValue;
}

@end





