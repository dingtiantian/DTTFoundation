//
//  NSDate+DTTTimeStamp.h
//  时间戳相关处理
//
//  Created by dtt on 16/6/7.
//
//

#import <Foundation/Foundation.h>
#import <DTTFoundation/DTTDateEnum.h>
#import <DTTFoundation/NSDate+DTTDate.h>
#import <DTTFoundation/NSString+DTTString.h>
#import <DTTFoundation/NSArray+DTTArray.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSDate (DTTTimeStamp)

//根据时间戳取 年 月 日 小时 分钟
//计算时间戳之间差值 ok
//计算当前时间和传入的时间戳的差值
//将时间戳转换成NSDate
//根据传入的时间戳判断是否是今天 昨天 明天

@property (nonatomic,assign,readonly) NSInteger dtt_year;
@property (nonatomic,assign,readonly) NSInteger dtt_month;
@property (nonatomic,assign,readonly) NSInteger dtt_day;
@property (nonatomic,assign,readonly) NSInteger dtt_hour;
@property (nonatomic,assign,readonly) NSInteger dtt_minute;
@property (nonatomic,assign,readonly) NSInteger dtt_second;
@property (nonatomic,assign,readonly) NSInteger dtt_dayOfWeek; /* 一周中的第几天，周日为第一天*/
@property (nonatomic,assign,readonly) NSInteger dtt_dayOfWeekChinese; //周一为第一天
@property (nonatomic,copy,readonly) NSString * dtt_dayOfWeekZhou; /* 星期一、星期二... */
@property (nonatomic,copy,readonly) NSString * dtt_dayOfWeekXingQi;/* 周一、周二... */
@property (nonatomic,assign,readonly) NSInteger dtt_weekOfYear; /* 一年中的第几周*/
@property (nonatomic,assign,readonly) NSInteger dtt_weekOfMonth; /** 一月中第几周*/
@property (nonatomic,assign,readonly) NSInteger dtt_weekOfMonthChinese; 

/**  将时间戳转为NSDate */
+ (NSDate *)dtt_dateWithTimeStamp:(NSString *)timeStamp;

/**  是否是今天 */
+ (BOOL)dtt_isTodayWithTimeStamp:(NSString *)timeStamp;
+ (BOOL)dtt_isTodayWithDate:(NSDate *)date;
- (BOOL)dtt_isToday;

/**  是否是昨天 */
+ (BOOL)dtt_isYesterdayWithTimeStamp:(NSString *)timeStamp;
+ (BOOL)dtt_isYesterdayWithDate:(NSDate *)date;
- (BOOL)dtt_isYesterday;

/**  是否是明天 */
+ (BOOL)dtt_isTomorrowWithTimeStamp:(NSString *)timeStamp;
+ (BOOL)dtt_isTomorrowWithDate:(NSDate *)date;
- (BOOL)dtt_isTomorrow;

/**  是否在同一个星期 */
+ (BOOL)dtt_isDateInWeekendWithTimeStamp:(NSString *)timeStamp;
+ (BOOL)dtt_isDateInWeekendWithTimeStamp:(NSString *)aTimeStamp toTimeStamp:(NSString *)bTimeStamp;

/**  是否是同一天 */
+ (BOOL)dtt_isSameDayWithTimeStamp:(NSString *)aTimeStamp toDay:(NSString *)bTimeStamp;
+ (BOOL)dtt_isSameDayWithDate:(NSDate *)aDate toDay:(NSDate *)bDate;
- (BOOL)dtt_isSameDayWithDate:(NSDate *)aDate;

/*!
 *  根据传入的时间戳计算时间间隔,用现在的时间减去传入的时间
 *  discussion : 如果传入的是10位，则返回间隔"秒",如果传入的是13位，则返回间隔是“微秒”
 */
+ (long long)dtt_timeIntervalSinceTimeStamp:(NSString *)aTimeStamp;
/**  计算两个时间戳的差值: aTimeStamp - bTimeStamp */
+ (long long)dtt_timeIntervalBetweenTimeStamp:(NSString *)aTimeStamp andTimeStamp:(NSString *)bTimeStamp;

@end

/**  出现错误时，返回该值 */
extern NSUInteger dtt_kDefaultReturnTimeInterval;
NS_ASSUME_NONNULL_END
