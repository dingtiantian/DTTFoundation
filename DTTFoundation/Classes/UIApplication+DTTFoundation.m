//
//  UIApplication+DTTFoundation.m
//  DTTFoundation
//
//  Created by admin on 2019/7/26.
//

#import "UIApplication+DTTFoundation.h"

@implementation UIApplication (DTTFoundation)
/** 应用id*/
+ (NSString *)dtt_bundleId {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleIdentifier"];
}

/** 应用版本号*/
+ (NSString *)dtt_version {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

/** 应用build号,剔除所有小数点*/
+ (NSString *)dtt_buildNumber {
    NSString *build = [[self class] dtt_fullBuildNumber];
    NSScanner* scanner = [NSScanner scannerWithString:build];
    NSInteger realBuild;
    [scanner scanInteger:&realBuild];
    return @(realBuild).stringValue;
        //    if (scanRet) {
        //
        //    }
        //    if ([build containsString:@"."]) {
        //        NSArray *array = [build componentsSeparatedByString:@"."];
        //        if (array.count > 0) {
        //            build = array.firstObject;
        //        }
        //    }
        //    return build;
}

/** 应用build号*/
+ (NSString *)dtt_fullBuildNumber {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

@end
