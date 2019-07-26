//
//  NSAttributedString+DTTAddition.h
//  DTTFoundation
//
//  Created by admin on 2019/7/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (DTTAddition)
- (NSRange)dtt_allRange;

- (BOOL)dtt_isValidRange:(NSRange)range;
- (BOOL)dtt_isInvalidRange:(NSRange)range;

- (NSDictionary<NSString *,id> *)dtt_attributes;

- (NSMutableAttributedString *)dtt_toMutableAttributedString;
@end

NS_ASSUME_NONNULL_END
