//
//  NSString+DTTString.h
//  Pods
//
//  Created by majian on 16/6/6.
//
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>
#import <DTTFoundation/NSScanner+DTTFoundationAdd.h>
#import <DTTFoundation/NSObject+DTTObject.h>

NS_ASSUME_NONNULL_BEGIN
/**  随机生成唯一id */
extern NSString * const DTTGeneralUUID(void);

/**  是否是空字符串 */
extern BOOL const DTTIsEmptyString(NSString *str);

/**  不是空字符串 */
extern BOOL const DTTIsNotEmptyString(NSString *str);

/**
 *  生成UUID
 *  @discussion 格式如下:
 *          2B064C33-149B-43A6-A506-33066B49AED2
            F017D24F-5CF2-4C17-B71C-CCA5FA1CA87D
 *  @return UUID
 */
extern NSString * const _Nonnull DTTGeneralUUIDString(void);

/**  剔除空字符串 */
extern NSString * _Nonnull DTTNoNilString(id str);

/**  点 . */
extern NSString * _Nonnull DTTDotString(void);
/**  逗号 , */
extern NSString * _Nonnull DTTCommaString(void);
/**  换行符 \n */
extern NSString * _Nonnull DTTLineBreakString(void);
/** file://*/
extern NSString* _Nonnull DTTFilePrefix;


/* 将数字转成字符串 */
extern NSString * _Nonnull NSStringFromInt(int value);
extern NSString * _Nonnull NSStringFromNSInteger(NSInteger value);
extern NSString * _Nonnull NSStringFromNSUInteger(NSUInteger value);
extern NSString * _Nonnull NSStringFromunsignedLongLong(unsigned long long value);
extern NSString * _Nonnull NSStringFromCGFloat(CGFloat value);
/* 将对象的内存地址转成字符串 */
extern NSString * _Nonnull NSStringFromPointer(id x);

/**  判断两个字符串是否相等 */
extern BOOL DTTIsEqualToString(NSString * aStr , NSString * bStr);

@interface NSString (DTTString)

/**  空字符串 @"" */
+ (NSString *)emptyString;

/**  点 . */
+ (NSString *)dotString;

/**  逗号 , */
+ (NSString *)commaString;

/**  换行符 \n */
+ (NSString *)dtt_lineBreakString;

/** 两个换行符 \n\n*/
+ (NSString*)dtt_doubleLineBreakString;

#pragma mark - 截取字符串
/* 去除aRange对应的string */
- (NSString *)dtt_subStringWithoutRange:(NSRange)aRange;

/**  删除第一个字符 */
- (NSString *)dtt_removeFirstCharacter;

/**  删除字符串的最前面几个字符 */
- (NSString *)dtt_removeFirstCharacterWithCount:(NSUInteger)aCount;

/* 从前往后 删除 最先匹配的aString */
- (NSString *)dtt_removeStringFromHeader:(NSString *)aString;

/**  删除最后一个字符 */
- (NSString *)dtt_removeLastCharacter;

/**  删除字符串的最后aCount个字符 */
- (NSString *)dtt_removeLastCharacterWithCount:(NSUInteger)aCount;

/** 从后往前 删除 最先匹配的aString */
- (NSString *)dtt_removeStringFromEnd:(NSString *)aString;

/** 删除已出现的所有aString */
- (NSString *)dtt_removeAllStrings:(NSString *)aString;

/**  删除头部和尾部多余的空白字符 */
- (NSString *)dtt_removeFreeWhiteSpace;

/** 不区分大小写，比较两个字符串*/
- (BOOL)dtt_isEqualToIgnoreCaseString:(NSString*)anotherString;

/** 隐藏中间<=一半的字符串*/
- (NSString*)dtt_beSecret;

/*!
 *  删掉行首和行尾换行符"\n"
 *  如： "\na\nb\n" ==> "a\nb"
 */
- (NSString *)dtt_trimNewLine;

/*!
 *  删除所有的换行符"\n"
 *  如： "\na\nb\n" ==> "ab"
 */
- (NSString *)dtt_trimNewLines;

/**
 *  删除行首和行尾的换行符和空格
 *  如："\n a \n b \n" ==> "a \n b"
 */
- (NSString *)dtt_trimNewLineAndWhiteSpace;

/**
 *  删除所有的换行符和空格符
 *  如："\n a \n b \n" ==> "ab"
 */
- (NSString *)dtt_trimNewLinesAndWhiteSpaces;

/** 是否是换行符和空格符组成 */
- (BOOL)dtt_isNewLinesAndWhiteSpaces;

/** 反转字符串 "abc" ==> "cba" */
- (NSString *)dtt_reverseString;

/** 全长度  {0,self.length} */
- (NSRange)dtt_allRange;

/** range是否越界 */
- (BOOL)dtt_isValidRange:(NSRange)range;

/** index 是否越界 */
- (BOOL)dtt_isValidIndex:(NSUInteger)index;

/** 取对应索引的字符 */
- (NSString *)dtt_stringAtIndex:(NSUInteger)index;
- (unichar)dtt_characterAtIndex:(NSUInteger)index;

/** 第一个字符 */
- (NSString *)dtt_firstString;
- (unichar)dtt_firstCharactor;

/** 最后一个字符 */
- (NSString *)dtt_lastString;
- (unichar )dtt_lastCharactor;

/** 让第一个字符 大写 */
- (NSString *)dtt_upperFirstChar;

/** 让第一个字符 小写 */
- (NSString *)dtt_lowerFirstChar;

#pragma mark - 判断类型

