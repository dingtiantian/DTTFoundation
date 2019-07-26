//
//  DTTDateEnum.h
//  Pods
//
//  Created by majian on 16/6/7.
//
//

#ifndef DTTDateEnum_h
#define DTTDateEnum_h

/*!
 *  时间戳格式
 */
typedef NS_ENUM(NSUInteger,DTTDateStyle) {
    /**  年 */
    DTTDateStyleYear = 0,
    /**  月 */
    DTTDateStyleMonth,
    /**  日 */
    DTTDateStyleDay,
    /**  小时 */
    DTTDateStyleHour,
    /**  分钟 */
    DTTDateStyleMinute,
    /**  秒 */
    DTTDateStyleSecond,
    /**  毫秒 */
    DTTDateStyleMSec
};

/**  时间日期格式 */
typedef NS_ENUM(NSUInteger,DTTDateFormatStyle) {
    /**  2015-10-08 12:30:40 */
     DTTDateFormatStyleNormal = 0,
    /**  20151008123040 */
     DTTDateFormatStyleNoSegment,
    /**  2015/10/08 12:30:40 */
     DTTDateFormatStyleDiagonal
};

/**  日期通俗表示类型 */
typedef NS_ENUM(NSUInteger,DTTDateDayStyle) {
    /**  不是前天、昨天、今天、明天、后天的情况 */
    DTTDateDayStyleNoKnown,
    /**  前天 */
    DTTDateDayStyleBeforeYesterday,
    /**  昨天 */
    DTTDateDayStyleYesterday,
    /**  今天 */
    DTTDateDayStyleToday = 0,
    /**  明天 */
    DTTDateDayStyleTomorrow,
    /**  后天 */
    DTTDateDayStyleAfterTomorrow
};

/**  秒级的长度 */
extern unsigned int dtt_kTimeStampSecondLength;

/**  毫秒级的长度 */
extern unsigned int dtt_kTimeStampMilliSecondLength;

/**  是否是正常的时间戳（字符串) */
extern BOOL dtt_IsNormalTimeStampString(NSString * aTimeStamp);

/**  是否是正常的时间戳(NSNumber型) */
extern BOOL dtt_IsNormalTimeStampNumber(NSNumber * aTimeStamp);
#endif /* DTTDateEnum_h */







