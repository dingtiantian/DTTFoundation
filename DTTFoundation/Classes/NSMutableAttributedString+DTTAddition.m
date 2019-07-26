//
//  NSMutableAttributedString+DTTAddition.m
//  DTTFoundation
//
//  Created by admin on 2019/7/26.
//

#import "NSMutableAttributedString+DTTAddition.h"
#define dtt_attributeFilterRange(range) \
if([self dtt_isInvalidRange:range]) return;

#define dtt_setParagraphStyleProperty(_property_,_range_) \
[self enumerateAttribute:NSParagraphStyleAttributeName inRange:_range_ options:kNilOptions usingBlock:^(NSParagraphStyle *value, NSRange subRange, BOOL *stop) {\
NSMutableParagraphStyle *style = nil;\
if (!value) {\
style = [[NSMutableParagraphStyle alloc]init];\
if (style._property_ == _property_) {\
return ;\
}\
} else {\
if (value._property_ == _property_) {\
return ;\
}\
if ([value isKindOfClass:[NSMutableParagraphStyle class]]) {\
style = (NSMutableParagraphStyle *)value;\
}else {\
style = [value mutableCopy];\
}\
}\
style._property_ = _property_;\
[self dtt_addParagraphStyle:style range:subRange];\
}];\


@implementation NSMutableAttributedString (DTTAddition)

- (void)dtt_addAttribute:(NSString *)name value:(id)value range:(NSRange)range {
    if ([self dtt_isInvalidRange:range]) return;
    if (DTTIsEmptyString(name)) return;
    
    if (DTTIsEmpty(value)) {
        [self removeAttribute:name range:range];
    } else {
        [self addAttribute:name value:value range:range];
    }
}

#pragma mark - Get
- (UIFont *)dtt_font {
    return [self dtt_fontAtIndex:0 effectiveRange:NULL];
}

- (void)setdtt_font:(UIFont *)dtt_font {
    [self dtt_addAttribute:NSFontAttributeName value:dtt_font range:self.dtt_allRange];
}

- (UIFont*)dtt_fontAtIndex:(NSUInteger)index effectiveRange:(nullable NSRangePointer)range {
    return [self attribute:NSFontAttributeName atIndex:index effectiveRange:range];
}

- (UIColor *)dtt_color {
    return [self dtt_colorAtIndex:0 effectiveRange:NULL];
}

- (void)setdtt_color:(UIColor *)dtt_color {
    [self dtt_addAttribute:NSForegroundColorAttributeName value:dtt_color range:self.dtt_allRange];
}

- (UIColor*)dtt_colorAtIndex:(NSUInteger)index effectiveRange:(nullable NSRangePointer)range {
    return [self attribute:NSForegroundColorAttributeName atIndex:index effectiveRange:range];
}

- (UIColor *)dtt_backgroundColor {
    return [self dtt_backgroundColorAtIndex:0 effectiveRange:NULL];
}

- (UIColor *)dtt_backgroundColorAtIndex:(NSUInteger)index effectiveRange:(NSRangePointer)range {
    return [self attribute:NSBackgroundColorAttributeName atIndex:index effectiveRange:range];
}

- (void)setdtt_paragraphStyle:(NSParagraphStyle *)paragraphStyle {
    [self dtt_addParagraphStyle:paragraphStyle range:NSMakeRange(0, self.length)];
}

