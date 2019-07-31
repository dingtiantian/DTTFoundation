//
//  NSObject+DTTObject.h
//  Pods
//
//  Created by dtt on 16/6/6.
//
//

#import <Foundation/Foundation.h>
#import <DTTFoundation/NSException+DTTException.h>

NS_ASSUME_NONNULL_BEGIN
/**  是否是空对象 */
extern BOOL DTTIsEmpty(id obj);

/**  不是空对象*/
extern BOOL DTTIsNotEmpty(id obj);

extern NSString * _Nonnull DTTAvoidCrashExceptionNotification;
@interface NSObject (DTTObject)

+ (void)exchangeClassMethod:(Class)aClass method:(SEL)oriMethod toMethod:(SEL)newMethod;
+ (void)exchangeClassMethod:(SEL)oriMethod toMethod:(SEL)newMethod;

+ (void)exchangeInstanceMethod:(Class)aClass method:(SEL)oriMethod toMethod:(SEL)newMethod;
+ (void)exchangeInstanceMethod:(SEL)oriMethod toMethod:(SEL)newMethod;

+ (void)notiException:(NSException *)exception appendingInfo:(NSString * _Nullable)info;
- (void)notiException:(NSException *)exception appendingInfo:(NSString * _Nullable)info;

#pragma mark - 类型判断
- (BOOL)dtt_isNSDictionary;
- (BOOL)dtt_isNSArray;
- (BOOL)dtt_isNSString;
- (BOOL)dtt_isNSNumber;
- (BOOL)dtt_isNSNumberBool;
- (BOOL)dtt_isNSDate;
- (BOOL)dtt_isNSNull;
- (BOOL)dtt_isUIViewController;
- (BOOL)dtt_isUINavigationController;
- (BOOL)dtt_isNSError;

#pragma mark - 转换
- (NSString *)dtt_toString;
- (NSNumber *)dtt_toNumber;
/** 转义字符 */
- (id)dtt_replacingPercentEscapes;

#pragma mark - 系统判断

/** iOS11*/
- (BOOL)dtt_iOS11Available;

/** iOS10*/
- (BOOL)dtt_iOS10Available;

@end
NS_ASSUME_NONNULL_END
