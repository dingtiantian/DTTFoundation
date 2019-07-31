//
//  NSScanner+DTTFoundationAdd.h
//  Pods
//
//  Created by dtt on 2017/4/18.
//
//

#import <Foundation/Foundation.h>

@interface NSString (DTTScannerAdd)

/**  是否是整数 */
- (BOOL)dtt_isIntegerValue;

/**  是否是小数 */
- (BOOL)dtt_isFloatValue;

/** 是否是 纯字符串 */
- (BOOL)dtt_isAllString;

/** 是否 全是大写字母 */
- (BOOL)dtt_isAllUpperString;

/** 是否 全是大写字母 */
- (BOOL)dtt_isAllLowerString;

/** 根据对应的 charSet 匹配字符串 */
- (NSString *)dtt_scanStringWithSet:(NSCharacterSet *)charSet;


@end

