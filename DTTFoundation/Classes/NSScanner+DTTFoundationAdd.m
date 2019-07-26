//
//  NSScanner+DTTFoundationAdd.m
//  Pods
//
//  Created by majian on 2017/4/18.
//
//

#import "NSScanner+DTTFoundationAdd.h"

@implementation NSScanner (DTTFoundationAdd)

@end

@implementation NSString (DTTScannerAdd)

- (BOOL)dtt_isIntegerValue {
    NSScanner * scanner = [NSScanner scannerWithString:self];
    NSInteger scanedValue;
    BOOL scanRes = [scanner scanInteger:&scanedValue];
    return scanRes && scanner.atEnd;
}

- (BOOL)dtt_isFloatValue {
    NSScanner * scanner = [NSScanner scannerWithString:self];
    float scanedValue;
    BOOL scanRes = [scanner scanFloat:&scanedValue];
    return scanRes && scanner.atEnd;
}

/**
 是否是 纯字符串
 */
- (BOOL)dtt_isAllString {
    return [[self dtt_scanStringWithSet:[NSCharacterSet letterCharacterSet]] isEqualToString:self];
}

/**
 是否 全是大写字母
 */
- (BOOL)dtt_isAllUpperString {
    return [[self dtt_scanStringWithSet:[NSCharacterSet uppercaseLetterCharacterSet]] isEqualToString:self];
}

/**
 是否 全是大写字母
 */
- (BOOL)dtt_isAllLowerString {
    return [[self dtt_scanStringWithSet:[NSCharacterSet lowercaseLetterCharacterSet]] isEqualToString:self];
}

- (NSString *)dtt_scanStringWithSet:(NSCharacterSet *)charSet {
    NSScanner * scanner = [NSScanner scannerWithString:self];
    NSString * scannedString = nil;
    [scanner scanCharactersFromSet:charSet intoString:&scannedString];
    return scannedString;
}

@end
