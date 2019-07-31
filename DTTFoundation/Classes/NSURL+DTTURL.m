//
//  NSURL+DTTURL.m
//  Pods
//
//  Created by dtt on 16/6/20.
//
//

#import "NSURL+DTTURL.h"

@implementation NSURL (DTTURL)

+ (NSURL *)dtt_urlWithPath:(NSString *)path {
    if (DTTIsEmpty(path) ||
        NO == [path isKindOfClass:[NSString class]]) {
        return [NSURL URLWithString:@""];
    }
    return [NSURL URLWithString:path];
}

- (NSString *)dtt_toString {
    return self.absoluteString;
}

- (BOOL)dtt_isEqualToURL:(NSURL *)url {
    if (![[self scheme] isEqualToString:[url scheme]]) {
        return NO;
    }
    if (![[self host] isEqualToString:[url host]]) {
        return NO;
    }
    if (![[self path] isEqualToString:[url path]]) {
        return NO;
    }
    return YES;
}

- (NSString *)dtt_trimSchema {
    NSString * urlString = self.absoluteString;
    NSString * schema = self.scheme;
    if ([schema hasSuffix:@"://"] == NO) {
        schema = [schema stringByAppendingString:@"://"];
    }
    if ([urlString hasPrefix:schema]) {
        return [urlString substringFromIndex:schema.length];
    }
    return @"";
}

/**
 是否是文件夹
 */
- (BOOL)dtt_isDirectoryError:(NSError * _Nullable __autoreleasing *)error {
    NSError *outError;
    NSNumber *retval = nil;
    if (![self getResourceValue:&retval forKey:NSURLIsDirectoryKey error:&outError]) {
        *error = outError;
    }
    return retval.boolValue;
}

/**
 是否是文件
 */
- (BOOL)dtt_isFileError:(NSError * _Nullable __autoreleasing *)error {
    NSError *outError;
    NSNumber *retval = nil;
    if (![self getResourceValue:&retval forKey:NSURLIsRegularFileKey error:&outError]) {
        *error = outError;
    }
    return retval.boolValue;
}

/**
 是否是可执行文件
 */
- (BOOL)dtt_isExecuteError:(NSError * _Nullable __autoreleasing *)error {
    NSError *outError;
    NSNumber *retval = nil;
    if (![self getResourceValue:&retval forKey:NSURLIsSymbolicLinkKey error:&outError]) {
        *error = outError;
    }
    return retval.boolValue;
}

- (BOOL)dtt_isHiddenError:(NSError * _Nullable __autoreleasing *)error {
    NSError *outError;
    NSNumber *retval = nil;
    if (![self getResourceValue:&retval forKey:NSURLIsHiddenKey error:&outError]) {
        *error = outError;
    }
    return retval.boolValue;
}

- (NSDictionary *)dtt_queryDictionary {
    NSMutableDictionary *retval = [NSMutableDictionary dictionaryWithCapacity:0];
    for (NSString *pair in [self.query componentsSeparatedByString:@"&"]) {
        NSArray *pairComps = [pair componentsSeparatedByString:@"="];
        [retval setObject:[pairComps objectAtIndex:1] forKey:[pairComps objectAtIndex:0]];
    }
    return retval;
}

- (NSURL *)dtt_toURL {
    return self;
}

- (NSURL *)dtt_toFileURL {
    return self;
}

/** 是否是http协议*/
- (BOOL)dtt_isHTTP {
    return [self.scheme caseInsensitiveCompare:@"http"] == NSOrderedSame;
}

/** 是否是https协议*/
- (BOOL)dtt_isHTTPS {
    return [self.scheme caseInsensitiveCompare:@"https"] == NSOrderedSame;
}

@end
