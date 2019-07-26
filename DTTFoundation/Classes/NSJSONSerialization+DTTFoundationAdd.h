//
//  NSJSONSerialization+DTTFoundationAdd.h
//  Pods
//
//  Created by majian on 2017/4/8.
//
//

#import <Foundation/Foundation.h>
#import <DTTFoundation/NSString+DTTString.h>

@interface NSJSONSerialization (DTTFoundationAdd)
+ (id)dtt_JSONObjectWithString:(NSString *)string
                     error:(NSError **)error;
+ (NSString *)dtt_stringWithJSONObject:(id)obj
                             error:(NSError **)error;

+ (NSDictionary *)dtt_dictionaryWithString:(NSString *)string error:(NSError **)error;
+ (NSArray *)dtt_arrayWithString:(NSString *)string error:(NSError **)error;

@end
