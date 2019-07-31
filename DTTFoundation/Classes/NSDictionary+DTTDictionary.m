//
//  NSDictionary+DTTDictionary.m
//  Pods
//
//  Created by dtt on 16/6/6.
//
//

#import "NSDictionary+DTTDictionary.h"
#import <NSJSONSerialization+DTTFoundationAdd.h>

@implementation NSDictionary (DTTDictionary)

BOOL DTTIsEmptyDictionary(NSDictionary *dict) {
    if (DTTIsEmpty(dict) || [dict dtt_isNSDictionary] == NO) {
        return YES;
    }
    
    return dict.count <= 0;
}

/*!
 *  不是空字典
 */
BOOL DTTIsNotEmptyDictionary(NSDictionary *dict) {
    return !DTTIsEmptyDictionary(dict);
}

NSDictionary * const DTTNoNilDictionary(NSDictionary * dict) {
    if (DTTIsEmpty(dict)) {
        return @{};
    }
    
    return dict;
}

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"{\n"];
    // for-in all key-value
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];
    
    // range of the last ','
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // remove the last ','
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

- (BOOL)dtt_containsKey:(id<NSCopying>)key {
    return [self.allKeys containsObject:key];
}

- (NSString *)dtt_tocURLFormat {
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"{"];
        // for-in all key-value
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"%@:%@,", [key dtt_tocURLFormat], [obj dtt_tocURLFormat]];
    }];

    [str appendString:@"}"];

        // range of the last ','
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
            // remove the last ','
        [str deleteCharactersInRange:range];
    }

    return str;
}

+ (NSDictionary *)dtt_dictionaryWithFileName:(NSString *)fileName {
    NSURL * filePath = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"plist"];
    return [NSDictionary dictionaryWithContentsOfURL:filePath];
}

/**
 将两个字典合并，aDict将覆盖self中已有的值
 */
- (NSDictionary *)dtt_appendingDictionary:(NSDictionary *)aDict {
    if (DTTIsEmptyDictionary(aDict)) {
        return self;
    }

    if (DTTIsEmptyDictionary(self)) {
        return aDict;
    }

    NSMutableDictionary * tempDict = [[NSMutableDictionary alloc] initWithDictionary:self];
    [aDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        tempDict[key] = obj;
    }];
    return [tempDict copy];
}

/**
 添加一个键值对
 */
- (NSDictionary *)dtt_appendingKey:(NSObject<NSCopying> *)aKey value:(id)aValue {
    if ([aKey conformsToProtocol:@protocol(NSCopying)]) {
        NSMutableDictionary * selfDictM = [self mutableCopy];
        selfDictM[aKey] = aValue;
        return [selfDictM copy];
    }

    return self;
}

/**
 转义字符
 */
- (id)dtt_replacingPercentEscapes {
    NSMutableDictionary * selfM = [NSMutableDictionary new];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        selfM[key] = [obj dtt_replacingPercentEscapes];
    }];
    return [selfM copy];
}

- (NSString *)dtt_toJsonString {
    return [self dtt_tocURLFormat];
}

/** 转成json对象 */
- (id)dtt_toJsonObject {
    NSMutableDictionary* selfRet = [NSMutableDictionary new];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        selfRet[key] = [obj dtt_toJsonObject];
    }];
    return selfRet;
}

/** 转成可变字典，如果本身是NSDictionary，则执行mutableCopy方法，
 如果是NSMutableDictionary，则直接返回*/
- (NSMutableDictionary*)dtt_toMutable {
    if ([self isKindOfClass:[NSMutableDictionary class]]) return self;
    return self.mutableCopy;
}

@end

@implementation NSArray (CURLAddition)

- (NSString *)dtt_tocURLFormat {
    NSMutableString * stringM = [NSMutableString new];
    [stringM appendString:@"["];
    for (id obj in self) {
        [stringM appendFormat:@"%@,",[obj dtt_tocURLFormat]];
    }
        // range of the last ','
    NSRange range = [stringM rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
            // remove the last ','
        [stringM deleteCharactersInRange:range];
    }
    [stringM appendString:@"]"];
    return stringM;
}

/** 转成json对象 */
- (id)dtt_toJsonObject {
    NSMutableArray* selfRet = [NSMutableArray new];
    for (id obj in self) {
        id jsonObj = [obj dtt_toJsonObject];
        if (jsonObj) {
            [selfRet addObject:jsonObj];
        }
    }
    return selfRet;
}

@end

@implementation NSString (CURLAddition)

- (NSString *)dtt_tocURLFormat {
    return [NSString stringWithFormat:@"\"%@\"",self];
}

- (id)dtt_toJsonObject {
    id jsonRet = [NSJSONSerialization dtt_JSONObjectWithString:self error:nil];
    return jsonRet == nil ? self : jsonRet;
}

@end

@implementation NSNumber (CURLAddition)

- (NSString *)dtt_tocURLFormat {
    return self.stringValue;
}

- (id)dtt_toJsonObject {
    return self.stringValue;
}

@end
@implementation NSObject (CURLAddition)

- (NSString *)dtt_tocURLFormat {
    return @"\"\"";
}

- (id)dtt_toJsonObject {
    return @"";
}

@end
