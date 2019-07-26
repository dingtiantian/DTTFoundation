//
//  NSBundle+DTTBundle.m
//  DTTFoundation
//
//  Created by admin on 2019/7/26.
//

#import "NSBundle+DTTBundle.h"
/*
 main bundle的文件夹地址
 */
NSString * DTTMainBundleResourcePath(void) {
    return [[NSBundle mainBundle] resourcePath];
}

/*
 获取 main bundle 中文件地址
 */
NSString * DTTMainBundleResourcePathForFile(NSString * fileName) {
    return [DTTMainBundleResourcePath() stringByAppendingPathComponent:fileName];
}

NSString * DTTMainBundleResourcePathForFileWithType(NSString *fileName,NSString * fileType) {
    return DTTMainBundleResourcePathForFile([fileName dtt_appendingPathExtension:fileType]);
}

@implementation NSBundle (DTTBundle)

- (NSString *)dtt_name {
    return [self.infoDictionary objectForKey:(id)kCFBundleNameKey];
}

+ (NSBundle *)dtt_privateBundleWithName:(NSString *)bundleName {
    
    if (DTTIsEmptyString(bundleName)) {
        NSLog(@"传入的bundleName为空");
        return [NSBundle mainBundle];
    }
    
        //在有些场景需要用到mainBundle的处理
    if ([@[@"main",@"main.bundle"] containsObject:bundleName.lowercaseString]) {
        NSLog(@"传入的是%@，所以返回mainBundle",bundleName);
        return [NSBundle mainBundle];
    }
    
        //因为Xcode会强制带上 .bundle 为后缀并且只用纯bundle名字找不到对应的bundle，所以此处必须判断是否有 .bundle后缀
    if (NO == [bundleName hasSuffix:@".bundle"]) {
        if (NO == [bundleName hasSuffix:@"."]) {
            bundleName = [bundleName stringByAppendingString:@"."];
        }
        
        bundleName = [bundleName stringByAppendingString:@"bundle"];
    }
    
    NSString * bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:bundleName];
    return [NSBundle bundleWithPath:bundlePath];
}

+ (NSString *)dtt_cachesPath {
    static NSString * _cachesPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    });
    return _cachesPath;
}
+ (NSString *)dtt_cachesPathAndSubpaths:(NSString *)first, ... {
    va_list list;
    NSString * fullPath = nil;
    va_start(list, first);
    fullPath = DTTToCompleteFilePathUseVAList(list, [self dtt_cachesPath],first, nil);
    va_end(list);
    return fullPath;
}

+ (NSString *)dtt_documentsPath {
    static NSString * _documentsPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    });
    return _documentsPath;
}
+ (NSString *)dtt_documentsPathAndSubpaths:(NSString *)first, ... {
    va_list list;
    NSString * fullPath = nil;
    va_start(list, first);
    fullPath = DTTToCompleteFilePathUseVAList(list, [self dtt_documentsPath],first, nil);
    va_end(list);
    return fullPath;
}

+ (NSString *)dtt_temporaryPath {
    static NSString * _temporaryPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _temporaryPath = NSTemporaryDirectory();
    });
    return _temporaryPath;
}
+ (NSString *)dtt_temporaryPathAndSubpaths:(NSString *)first, ... {
    va_list list;
    NSString * fullPath = nil;
    va_start(list, first);
    fullPath = DTTToCompleteFilePathUseVAList(list, [self dtt_temporaryPath],first, nil);
    va_end(list);
    return fullPath;
}

+ (NSString *)dtt_libraryPath {
    static NSString * _libraryPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    });
    return _libraryPath;
}
+ (NSString *)dtt_libraryPathAndSubpaths:(NSString *)first, ... {
    va_list list;
    NSString * fullPath = nil;
    va_start(list, first);
    fullPath = DTTToCompleteFilePathUseVAList(list, [self dtt_libraryPath],first, nil);
    va_end(list);
    return fullPath;
}

@end
