//
//  NSDictionary+DTTDictionary.h
//  Pods
//
//  Created by majian on 16/6/6.
//
//

#import <Foundation/Foundation.h>
#import <DTTFoundation/NSObject+DTTObject.h>

NS_ASSUME_NONNULL_BEGIN
/**  是否是空字典 */
extern BOOL DTTIsEmptyDictionary(NSDictionary *dict);

/**  不是空字典 */
extern BOOL DTTIsNotEmptyDictionary(NSDictionary *dict);

extern NSDictionary * const _Nonnull DTTNoNilDictionary(NSDictionary * dict);

@interface NSDictionary (DTTDictionary)

/** 从main bundle中读取plist */
+ (NSDictionary *)dtt_dictionaryWithFileName:(NSString *)fileName;

- (BOOL)dtt_containsKey:(id<NSCopying>)key;

/** 转成curl需要的格式 */
- (NSString *)dtt_tocURLFormat;

/** 将两个字典合并，aDict将覆盖self中已有的值 */
- (NSDictionary *)dtt_appendingDictionary:(NSDictionary *)aDict;
/** 添加一个键值对 */
- (NSDictionary *)dtt_appendingKey:(NSObject<NSCopying> *)aKey value:(id)aValue;

/** 转义字符 */
- (id)dtt_replacingPercentEscapes;

/** 转成jsonstring
 {"key": 123,"key2": 111} ===>
 */
- (NSString*)dtt_toJsonString;

/** 转成json对象 */
- (id)dtt_toJsonObject;

/** 转成可变字典，如果本身是NSDictionary，则执行mutableCopy方法，
 如果是NSMutableDictionary，则直接返回*/
- (NSMutableDictionary*)dtt_toMutable;

@end

@interface NSArray (CURLAddition)
- (NSString *)dtt_tocURLFormat;
/** 转成json对象 */
- (id)dtt_toJsonObject;
@end
@interface NSString (CURLAddition)
- (NSString *)dtt_tocURLFormat;

/** 转成json对象 */
- (id)dtt_toJsonObject;
@end
@interface NSNumber (CURLAddition)
- (NSString *)dtt_tocURLFormat;
/** 转成json对象 */
- (id)dtt_toJsonObject;
@end
@interface NSObject (CURLAddition)
- (NSString *)dtt_tocURLFormat;;
/** 转成json对象 */
- (id)dtt_toJsonObject;
@end
NS_ASSUME_NONNULL_END
