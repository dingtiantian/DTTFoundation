//
//  NSURL+DTTURL.h
//  Pods
//
//  Created by majian on 16/6/20.
//
//

#import <Foundation/Foundation.h>
#import <DTTFoundation/NSObject+DTTObject.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSURL (DTTURL)

+ (NSURL *)dtt_urlWithPath:(NSString *)path;

- (NSString *)dtt_toString; //absoluteString

- (BOOL)dtt_isEqualToURL:(NSURL *)url;

/* 结果与self.relativePath相同 */
- (NSString *)dtt_trimSchema;

/** 是否是文件夹 */
- (BOOL)dtt_isDirectoryError:(NSError **)error;

/** 是否是文件 */
- (BOOL)dtt_isFileError:(NSError **)error;

/** 是否是可执行文件 */
- (BOOL)dtt_isExecuteError:(NSError **)error;

/** 是否是隐藏文件 */
- (BOOL)dtt_isHiddenError:(NSError **)error;

- (NSDictionary *)dtt_queryDictionary;

- (NSURL *)dtt_toURL;
- (NSURL *)dtt_toFileURL;

/** 是否是http协议*/
- (BOOL)dtt_isHTTP;
/** 是否是https协议*/
- (BOOL)dtt_isHTTPS;

@end
NS_ASSUME_NONNULL_END