- (void)dtt_addParagraphStyle:(NSParagraphStyle *)paragraphStyle range:(NSRange)range {
    [self dtt_addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}

- (void)setdtt_lineSpacing:(CGFloat)lineSpacing {
    [self dtt_addLineSpacing:lineSpacing range:NSMakeRange(0, self.length)];
}
- (void)dtt_addLineSpacing:(CGFloat)lineSpacing range:(NSRange)range {
    dtt_setParagraphStyleProperty(lineSpacing,range);
}

- (void)setdtt_paragraphSpacing:(CGFloat)paragraphSpacing {
    [self dtt_addParagraphSpacing:paragraphSpacing range:NSMakeRange(0, self.length)];
}
- (void)dtt_addParagraphSpacing:(CGFloat)paragraphSpacing range:(NSRange)range {
    dtt_setParagraphStyleProperty(paragraphSpacing,range);
}

- (void)setdtt_paragraphSpacingBefore:(CGFloat)paragraphSpacingBefore {
    [self dtt_addParagraphSpacing:paragraphSpacingBefore range:NSMakeRange(0, self.length)];
}
- (void)dtt_addParagraphSpacingBefore:(CGFloat)paragraphSpacingBefore range:(NSRange)range {
    dtt_setParagraphStyleProperty(paragraphSpacingBefore,range);
}

- (void)setdtt_alignment:(NSTextAlignment)alignment {
    [self dtt_addAlignment:alignment range:NSMakeRange(0, self.length)];
}
- (void)dtt_addAlignment:(NSTextAlignment)alignment range:(NSRange)range {
    dtt_setParagraphStyleProperty(alignment,range);
}

- (void)setdtt_firstLineHeadIndent:(CGFloat)firstLineHeadIndent {
    [self dtt_addFirstLineHeadIndent:firstLineHeadIndent range:NSMakeRange(0, self.length)];
}
- (void)dtt_addFirstLineHeadIndent:(CGFloat)firstLineHeadIndent range:(NSRange)range {
    dtt_setParagraphStyleProperty(firstLineHeadIndent,range);
}

- (void)setdtt_headIndent:(CGFloat)headIndent {
    [self dtt_addHeadIndent:headIndent range:NSMakeRange(0, self.length)];
}
- (void)dtt_addHeadIndent:(CGFloat)headIndent range:(NSRange)range {
    dtt_setParagraphStyleProperty(headIndent,range);
}

- (void)setdtt_tailIndent:(CGFloat)tailIndent {
    [self dtt_addTailIndent:tailIndent range:NSMakeRange(0, self.length)];
}
- (void)dtt_addTailIndent:(CGFloat)tailIndent range:(NSRange)range {
    dtt_setParagraphStyleProperty(tailIndent,range);
}

- (void)setdtt_lineBreakMode:(NSLineBreakMode)lineBreakMode {
    [self dtt_addLineBreakMode:lineBreakMode range:NSMakeRange(0, self.length)];
}
- (void)dtt_addLineBreakMode:(NSLineBreakMode)lineBreakMode range:(NSRange)range {
    dtt_setParagraphStyleProperty(lineBreakMode,range);
}

- (void)setdtt_minimumLineHeight:(CGFloat)minimumLineHeight {
    [self dtt_addMinimumLineHeight:minimumLineHeight range:NSMakeRange(0, self.length)];
}
- (void)dtt_addMinimumLineHeight:(CGFloat)minimumLineHeight range:(NSRange)range {
    dtt_setParagraphStyleProperty(minimumLineHeight,range);
}

- (void)setdtt_maximumLineHeight:(CGFloat)maximumLineHeight {
    [self dtt_addMinimumLineHeight:maximumLineHeight range:NSMakeRange(0, self.length)];
}
- (void)dtt_addMaximumLineHeight:(CGFloat)maximumLineHeight range:(NSRange)range {
    dtt_setParagraphStyleProperty(maximumLineHeight,range);
}

- (void)setdtt_baseWritingDirection:(NSWritingDirection)baseWritingDirection {
    [self dtt_addBaseWritingDirection:baseWritingDirection range:NSMakeRange(0, self.length)];
}
- (void)dtt_addBaseWritingDirection:(NSWritingDirection)baseWritingDirection range:(NSRange)range {
    dtt_setParagraphStyleProperty(baseWritingDirection,range);
}

- (void)setdtt_lineHeightMultiple:(CGFloat)lineHeightMultiple {
    [self dtt_addLineHeightMultiple:lineHeightMultiple range:NSMakeRange(0, self.length)];
}
- (void)dtt_addLineHeightMultiple:(CGFloat)lineHeightMultiple range:(NSRange)range {
    dtt_setParagraphStyleProperty(lineHeightMultiple,range);
}

- (void)setdtt_hyphenationFactor:(float)hyphenationFactor {
    [self dtt_addHyphenationFactor:hyphenationFactor range:NSMakeRange(0, self.length)];
}
- (void)dtt_addHyphenationFactor:(float)hyphenationFactor range:(NSRange)range {
    dtt_setParagraphStyleProperty(hyphenationFactor,range);
}

- (void)setdtt_defaultTabInterval:(CGFloat)defaultTabInterval {
    [self dtt_addDefaultTabInterval:defaultTabInterval range:NSMakeRange(0, self.length)];
}
- (void)dtt_addDefaultTabInterval:(CGFloat)defaultTabInterval range:(NSRange)range {
    dtt_setParagraphStyleProperty(defaultTabInterval,range);
}

- (void)setdtt_characterSpacing:(CGFloat)characterSpacing {
    [self dtt_addCharacterSpacing:characterSpacing range:NSMakeRange(0, self.length)];
}
- (void)dtt_addCharacterSpacing:(CGFloat)characterSpacing range:(NSRange)range {
    [self dtt_addAttribute:NSKernAttributeName value:@(characterSpacing) range:range];
}

- (void)setdtt_lineThroughStyle:(NSUnderlineStyle)lineThroughStyle {
    [self dtt_addLineThroughStyle:lineThroughStyle range:NSMakeRange(0, self.length)];
}
- (void)dtt_addLineThroughStyle:(NSUnderlineStyle)style range:(NSRange)range {
    [self dtt_addAttribute:NSStrikethroughStyleAttributeName value:@(style) range:range];
}

- (void)setdtt_lineThroughColor:(UIColor *)lineThroughColor {
    [self dtt_addLineThroughColor:lineThroughColor range:NSMakeRange(0, self.length)];
}
- (void)dtt_addLineThroughColor:(UIColor *)color range:(NSRange)range {
    [self dtt_addAttribute:NSStrikethroughColorAttributeName value:color range:range];
}

- (void)setdtt_underLineStyle:(NSUnderlineStyle)underLineStyle {
    [self dtt_addUnderLineStyle:underLineStyle range:NSMakeRange(0, self.length)];
}
- (void)dtt_addUnderLineStyle:(NSUnderlineStyle)style range:(NSRange)range {
    [self dtt_addAttribute:NSUnderlineStyleAttributeName value:@(style) range:range];
}

- (void)setdtt_underLineColor:(UIColor *)underLineColor {
    [self dtt_addUnderLineColor:underLineColor range:NSMakeRange(0, self.length)];
}
- (void)dtt_addUnderLineColor:(UIColor *)color range:(NSRange)range {
    [self dtt_addAttribute:NSUnderlineColorAttributeName value:color range:range];
}

- (void)setdtt_characterLigature:(NSInteger)characterLigature {
    [self dtt_addCharacterLigature:characterLigature range:NSMakeRange(0, self.length)];
}
- (void)dtt_addCharacterLigature:(NSInteger)characterLigature range:(NSRange)range {
    [self dtt_addAttribute:NSLigatureAttributeName value:@(characterLigature) range:range];
}

- (void)setdtt_strokeColor:(UIColor *)strokeColor {
    [self dtt_addStrokeColor:strokeColor range:NSMakeRange(0, self.length)];
}
- (void)dtt_addStrokeColor:(UIColor *)color range:(NSRange)range {
    [self dtt_addAttribute:NSStrokeColorAttributeName value:color range:range];
}

- (void)setdtt_strokeWidth:(CGFloat)strokeWidth {
    [self dtt_addStrokeWidth:strokeWidth range:NSMakeRange(0, self.length)];
}
- (void)dtt_addStrokeWidth:(CGFloat)strokeWidth range:(NSRange)range {
    [self dtt_addAttribute:NSStrokeWidthAttributeName value:@(strokeWidth) range:range];
}

- (void)setdtt_shadow:(NSShadow *)shadow {
    [self dtt_addShadow:shadow range:NSMakeRange(0, self.length)];
}
- (void)dtt_addShadow:(NSShadow *)shadow range:(NSRange)range {
    [self dtt_addAttribute:NSShadowAttributeName value:shadow range:range];
}

- (void)dtt_addAttachment:(NSTextAttachment *)attachment range:(NSRange)range {
    [self dtt_addAttribute:NSAttachmentAttributeName value:attachment range:range];
}

- (void)setdtt_link:(id)link {
    [self dtt_addLink:link range:NSMakeRange(0, self.length)];
}
- (void)dtt_addLink:(id)link range:(NSRange)range {
    [self dtt_addAttribute:NSLinkAttributeName value:link range:range];
}

- (void)setdtt_baseline:(CGFloat)baseline {
    [self dtt_addBaseline:baseline range:NSMakeRange(0, self.length)];
}
- (void)dtt_addBaseline:(CGFloat)baseline range:(NSRange)range {
    [self dtt_addAttribute:NSBaselineOffsetAttributeName value:@(baseline) range:range];
}

- (void)dtt_addWritingDirection:(NSWritingDirection)writingDirection range:(NSRange)range {
    [self dtt_addAttribute:NSWritingDirectionAttributeName value:@(writingDirection) range:range];
}

- (void)setdtt_obliqueness:(CGFloat)obliqueness {
    [self dtt_addObliqueness:obliqueness range:NSMakeRange(0, self.length)];
}
- (void)dtt_addObliqueness:(CGFloat)obliqueness range:(NSRange)range {
    [self dtt_addAttribute:NSObliquenessAttributeName value:@(obliqueness) range:range];
}

- (void)setdtt_expansion:(CGFloat)expansion {
    [self dtt_addExpansion:expansion range:NSMakeRange(0, self.length)];
}
- (void)dtt_addExpansion:(CGFloat)expansion range:(NSRange)range {
    [self dtt_addAttribute:NSExpansionAttributeName value:@(expansion) range:range];
}


#pragma mark - Add
- (void)dtt_addForeColorAttributeWithValue:(UIColor *)color {
    [self dtt_addForeColorAttributeWithValue:color range:self.dtt_allRange];
}
- (void)dtt_addForeColorAttributeWithValue:(UIColor *)color range:(NSRange)range {
    [self dtt_addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)dtt_addFontAttributeWithValue:(UIFont *)font {
    [self dtt_addFontAttributeWithValue:font range:self.dtt_allRange];
}
- (void)dtt_addFontAttributeWithValue:(UIFont *)font range:(NSRange)range {
    [self dtt_addAttribute:NSFontAttributeName value:font range:range];
}

- (void)dtt_addUnderlineStyleAttributeWithValue:(CTUnderlineStyle)style
                                       modifier:(CTUnderlineStyleModifiers)modifier {
    [self dtt_addUnderlineStyleAttributeWithValue:style modifier:modifier range:self.dtt_allRange];
}

- (void)dtt_addUnderlineStyleAttributeWithValue:(CTUnderlineStyle)style modifier:(CTUnderlineStyleModifiers)modifier range:(NSRange)range {
    [self removeAttribute:(NSString *)kCTUnderlineStyleAttributeName range:range];
    
    if (style != kCTUnderlineStyleNone) {
        [self addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                     value:@(style | modifier)
                     range:range];
    }
}

- (void)dtt_addAttributeStrokeColor:(UIColor *)strokeColor strokeWidth:(unichar)strokeWidth {
    [self removeAttribute:(id)kCTStrokeWidthAttributeName range:self.dtt_allRange];
    if (strokeWidth > 0) {
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &strokeWidth);
        [self addAttribute:(id)kCTStrokeWidthAttributeName value:(__bridge id)num range:self.dtt_allRange];
    }
    
    [self removeAttribute:(id)kCTStrokeColorAttributeName range:self.dtt_allRange];
    if (strokeColor) {
        [self addAttribute:(id)kCTStrokeColorAttributeName value:(id)strokeColor.CGColor range:self.dtt_allRange];
    }
}

- (void)dtt_addAttributeCharacterSpacing:(unichar)characterSpacing {
    [self dtt_addAttributeCharacterSpacing:characterSpacing range:self.dtt_allRange];
}

- (void)dtt_addAttributeCharacterSpacing:(unichar)characterSpacing range:(NSRange)rang {
    [self removeAttribute:(id)kCTKernAttributeName range:rang];
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt8Type, &characterSpacing);
    [self addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:rang];
    CFRelease(num);
}

