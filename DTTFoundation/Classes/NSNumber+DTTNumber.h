//
//  NSNumber+DTTNumber.h
//  Pods
//
//  Created by majian on 16/6/6.
//
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
#import <DTTFoundation/NSScanner+DTTFoundationAdd.h>
#import <DTTFoundation/NSObject+DTTObject.h>

NS_ASSUME_NONNULL_BEGIN
extern NSNumber * const DTTNoNilNumber(NSNumber *number);

/** 如果oriValue在left和right区间内(左右都=)，则返回oriValue,否则返回defaultValue*/
extern NSNumber* const DTTAdjustNumber(NSNumber* oriValue,NSNumber* left,NSNumber* right,NSNumber* defaultValue);
extern NSInteger const DTTAdjustInteger(NSInteger oriValue,NSInteger left,NSInteger right,NSInteger defaultValue);
extern NSUInteger const DTTAdjustUInteger(NSUInteger oriValue,NSUInteger left,NSUInteger right,NSUInteger defaultValue);
extern CGFloat const DTTAdjustFloat(CGFloat oriValue,CGFloat left,CGFloat right,CGFloat defaultValue);

@interface NSNumber (DTTNumber)

/**
 *  判断两个number是否相等
 *  为了解决原生方法isEqualToNumber:传入参数为nil时崩溃的问题
 *  错误信息：-[__NSCFNumber compare:]: nil argument
 */
- (BOOL)dtt_isEqualToNumber:(NSNumber *)aNumber;

- (NSString *)dtt_numberByAppendingString:(NSString *)aString;

- (NSNumber *)dtt_toNumber;
- (NSString *)dtt_toString;

/**
 转换后的格式为
 x.xx 万
 x.xx 亿
 */
- (NSString *)dtt_toSimpleNumber;

/**
 转换后的格式为
 x.x 千
 x.x 万
 x.x 亿
 */
- (NSString *)dtt_toMoreSimpleNumber;


@end
NS_ASSUME_NONNULL_END
