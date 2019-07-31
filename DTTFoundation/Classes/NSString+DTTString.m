//
//  NSString+DTTString.m
//  Pods
//
//  Created by dtt on 16/6/6.
//
//

#import "NSString+DTTString.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonCryptoError.h>
#define kDTTNumberToString(x) @(x).stringValue;

@implementation NSString (DTTString)

/*!
 *  随机生成唯一id
 */
NSString * const DTTGeneralUUID(void)
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid);
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}


/*!
 *  是否是空字符串
 */
BOOL const DTTIsEmptyString(NSString *str) {
    return !DTTIsNotEmptyString(str);
}

/*!
 *  不是空字符串
 */
BOOL const DTTIsNotEmptyString(NSString *str) {
    return DTTIsNotEmpty(str) && [str isKindOfClass:[NSString class]] && str.length > 0;
}

NSString * DTTNoNilString(id str) {
    if (DTTIsEmpty(str)) {
        return [NSString emptyString];
    }
    
    return str;
}

/**
 *  点 .
 */
NSString * DTTDotString(void) {
    return [NSString dotString];
}
/**
 *  逗号 ,
 */
NSString * DTTCommaString(void) {
    return [NSString commaString];
}
/**
 *  换行符 \n
 */
NSString * DTTLineBreakString(void) {
    return [NSString dtt_lineBreakString];
}

NSString* _Nonnull DTTFilePrefix = @"file://";

NSString* DTTDoubleLineBreakString(void) {
    return [NSString dtt_doubleLineBreakString];
}

NSString * NSStringFromInt(int value) {
    return kDTTNumberToString(value);
}
NSString * NSStringFromNSInteger(NSInteger value) {
    return kDTTNumberToString(value);
}
NSString * NSStringFromNSUInteger(NSUInteger value) {
    return kDTTNumberToString(value);
}
NSString * NSStringFromunsignedLongLong(unsigned long long value) {
    return kDTTNumberToString(value);
}
NSString * NSStringFromCGFloat(CGFloat value) {
    return kDTTNumberToString(value);
}
NSString * NSStringFromPointer(id x) {
    return [NSString stringWithFormat:@"%p",x];
}

BOOL DTTIsEqualToString(NSString * aStr , NSString * bStr) {
    if ([aStr isKindOfClass:[NSString class]] &&
        [bStr isKindOfClass:[NSString class]]) {
        
        return [aStr isEqualToString:bStr];
    } else {
        /*
            因为此方法是判断字符串是否相等的，所以如果都不是字符串就直接返回NO
         */
        return NO;
    }
}

/**
 *  生成UUID
 *  @discussion 格式如下:
 *          2B064C33-149B-43A6-A506-33066B49AED2
            F017D24F-5CF2-4C17-B71C-CCA5FA1CA87D
 *  @return UUID
 */
NSString * const DTTGeneralUUIDString(void) {
    return [NSUUID UUID].UUIDString;
}

+ (NSString *)emptyString {
    return @"";
}

+ (NSString *)dotString {
    return @".";
}

+ (NSString *)commaString {
    return @",";
}

+ (NSString *)dtt_lineBreakString {
    return @"\n";
}

+ (NSString*)dtt_doubleLineBreakString {
    return @"\n\n";
}

#pragma mark - 截取字符串
- (NSString *)dtt_subStringWithoutRange:(NSRange)aRange {
    //前面的string
    NSString * preString = [self substringToIndex:aRange.location];
    //后面的string
    NSString * sufString = [self substringFromIndex:aRange.location + aRange.length];
    return [preString stringByAppendingString:sufString];
}

/*!
 *  删除第一个字符
 */
- (NSString *)dtt_removeFirstCharacter {
    return [self dtt_removeFirstCharacterWithCount:1];
}

- (NSString *)dtt_removeFirstCharacterWithCount:(NSUInteger)aCount {
    if (aCount == 0 || self.length <= 0) {
        return self;
    }

    if (self.length <= aCount) {
        return [NSString emptyString];
    }
    
    return [self substringWithRange:NSMakeRange(aCount, self.length - aCount)];
}