- (void)dtt_addAttributeAlignmentStyle:(CTTextAlignment)textAlignment lineSpaceStyle:(CGFloat)linesSpacing paragraphSpaceStyle:(CGFloat)paragraphSpacing lineBreakStyle:(CTLineBreakMode)lineBreakMode {
    [self dtt_addAttributeAlignmentStyle:textAlignment
                          lineSpaceStyle:linesSpacing
                     paragraphSpaceStyle:paragraphSpacing
                          lineBreakStyle:lineBreakMode
                                    rang:self.dtt_allRange];
}

- (void)dtt_addAttributeAlignmentStyle:(CTTextAlignment)textAlignment lineSpaceStyle:(CGFloat)linesSpacing paragraphSpaceStyle:(CGFloat)paragraphSpacing lineBreakStyle:(CTLineBreakMode)lineBreakMode rang:(NSRange)range {
    [self removeAttribute:(id)kCTParagraphStyleAttributeName range:range];
    
    
        //创建文本对齐方式
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment; //指定对齐属性
    alignmentStyle.valueSize = sizeof(textAlignment);
    alignmentStyle.value = &textAlignment;
    
        //创建文本行间距
    CTParagraphStyleSetting lineSpaceStyle;
    lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    lineSpaceStyle.valueSize = sizeof(linesSpacing);
    lineSpaceStyle.value = &linesSpacing;
    
        //段落间距
    CTParagraphStyleSetting paragraphSpaceStyle;
    paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpaceStyle.value = &paragraphSpacing;
    paragraphSpaceStyle.valueSize = sizeof(paragraphSpacing);
    
        //折行模式
    CTParagraphStyleSetting lineBreakStyle;
    lineBreakStyle.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakStyle.value = &lineBreakMode;
    lineBreakStyle.valueSize = sizeof(lineBreakMode);
    
        //创建样式数组
    CTParagraphStyleSetting settings[] = {alignmentStyle,lineSpaceStyle,paragraphSpaceStyle,lineBreakStyle};
    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
    
    [self addAttribute:(id)kCTParagraphStyleAttributeName value:(id)CFBridgingRelease(paragraphStyle) range:range];
}

- (void)dtt_addAttributeAlignmentStyle2:(NSTextAlignment)textAlignment
                         lineSpaceStyle:(CGFloat)linesSpacing
                    paragraphSpaceStyle:(CGFloat)paragraphSpacing
                         lineBreakStyle:(NSLineBreakMode)lineBreakMode {
    [self dtt_addAttributeAlignmentStyle2:textAlignment
                           lineSpaceStyle:linesSpacing
                      paragraphSpaceStyle:paragraphSpacing
                           lineBreakStyle:lineBreakMode
                                     rang:self.dtt_allRange];
}

- (void)dtt_addAttributeAlignmentStyle2:(NSTextAlignment)textAlignment
                         lineSpaceStyle:(CGFloat)linesSpacing
                    paragraphSpaceStyle:(CGFloat)paragraphSpacing
                         lineBreakStyle:(NSLineBreakMode)lineBreakMode
                                   rang:(NSRange)range {
    [self removeAttribute:NSParagraphStyleAttributeName range:range];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = linesSpacing;
    style.alignment = textAlignment;
    style.lineBreakMode = lineBreakMode;
    style.paragraphSpacing = paragraphSpacing;
    [self dtt_addAttribute:NSParagraphStyleAttributeName value:style range:range];
}

@end