/**  128位md5加密 */
- (NSString *)dtt_128md5;

/**  32位md5加密 */
- (NSString *)dtt_32md5;

/** 小md5加密 */
- (NSString *)dtt_md5;

/**  以下方法均为将字符串转为对应类型的Number类型 */
- (NSNumber *)dtt_toDoubleNumber;
- (NSNumber *)dtt_toFloatNumber;
- (NSNumber *)dtt_toIntegerNumber;
- (NSNumber *)dtt_toLongNumber;
- (NSNumber *)dtt_toLongLongNumber;

/**  转成URL */
- (NSURL *)dtt_toURL;
/* 转成本地URL */
- (NSURL *)dtt_toFileURL;
/** 转成拼音 */
@property (nonatomic,readonly,copy) NSString * dtt_toPinyin;

- (NSString *)dtt_toString;
- (NSNumber *)dtt_toNumber;

- (BOOL)dtt_startsWith:(NSString*)prefix;
- (BOOL)dtt_endsWith:(NSString*)suffix;


/**
 从头搜索字符串
 @example "4&12345&234"
 如果searchedString为 "&"  则 range = {1,1}
 如果searchedString为 "34" 则 range = {4,2}
 */
- (NSRange)dtt_rangeOfStringFromHeader:(NSString *)searchedString;

/**
 从尾部搜索字符串
 @example "4&12345&234"
 如果searchedString为 "&" 则range = {6,1}
 如果searchedString为 "34" 则 range = {9,2}
 */
- (NSRange)dtt_rangeOfStringFromEnder:(NSString *)searchedString;

#pragma mark - 容错方法
/**
 *  附加字符串   
 *  如：
 *     正常情况
 *          [@"aa" dtt_appendString:@"bb"] ==> "aabb"
 *
 *     异常情况
 *          [@"aa" dtt_appendString:nil] ==> "aa" ps:此处的nil,<null>,或者""都是返回原字符串
 */
- (NSString *)dtt_appendString:(NSString *)string;

/** 拼接成 完整的URL路径 */
- (NSString *)dtt_stringByAppendingURLPathComponent:(NSString *)aString;

/** 是否包含string */
- (BOOL)dtt_containsSubstring:(NSString *)string;

#pragma mark - 正则判断方法
/**  是否是合法的URL */
- (BOOL)dtt_isValidURL;

/**  是否是合法的邮件 */
- (BOOL)dtt_isValidEmail;

//- (BOOL)dtt_isValidPhoneNumber;

#pragma mark - 编码
- (NSString *)dtt_urlEncodedString;
- (NSString *)dtt_urlDecodedString;

#pragma mark - Data与String互转
- (nullable NSData *)dtt_dataUsingUTF8Encoding;
+ (instancetype)dtt_stringWithUTF8Data:(NSData *)data;

#pragma mark - 路径相关
/* 不带类型的文件名字   aaa */
- (NSString *)dtt_fileNameWithoutType;
/* 文件的完整名字    aaa.zip */
- (NSString *)dtt_fileFullName;
/* 文件的类型 zip */
- (NSString *)dtt_fileType;
/* 文件类型   .zip */
- (NSString *)dtt_fileFullType;

#pragma mark - 文件大小相关
/** 返回格式: 12.00GB 等 */
+ (NSString *)dtt_stringWithFileSize:(unsigned long long)fileSize;
/** 返回格式: 12.00G 等 */
+ (NSString *)dtt_stringWithSimpleFileSize:(unsigned long long)fileSize;
/** 返回格式: 12.00GB 等 */
- (NSString *)dtt_toFileSize;
/** 返回格式: 12.00G 等 */
- (NSString *)dtt_toSimpleFileSize;
/**
 isSimple == YES  返回格式: 12.00G 等
 isSimple == NO  返回格式: 12.00GB 等
 */
- (NSString *)dtt_toFileSize:(BOOL)isSimple;

/** 移除文件类型后缀 aaa.zip ==> aaa */
- (NSString *)dtt_removePathExtension;

/**
 拼接成完整的文件名
 aaa  jpg ==> aaa.jpg
 aaa  .jpg ==> aaa.jpg
 aaa. jpg ==> aaa.jpg
 */
- (NSString *)dtt_appendingPathExtension:(NSString *)pathExtension;

#pragma mark - 时间相关
//00:00:00
+ (NSString *)dtt_stringHHmmssWithTime:(int)time;
//00:00
+ (NSString *)dtt_stringmmssWithTime:(int)time;
/** 将 01:01:20或者 01:20等格式的时间转成以秒为单位的时间 */
- (NSUInteger)dtt_timeStringToSeconds;
#pragma mark - 粘贴板
- (void)dtt_copyToPasteBoard;

/** 获取到数字*/
- (NSInteger)dtt_firstInteger;
- (NSInteger)dtt_lastInteger;
- (NSArray<NSNumber*> *)dtt_allNumbers;

- (CGFloat)dtt_firstFloat;
- (CGFloat)dtt_lastFloat;

#pragma mark - HTTP相关
/** 是否以 http/https开头 */
- (BOOL)dtt_hasPrefixHTTP;
/** 是否以 https开头 */
- (BOOL)dtt_hasPrefixHTTPS;

#pragma mark - 加密相关
/** 解密 */
+ (NSString *)dtt_descryUseDES:(NSString *)text key:(NSString *)key;
/** 加密 */
+ (NSString *)dtt_encryUseDES:(NSString *)text key:(NSString *)key;

@end
NS_ASSUME_NONNULL_END