- (NSString *)dtt_removeStringFromHeader:(NSString *)aString {
    if ([self dtt_containsSubstring:aString]) {
        NSRange range = [self dtt_rangeOfStringFromHeader:aString];
        return [self dtt_subStringWithoutRange:range];
    }
    
    return self;
}

/*!
 *  删除最后一个字符
 */
- (NSString *)dtt_removeLastCharacter {
    return [self dtt_removeLastCharacterWithCount:1];
}

- (NSString *)dtt_removeLastCharacterWithCount:(NSUInteger)aCount {
    if (aCount == 0 || self.length <= 0) {
        return self;
    }
    
    if (self.length <= aCount) {
        return [NSString emptyString];
    }
    
    return [self substringWithRange:NSMakeRange(0, self.length - aCount)];
}

- (NSString *)dtt_removeStringFromEnd:(NSString *)aString {
    if ([self dtt_containsSubstring:aString]) {
        NSRange range = [self dtt_rangeOfStringFromEnder:aString];
        return [self dtt_subStringWithoutRange:range];
    }
    return self;
}

- (NSString *)dtt_removeAllStrings:(NSString *)aString {
    return [self stringByReplacingOccurrencesOfString:aString withString:@""];
}

- (NSString *)dtt_removeFreeWhiteSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/** 不区分大小写，比较两个字符串*/
- (BOOL)dtt_isEqualToIgnoreCaseString:(NSString*)anotherString {
    return [self.lowercaseString isEqualToString:anotherString.lowercaseString];
}

/** 隐藏手机号，只显示开头3位和最后3位*/
- (NSString*)dtt_beSecret {
    NSUInteger length = self.length;
    if (self.length <= 3) return self;
    int hiddenLength = floor(length / 2);
    int headerShowLength = floor((length - hiddenLength) / 2);
    NSMutableString* star = [[NSMutableString alloc] initWithCapacity:hiddenLength];
    for (int i = 0; i < hiddenLength; i++) {
        [star appendString:@"*"];
    }
    return [self stringByReplacingCharactersInRange:NSMakeRange(headerShowLength, hiddenLength) withString:star];
}


/*!
 *  删掉行首和行尾换行符"\n"
 *  如： "\na\nb\n" ==> "a\nb"
 */
