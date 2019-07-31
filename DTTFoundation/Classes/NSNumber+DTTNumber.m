//
//  NSNumber+DTTNumber.m
//  Pods
//
//  Created by dtt on 16/6/6.
//
//

#import "NSNumber+DTTNumber.h"

NSNumber * const DTTNoNilNumber(NSNumber *number) {
    if (DTTIsEmpty(number)) return @(0);
    return number;
}

/** 如果oriValue在left和right区间内(左右都=)，则返回oriValue,否则返回defaultValue*/
NSNumber* const DTTAdjustNumber(NSNumber* oriValue,NSNumber* left,NSNumber* right,NSNumber* defaultValue) {
    if ([oriValue compare:left] == NSOrderedAscending ||
        [oriValue compare:right] == NSOrderedDescending) {
        return defaultValue;
    }

    return oriValue;
}

NSInteger const DTTAdjustInteger(NSInteger oriValue,NSInteger left,NSInteger right,NSInteger defaultValue) {
    if (oriValue < left || oriValue > right) return defaultValue;
    return oriValue;
}

NSUInteger const DTTAdjustUInteger(NSUInteger oriValue,NSUInteger left,NSUInteger right,NSUInteger defaultValue) {
    if (oriValue < left || oriValue > right) return defaultValue;
    return oriValue;
}

CGFloat const DTTAdjustFloat(CGFloat oriValue,CGFloat left,CGFloat right,CGFloat defaultValue) {
    if (oriValue < left || oriValue > right) return defaultValue;
    return oriValue;
}

@implementation NSNumber (DTTNumber)

- (NSString *)dtt_toString {
    
    return self.stringValue;
}

- (NSNumber *)dtt_toNumber {
    return self;
}

- (BOOL)dtt_isEqualToNumber:(NSNumber *)aNumber {
    if ([self isEqual:aNumber]) {
        return YES;
    }
    
    return [[self dtt_toString] isEqualToString:[aNumber dtt_toString]];
}

- (NSString *)dtt_numberByAppendingString:(NSString *)aString {
    return [self.stringValue stringByAppendingString:aString];
}

- (NSString *)dtt_toSimpleNumber {
    NSString * countStr = self.stringValue;
    
    if (NO == [countStr dtt_isIntegerValue] && [countStr dtt_isFloatValue] == NO) {
        return countStr;
    }
    
    //万    10000
    //百万  1000000
    //千万  10000000
    //亿    100000000
    
    if (countStr.length >= 9) {
        return [NSString stringWithFormat:@"%.2f亿",self.longLongValue / 1000000000.0];
    } else if (countStr.length >= 5) {
        return [NSString stringWithFormat:@"%.2f万",self.longLongValue / 10000.0];
    }
    
    return countStr;
}

- (NSString *)dtt_toMoreSimpleNumber{
    NSString * countStr = self.stringValue;
    
    if (NO == [countStr dtt_isIntegerValue] && [countStr dtt_isFloatValue] == NO) {
        return countStr;
    }
    
        //万    10000
        //百万  1000000
        //千万  10000000
        //亿    100000000
    
    if (countStr.length >= 9) {
        return [NSString stringWithFormat:@"%.1f亿",self.longLongValue / 1000000000.0];
    } else if (countStr.length >= 5) {
        return [NSString stringWithFormat:@"%.1fw",self.longLongValue / 10000.0];
    } else if (countStr.length >= 4) {
        return [NSString stringWithFormat:@"%.1fk",self.longLongValue / 1000.0];
    }
    
    return countStr;
}

@end
