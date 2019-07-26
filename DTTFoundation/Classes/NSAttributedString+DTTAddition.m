//
//  NSAttributedString+DTTAddition.m
//  DTTFoundation
//
//  Created by admin on 2019/7/26.
//

#import "NSAttributedString+DTTAddition.h"

@implementation NSAttributedString (DTTAddition)
- (NSRange)dtt_allRange {
    return NSMakeRange(0, self.length);
}

- (BOOL)dtt_isValidRange:(NSRange)range {
    return NSEqualRanges(NSIntersectionRange(self.dtt_allRange, range), range);
}
- (BOOL)dtt_isInvalidRange:(NSRange)range {
    return ![self dtt_isValidRange:range];
}

- (NSDictionary<NSString *,id> *)dtt_attributes {
        //    return [self attributedSubstringFromRange:self.dtt_allRange];
    return @{};
}

- (NSMutableAttributedString *)dtt_toMutableAttributedString {
    if ([self isKindOfClass:[NSMutableAttributedString class]]) {
        return [self mutableCopy];
    }
    
    return [self mutableCopy];
}

    //测试代码 dtt_isValidRange
/*
 NSAttributedString * str = [[NSAttributedString alloc] initWithString:@"abc"];
 if ([str dtt_isValidRange:NSMakeRange(0, str.dtt_allRange.length + 1)]) {
 NSLog(@"NO");
 }
 if ([str dtt_isValidRange:str.dtt_allRange]) {
 NSLog(@"YES");
 }
 if ([str dtt_isValidRange:NSMakeRange(1, 1)]) {
 NSLog(@"YES");
 }
 
 if ([str dtt_isValidRange:NSMakeRange(1, 4)]) {
 NSLog(@"NO");
 }
 
 if ([str dtt_isValidRange:NSMakeRange(4, 1)]) {
 NSLog(@"NO");
 }
 */


@end
