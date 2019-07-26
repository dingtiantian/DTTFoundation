//
//  NSMutableAttributedString+DTTAddition.h
//  DTTFoundation
//
//  Created by admin on 2019/7/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import <DTTFoundation/NSAttributedString+DTTAddition.h>
#import <DTTFoundation/NSString+DTTString.h>
#import <DTTFoundation/NSObject+DTTObject.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (DTTAddition)
#pragma mark - Property
@property (nonatomic,strong) UIFont* dtt_font;
@property (nonatomic,strong) UIColor* dtt_color;
@property (nonatomic,strong) UIColor* dtt_backgroundColor;

@property (nonatomic, strong, readwrite, nullable) NSParagraphStyle *dtt_paragraphStyle;
@property (nonatomic, assign, readwrite) CGFloat dtt_lineSpacing;
@property (nonatomic, assign, readwrite) CGFloat dtt_paragraphSpacing;
@property (nonatomic, assign, readwrite) CGFloat dtt_paragraphSpacingBefore;
@property (nonatomic, assign, readwrite) NSTextAlignment dtt_alignment;
@property (nonatomic, assign, readwrite) CGFloat dtt_firstLineHeadIndent;
@property (nonatomic, assign, readwrite) CGFloat dtt_headIndent;
@property (nonatomic, assign, readwrite) CGFloat dtt_tailIndent;
@property (nonatomic, assign, readwrite) NSLineBreakMode dtt_lineBreakMode;
@property (nonatomic, assign, readwrite) CGFloat dtt_minimumLineHeight;
@property (nonatomic, assign, readwrite) CGFloat dtt_maximumLineHeight;
@property (nonatomic, assign, readwrite) NSWritingDirection dtt_baseWritingDirection;
@property (nonatomic, assign, readwrite) CGFloat dtt_lineHeightMultiple;
@property (nonatomic, assign, readwrite) float dtt_hyphenationFactor;
@property (nonatomic, assign, readwrite) CGFloat dtt_defaultTabInterval;

@property (nonatomic, assign, readwrite) CGFloat dtt_characterSpacing;
@property (nonatomic, assign, readwrite) NSUnderlineStyle dtt_lineThroughStyle;
@property (nonatomic, strong, readwrite, nullable) UIColor *dtt_lineThroughColor;
@property (nonatomic, assign, readwrite) NSInteger dtt_characterLigature;
@property (nonatomic, assign, readwrite) NSUnderlineStyle dtt_underLineStyle;
@property (nonatomic, strong, readwrite, nullable) UIColor *dtt_underLineColor;
@property (nonatomic, assign, readwrite) CGFloat dtt_strokeWidth;
@property (nonatomic, strong, readwrite, nullable) UIColor *dtt_strokeColor;
@property (nonatomic, strong, readwrite, nullable) NSShadow *dtt_shadow;
@property (nonatomic, strong, readwrite, nullable) id dtt_link;
@property (nonatomic, assign, readwrite) CGFloat dtt_baseline;
@property (nonatomic, assign, readwrite) CGFloat dtt_obliqueness;
@property (nonatomic, assign, readwrite) CGFloat dtt_expansion;

#pragma mark - Get
- (UIFont*)dtt_fontAtIndex:(NSUInteger)index effectiveRange:(nullable NSRangePointer)range;
- (UIColor*)dtt_colorAtIndex:(NSUInteger)index effectiveRange:(nullable NSRangePointer)range;
- (UIColor*)dtt_backgroundColorAtIndex:(NSUInteger)index effectiveRange:(nullable NSRangePointer)range;

#pragma mark - Add
- (void)dtt_addAttribute:(NSString *)name value:(id)value range:(NSRange)range;

- (void)dtt_addExpansion:(CGFloat)expansion range:(NSRange)range;

- (void)dtt_addForeColorAttributeWithValue:(UIColor *)color;
- (void)dtt_addForeColorAttributeWithValue:(UIColor *)color range:(NSRange)range;

- (void)dtt_addFontAttributeWithValue:(UIFont *)font;
- (void)dtt_addFontAttributeWithValue:(UIFont *)font range:(NSRange)range;

- (void)dtt_addUnderlineStyleAttributeWithValue:(CTUnderlineStyle)style
                                       modifier:(CTUnderlineStyleModifiers)modifier;
- (void)dtt_addUnderlineStyleAttributeWithValue:(CTUnderlineStyle)style
                                       modifier:(CTUnderlineStyleModifiers)modifier
                                          range:(NSRange)range;

- (void)dtt_addAttributeStrokeColor:(UIColor *)strokeColor strokeWidth:(unichar)strokeWidth;

- (void)dtt_addAttributeCharacterSpacing:(unichar)characterSpacing;
- (void)dtt_addAttributeCharacterSpacing:(unichar)characterSpacing range:(NSRange)rang;


- (void)dtt_addAttributeAlignmentStyle:(CTTextAlignment)textAlignment
                        lineSpaceStyle:(CGFloat)linesSpacing
                   paragraphSpaceStyle:(CGFloat)paragraphSpacing
                        lineBreakStyle:(CTLineBreakMode)lineBreakMode;
- (void)dtt_addAttributeAlignmentStyle:(CTTextAlignment)textAlignment
                        lineSpaceStyle:(CGFloat)linesSpacing
                   paragraphSpaceStyle:(CGFloat)paragraphSpacing
                        lineBreakStyle:(CTLineBreakMode)lineBreakMode
                                  rang:(NSRange)range;

- (void)dtt_addAttributeAlignmentStyle2:(NSTextAlignment)textAlignment
                         lineSpaceStyle:(CGFloat)linesSpacing
                    paragraphSpaceStyle:(CGFloat)paragraphSpacing
                         lineBreakStyle:(NSLineBreakMode)lineBreakMode;
- (void)dtt_addAttributeAlignmentStyle2:(NSTextAlignment)textAlignment
                         lineSpaceStyle:(CGFloat)linesSpacing
                    paragraphSpaceStyle:(CGFloat)paragraphSpacing
                         lineBreakStyle:(NSLineBreakMode)lineBreakMode
                                   rang:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
