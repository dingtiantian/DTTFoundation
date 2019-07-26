//
//  NSBundle+DTTBundle.h
//  DTTFoundation
//
//  Created by admin on 2019/7/26.
//

#import <Foundation/Foundation.h>
#import <DTTFoundation/NSString+DTTString.h>
#import <DTTFoundation/NSFileManager+DTTFoundationAdd.h>

NS_ASSUME_NONNULL_BEGIN

/* main bundle的文件夹地址 */
extern NSString * DTTMainBundleResourcePath(void);

/* 获取 main bundle 中文件地址 */
extern NSString * DTTMainBundleResourcePathForFile(NSString * fileName);
extern NSString * DTTMainBundleResourcePathForFileWithType(NSString *fileName,NSString * fileType);

@interface NSBundle (DTTBundle)

/*!
 *  获取包内私有bundle
 *  @param bundleName bundle名称，不需要路径
 *  @return 对应的bundle
 */
+ (NSBundle *)dtt_privateBundleWithName:(NSString *)bundleName;

- (NSString *)dtt_name;

+ (NSString *)dtt_cachesPath;
+ (NSString *)dtt_cachesPathAndSubpaths:(NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;

+ (NSString *)dtt_documentsPath;
+ (NSString *)dtt_documentsPathAndSubpaths:(NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;

+ (NSString *)dtt_temporaryPath;
+ (NSString *)dtt_temporaryPathAndSubpaths:(NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;

+ (NSString *)dtt_libraryPath;
+ (NSString *)dtt_libraryPathAndSubpaths:(NSString *)first, ... NS_REQUIRES_NIL_TERMINATION;
@end

NS_ASSUME_NONNULL_END