- (NSString *)dtt_trimNewLine {
    if (self.length <= 0) {
        return self;
    }
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

/*!
 *  删除所有的换行符"\n"
 *  如： "\na\nb\n" ==> "ab"
 */
- (NSString *)dtt_trimNewLines {
    return [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

/**
 *  删除行首和行尾的换行符和空格
 *  如："\n a \n b \n" ==> "a \n b"
 */
- (NSString *)dtt_trimNewLineAndWhiteSpace {
    if (self.length <= 0) {
        return self;
    }
    
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 *  删除所有的换行符和空格符
 *  如："\n a \n b \n" ==> "ab"
 */
- (NSString *)dtt_trimNewLinesAndWhiteSpaces {
    return [[self stringByReplacingOccurrencesOfString:@" " withString:@""]
            stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

- (BOOL)dtt_isNewLinesAndWhiteSpaces {
    return DTTIsEmptyString([self dtt_trimNewLineAndWhiteSpace]);
}

- (NSString *)dtt_reverseString {
    if (self.length <= 1)
        return self;
    
    NSUInteger stringLength = self.length;
    NSInteger stringIndex, reverseStringIndex;
    unichar *stringChars = calloc(sizeof(unichar), stringLength);
    unichar *reverseStringChars = calloc(sizeof(unichar), stringLength);
    
    [self getCharacters:stringChars range:NSMakeRange(0, stringLength)];
    
    for (stringIndex=stringLength-1, reverseStringIndex=0; stringIndex>=0; stringIndex--, reverseStringIndex++)
        reverseStringChars[reverseStringIndex] = stringChars[stringIndex];
    
    free(stringChars);
    
    return [[NSString alloc] initWithCharactersNoCopy:reverseStringChars length:stringLength freeWhenDone:YES];
}

/**
 全长度  {0,self.length}
 */
- (NSRange)dtt_allRange {
    return NSMakeRange(0, self.length);
}

/**
 range是否越界
 */
- (BOOL)dtt_isValidRange:(NSRange)range {
    NSRange interRange = NSIntersectionRange(self.dtt_allRange, range);
    return NSEqualRanges(range, interRange);
}

/**
 index 是否越界
 */
- (BOOL)dtt_isValidIndex:(NSUInteger)index {
    return [self dtt_isValidRange:NSMakeRange(index, 1)];
}

/**
 取对应索引的字符
 */
- (NSString *)dtt_stringAtIndex:(NSUInteger)index {
    if ([self dtt_isValidIndex:index]) {
        return [self substringWithRange:NSMakeRange(index, 1)];
    }
    
    return @"";
}
- (unichar)dtt_characterAtIndex:(NSUInteger)index {
    if ([self dtt_isValidIndex:index]) {
        return [self characterAtIndex:index];
    }
    
    return 0;
}

/**
 第一个字符
 */
- (NSString *)dtt_firstString {
    return [self dtt_stringAtIndex:0];
}
- (unichar)dtt_firstCharactor {
    return [self dtt_characterAtIndex:0];
}

- (BOOL)dtt_startsWith:(NSString*)prefix {
    return [self rangeOfString:prefix].location == 0;
}

- (BOOL)dtt_endsWith:(NSString*)suffix {
    NSRange range = [self rangeOfString:suffix options:NSBackwardsSearch];
    return range.location + range.length == self.length;
}

/**
 最后一个字符
 */
- (NSString *)dtt_lastString {
    return [self dtt_stringAtIndex:self.length - 1];
}
- (unichar )dtt_lastCharactor {
    return [self dtt_characterAtIndex:self.length - 1];
}

/**
 让第一个字符 大写
 */
- (NSString *)dtt_upperFirstChar {
    if (DTTIsEmptyString(self)) {
        return self;
    }
    
    NSString * firstString = [self dtt_firstString];
    if ([firstString dtt_isAllString]) { //检测第一个字符是否是字符串
        if ([firstString dtt_isAllLowerString]) {
            return [[firstString uppercaseString] stringByAppendingString:[self dtt_removeFirstCharacter]];
        }
    }
    
    return self;
}

/**
 让第一个字符 小写
 */
- (NSString *)dtt_lowerFirstChar {
    if (DTTIsEmptyString(self)) {
        return self;
    }
    
    NSString * firstString = [self dtt_firstString];
    if ([firstString dtt_isAllString]) { //检测第一个字符是否是字符串
        if ([firstString dtt_isAllUpperString]) {
            return [[firstString lowercaseString] stringByAppendingString:[self dtt_removeFirstCharacter]];
        }
    }
    
    return self;
}

#pragma mark - 判断类型


- (NSString *)dtt_32md5 {
    const char *cStr = self.UTF8String;
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  [NSString stringWithString: output].uppercaseString;
}

- (NSString *)dtt_128md5 {
    const char *cStr = self.UTF8String;
    unsigned char digest[CC_MD5_BLOCK_BYTES];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_BLOCK_BYTES * 2];
    
    for(int i = 0; i < CC_MD5_BLOCK_BYTES; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  [NSString stringWithString: output].uppercaseString;
}

/** 小md5加密 */
- (NSString *)dtt_md5 {
    if (DTTIsEmptyString(self)) return @"";
    const char *str = [self UTF8String];
    unsigned char array[16];
    CC_MD5(str, (CC_LONG)strlen(str), array);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            array[0], array[1], array[2], array[3],
            array[4], array[5], array[6], array[7],
            array[8], array[9], array[10], array[11],
            array[12], array[13], array[14], array[15]
            ];
}

- (NSString *)dtt_toString {
    return self;
}

- (NSNumber *)dtt_toNumber {
    if ([self dtt_isIntegerValue]) {
        return [self dtt_toLongLongNumber];
    }
    return [self dtt_toDoubleNumber];
}

- (NSNumber *)dtt_toDoubleNumber {
    return @(self.doubleValue);
}

- (NSNumber *)dtt_toFloatNumber {
    return @(self.floatValue);
}

- (NSNumber *)dtt_toIntegerNumber {
    return @(self.integerValue);
}

- (NSNumber *)dtt_toLongNumber {
    return @(self.intValue);
}

- (NSNumber *)dtt_toLongLongNumber {
    
    return @(self.longLongValue);
}

- (NSURL *)dtt_toURL {
    return [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (NSURL *)dtt_toFileURL {
    if ([self dtt_startsWith:DTTFilePrefix]) {
        return [self dtt_toURL];
    }
    return [NSURL fileURLWithPath:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString *)dtt_toPinyin {
    if ([self length] == 0)
    {
        return @"";
    }
    NSMutableString *pinyin = [self mutableCopy];
    
    if (!CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO) ||
        !CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO))
    {
        return @"";
    }
    return pinyin;
}



/**
 从头搜索字符串
 @example "4&12345&234"
 searchedString为 "&"  则 range = {1,1}
  如果searchedString为 "34" 则 range = {4,2}
 */
- (NSRange)dtt_rangeOfStringFromHeader:(NSString *)searchedString {
    return [self rangeOfString:searchedString options:NSLiteralSearch];
}

/**
 从尾部搜索字符串
 @example "4&12345&234"
 searchedString为 "&" 则range = {6,1}
如果searchedString为 "34" 则 range = {9,2}
 */
- (NSRange)dtt_rangeOfStringFromEnder:(NSString *)searchedString {
    return [self rangeOfString:searchedString options:NSBackwardsSearch];
}

#pragma mark - 容错方法
- (NSString *)dtt_appendString:(NSString *)string {
    if (DTTIsEmptyString(string)) {
        return self;
    }
    
    return [self stringByAppendingString:string];
}

- (NSString *)dtt_stringByAppendingURLPathComponent:(NSString *)aString {
    BOOL needSep1 = ![[self dtt_lastString] isEqualToString:@"/"];
    BOOL needSep2 = ![[aString dtt_firstString] isEqualToString:@"/"];
    
    if (needSep1 && needSep2) {
        aString = [@"/" dtt_appendString:aString];
    } else if (!needSep1 && !needSep2) {
        aString = [aString dtt_removeFirstCharacter];
    }
    
    return [self dtt_appendString:aString];
}

- (BOOL)dtt_containsSubstring:(NSString *)string {
    return [self rangeOfString:string].location != NSNotFound;
}

#pragma mark - 正则判断方法
/**
 *  是否是合法的URL
 */
- (BOOL)dtt_isValidURL {
    
    NSError * error = nil;
    NSDataDetector * dataDetector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypeLink
                                                                    error:&error];
    NSArray<NSTextCheckingResult *> * results = [dataDetector matchesInString:self
                                                                      options:0
                                                                        range:NSMakeRange(0, self.length)];
    return results.count == 1;
}

/**
 *  是否是合法的邮件
 */
- (BOOL)dtt_isValidEmail {
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,16}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stricterFilterString];
    return [emailTest evaluateWithObject:self];
}

/**
- (BOOL)dtt_isValidPhoneNumber {
    NSError * error = nil;
    NSDataDetector * dataDetector = [[NSDataDetector alloc] initWithTypes:NSTextCheckingTypePhoneNumber
                                                                    error:&error];
    NSArray<NSTextCheckingResult *> * results = [dataDetector matchesInString:self
                                                                      options:0
                                                                        range:NSMakeRange(0, self.length)];
    return results.count == 1;
}
*/

- (NSString *)stringValue {
    return self;
}

#pragma mark - 编码
- (NSString *)dtt_urlEncodedString {
    
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef)self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\|~ "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString *)encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    
    return encodedString;
}

- (NSString *)dtt_urlDecodedString {
    
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                          (__bridge CFStringRef)self,
                                                                                          CFSTR(""),
                                                                                          kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString *)decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

#pragma mark - Data与String互转
+ (instancetype)dtt_stringWithUTF8Data:(NSData *)data {
    return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (nullable NSData *)dtt_dataUsingUTF8Encoding {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - 路径相关
/*
 不带类型的文件名字   aaa
 */
- (NSString *)dtt_fileNameWithoutType {
    NSString * fullName = [self dtt_fileFullName];
    NSString * fullType = [self dtt_fileFullType];
    if ([fullName hasSuffix:fullType]) {
        NSRange range = [fullName rangeOfString:fullType options:NSBackwardsSearch]; //从后往前匹配
        if (range.location != NSNotFound) {
            return [fullName substringToIndex:range.location];
        }
    }
    return @"";
}
/*
 文件的完整名字    aaa.zip
 */
- (NSString *)dtt_fileFullName {
    return self.lastPathComponent;
}
/*
 文件的类型 zip
 */
- (NSString *)dtt_fileType {
    return self.pathExtension;
}

- (NSString *)dtt_fileFullType {
    return [@"." stringByAppendingString:[self dtt_fileType]];
}

static NSString * dtt_file_KBs = @"1024";
static NSString * dtt_file_MBs = @"1048576"; //1048576
static NSString * dtt_file_GBs = @"1073741824"; //1073741824
static NSString * dtt_file_TBs = @"1099511627776"; //1099511627776
static NSArray * dtt_file_sizes;
static NSArray * dtt_file_sizes_simple;
__attribute__((constructor)) static void initFileNormalSize(void)
{
    dtt_file_sizes = @[@{@"size": dtt_file_TBs,@"unit":@"TB"},
                       @{@"size": dtt_file_GBs,@"unit":@"GB"},
                       @{@"size": dtt_file_MBs,@"unit":@"MB"},
                       @{@"size": dtt_file_KBs,@"unit":@"KB"},
                       @{@"size": @"0",@"unit":@"B"}];
    
    dtt_file_sizes_simple = @[@{@"size": dtt_file_TBs,@"unit":@"T"},
                              @{@"size": dtt_file_GBs,@"unit":@"G"},
                              @{@"size": dtt_file_MBs,@"unit":@"M"},
                              @{@"size": dtt_file_KBs,@"unit":@"K"},
                              @{@"size": @"0",@"unit":@"B"}];
}

#pragma mark - 文件大小相关
+ (NSString *)dtt_stringWithFileSize:(unsigned long long)fileSize {
    return [NSStringFromunsignedLongLong(fileSize) dtt_toFileSize];
}

/**
 返回格式: 12.00G 等
 */
+ (NSString *)dtt_stringWithSimpleFileSize:(unsigned long long)fileSize {
    return [NSStringFromunsignedLongLong(fileSize) dtt_toSimpleFileSize];
}
/**
 返回格式: 12.00GB 等
 */
- (NSString *)dtt_toFileSize {
    return [self dtt_toFileSize:NO];
}
/**
 返回格式: 12.00G 等
 */
- (NSString *)dtt_toSimpleFileSize {
    return [self dtt_toFileSize:YES];
}

- (NSString *)dtt_toFileSize:(BOOL)isSimple {
    NSArray * oriFileSizeInfo = dtt_file_sizes;
    if (isSimple) {
        oriFileSizeInfo = dtt_file_sizes_simple;
    }
    unsigned long long fileSizeOri = self.longLongValue;
    for (NSDictionary * sizeDict in oriFileSizeInfo) {
        if ([sizeDict[@"size"] compare:self options:NSNumericSearch] != NSOrderedDescending) {
            CGFloat fileSize = 0;
            if ([sizeDict[@"size"] floatValue] <= 0) {
                fileSize = fileSizeOri;
            } else {
                fileSize = fileSizeOri / [sizeDict[@"size"] floatValue];
            }
            return [NSString stringWithFormat:@"%.2f%@", fileSize,sizeDict[@"unit"]];
        }
    }
    
    return @"0.00B";
}

- (NSString *)dtt_removePathExtension {
    NSString * filePath = self;
    if (DTTIsNotEmptyString(filePath.pathExtension)) {
        return [filePath dtt_removeStringFromEnd:[DTTDotString() stringByAppendingString:filePath.pathExtension]];
    }

    return filePath;
}

/**
 拼接成完整的文件名
 aaa  jpg ==> aaa.jpg
 aaa  .jpg ==> aaa.jpg
 aaa. jpg ==> aaa.jpg
 */
- (NSString *)dtt_appendingPathExtension:(NSString *)pathExtension {
    NSString * pathName = self;
    BOOL pathNameHasDot = [pathName hasSuffix:@"."];
    BOOL pathExtensionHasDot = [pathExtension hasPrefix:@"."];
    if ((pathNameHasDot && !pathExtensionHasDot) || (!pathNameHasDot && pathExtensionHasDot)) {
        return [pathName stringByAppendingString:pathExtension];
    } else if (!pathNameHasDot && !pathExtensionHasDot) {
        return [NSString stringWithFormat:@"%@.%@",pathName,pathExtension];
    } else if (pathExtensionHasDot && pathNameHasDot) {
        return [NSString stringWithFormat:@"%@%@",pathName,[pathExtension dtt_removeFirstCharacter]];
    }

    return self;
}

#pragma mark - 时间相关
+ (NSString *)dtt_stringHHmmssWithTime:(int)time {
    int hour = time / 3600;
    int minute = (time - hour * 3600) / 60;
    int second = time - hour * 3600 - minute * 60;
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hour,minute,second];
}
+ (NSString *)dtt_stringmmssWithTime:(int)time {
    return [[self dtt_stringHHmmssWithTime:time] substringWithRange:NSMakeRange(3, 5)];
}

/**
 将 01:01:20或者 01:20等格式的时间转成以秒为单位的时间
 */
- (NSUInteger)dtt_timeStringToSeconds {
    NSUInteger secondTime = 0;
    NSString * duration = self;
    NSArray * timeArrayI = [duration componentsSeparatedByString:@":"];
    if (timeArrayI.count >= 1 && timeArrayI.count <= 3 ) {
        NSUInteger hour = 0;
        NSUInteger minute = 0;
        NSUInteger second = 0;
        
        if (timeArrayI.count == 3) {
            hour = [timeArrayI.firstObject integerValue];
            minute = [timeArrayI[1] integerValue];
        } else if (timeArrayI.count == 2) {
            minute = [timeArrayI.firstObject integerValue];
        }
        
        second = [timeArrayI.lastObject integerValue];
        
        secondTime = hour * 60 * 60 + minute * 60 + second;
    }
    
    return secondTime;
}

/** 获取到数字*/
- (NSInteger)dtt_firstInteger {
    NSInteger value = 0;
    NSScanner* scanner = [NSScanner scannerWithString:self];
    scanner.charactersToBeSkipped = [NSCharacterSet characterSetWithCharactersInString:@"'"];
    [scanner scanInteger:&value];
    return value;
}

- (NSInteger)dtt_lastInteger {
    return 0;
}

- (NSArray<NSNumber*> *)dtt_allNumbers {
    return nil;

}

- (CGFloat)dtt_firstFloat {
    return 0.0;
}

- (CGFloat)dtt_lastFloat {
    return 0.0f;
}

#pragma mark - 粘贴板
- (void)dtt_copyToPasteBoard {
    UIPasteboard * pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:self];
}

/**
 转义字符
 */
- (id)dtt_replacingPercentEscapes {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - HTTP相关
/**
 是否以 http/https开头
 */
- (BOOL)dtt_hasPrefixHTTP {
    return [self.lowercaseString hasPrefix:@"http:"] || [self.lowercaseString hasPrefix:@"https:"];
}
/**
 是否以 https开头
 */
- (BOOL)dtt_hasPrefixHTTPS {
    return [self.lowercaseString hasPrefix:@"https:"];
}

#pragma mark - 加密相关
+ (NSString *)dtt_descryUseDES:(NSString *)text key:(NSString *)key {
    NSData *cipherData = [[NSData alloc] initWithBase64EncodedString:text options:0];;
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString *plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}

+ (NSString *)dtt_encryUseDES:(NSString *)text key:(NSString *)key {
    NSString *ciphertext = nil;
    const char *textBytes = [text UTF8String];
    NSUInteger dataLength = [text length];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    const void *iv = (const void *)[key UTF8String];
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          textBytes,
                                          dataLength,
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [data base64EncodedStringWithOptions:0];
    }
    return ciphertext;
}

@end




