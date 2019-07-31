//
//  NSData+DTTFoundationAdd.h
//  Pods
//
//  Created by dtt on 2017/4/11.
//
//

#import <Foundation/Foundation.h>
#import <DTTFoundation/NSString+DTTString.h>

@interface NSData (DTTFoundationAdd)

/** 字符串 转 data */
+ (NSData *)dtt_dataWithBytesString:(NSString *)bytesString;

/** data 转 字符串 */
- (NSString *)dtt_bytesString;

@end
