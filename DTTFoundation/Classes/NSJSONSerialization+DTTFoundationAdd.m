//
//  NSJSONSerialization+DTTFoundationAdd.m
//  Pods
//
//  Created by dtt on 2017/4/8.
//
//

#import "NSJSONSerialization+DTTFoundationAdd.h"

@implementation NSJSONSerialization (DTTFoundationAdd)

+ (id)dtt_JSONObjectWithString:(NSString *)string error:(NSError **)error {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self JSONObjectWithData:data options:NSJSONReadingMutableContainers error:error];
}

+ (NSString *)dtt_stringWithJSONObject:(id)obj error:(NSError **)error {
    return [NSString dtt_stringWithUTF8Data:[self dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:error]];
}

+ (NSDictionary *)dtt_dictionaryWithString:(NSString *)string error:(NSError **)error {
    id obj = [self dtt_JSONObjectWithString:string error:error];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }
    return nil;
}
+ (NSArray *)dtt_arrayWithString:(NSString *)string error:(NSError **)error {
    id obj = [self dtt_JSONObjectWithString:string error:error];
    if ([obj isKindOfClass:[NSArray class]]) {
        return obj;
    }
    return nil;
}


@end
