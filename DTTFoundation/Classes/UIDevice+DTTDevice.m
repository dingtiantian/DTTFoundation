//
//  UIDevice+DTTDevice.m
//  Pods
//
//  Created by dtt on 16/6/7.
//
//

#import "UIDevice+DTTDevice.h"
#import <objc/runtime.h>
#include <errno.h>
#include <sys/sysctl.h>
#import <mach/machine.h>
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface UIDevice ()
@property (nonatomic,assign) UIInterfaceOrientationMask dtt_orientation;
@end

/*!
 *  是否是模拟器
 */
BOOL DTTIsSimulater(void) {
    return [UIDevice dtt_isSimulator];
}

/*!
 *  是否是真机
 */
BOOL DTTIsPhysical(void) {
    return [UIDevice dtt_isPhysical];
}

/*!
 *  是否是跑测试
 */
BOOL DTTisRunningTests(void)
{
    return [([NSProcessInfo processInfo].environment[@"XCInjectBundle"]).pathExtension isEqualToString:@"octest"];
}

@implementation UIDevice (DTTDevice)

/** 系统版本*/
+ (CGFloat)dtt_systemVersion {
    static CGFloat _systemVersion = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    });
    
    return _systemVersion;
}

+ (BOOL)dtt_greaterThan:(NSString *)sysVer {
//    return [sysVer compare:[UIDevice currentDevice].systemVersion] != NSOrderedDescending;
    return [self dtt_systemVersion] >= sysVer.floatValue;
}
+ (BOOL)dtt_lessThan:(NSString *)sysVer {
    return [self dtt_systemVersion] <= sysVer.floatValue;
}

/** 系统大于6.0*/
+ (BOOL)dtt_greaterThan6 {
    return [self dtt_greaterThan:@"6.0"];
}
/** 系统版本小于6.0*/
+ (BOOL)dtt_lessThan6 {
    return [self dtt_lessThan:@"6.0"];
}

/** 系统大于7.0*/
+ (BOOL)dtt_greaterThan7 {
    return [self dtt_greaterThan:@"7.0"];
}
/** 系统版本小于7.0*/
+ (BOOL)dtt_lessThan7 {
    return [self dtt_lessThan:@"7.0"];
}

/** 系统大于8.0*/
+ (BOOL)dtt_greaterThan8 {
    return [self dtt_greaterThan:@"8.0"];
}
/** 系统版本小于8.0*/
+ (BOOL)dtt_lessThan8 {
    return [self dtt_lessThan:@"8.0"];
}

/** 系统大于9.0*/
+ (BOOL)dtt_greaterThan9 {
    return [self dtt_greaterThan:@"9.0"];
}
/** 系统版本小于9.0*/
+ (BOOL)dtt_lessThan9 {
    return [self dtt_lessThan:@"9.0"];
}

/**!
 * 系统大于10.0
 */
+ (BOOL)dtt_greaterThan10 {
    return [self dtt_greaterThan:@"10.0"];
}
/**!
 * 系统版本小于10.0
 */
+ (BOOL)dtt_lessThan10 {
    return [self dtt_lessThan:@"10.0"];
}

/*!
 *  是否是模拟器
 */
+ (BOOL)dtt_isSimulator {
#if TARGET_IPHONE_SIMULATOR
    return YES;
#else
    return NO;
#endif // #if TARGET_IPHONE_SIMULATOR
}

/*!
 *  是否是真机
 */
+ (BOOL)dtt_isPhysical {
    return ![self dtt_isSimulator];
}

/**
 *  设置当前设备横竖屏方向
 */
+ (void)dtt_setDeviceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        invocation.selector = selector;
        invocation.target = [UIDevice currentDevice];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

/** 获取旋转角度*/
+ (CGAffineTransform)dtt_getTransformRotationAngle:(UIInterfaceOrientation)orientation {
    if (orientation == UIInterfaceOrientationPortrait) {
        return CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        return CGAffineTransformMakeRotation(-M_PI_2);
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        return CGAffineTransformMakeRotation(M_PI_2);
    }
    return CGAffineTransformIdentity;
}

/**
 *  强制横屏
 */
+ (void)dtt_setDeviceOrientationLandscapeRight {
    [self dtt_setDeviceOrientation:UIInterfaceOrientationLandscapeRight];
}

/**
 *  强制横屏
 */
+ (void)dtt_setDeviceOrientationLandscapeLeft {
    [self dtt_setDeviceOrientation:UIInterfaceOrientationLandscapeLeft];
}

/**
 *  强制竖屏
 */
+ (void)dtt_setDeviceOrientationPortrait {
    [self dtt_setDeviceOrientation:UIInterfaceOrientationPortrait];
}

#pragma mark - 控制app界面的横竖屏
/**
 可以横竖屏切换
 */
+ (void)allowOrientationAll {
    [[UIDevice currentDevice] setdtt_orientation:UIInterfaceOrientationMaskAll];
    
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;

    if (UIDeviceOrientationIsValidInterfaceOrientation(orientation)) {
        if (orientation == UIDeviceOrientationLandscapeRight) {
            [self dtt_setDeviceOrientationLandscapeLeft];
        } else if (orientation == UIDeviceOrientationLandscapeLeft) {
            [self dtt_setDeviceOrientationLandscapeRight];
        } else {
            [self dtt_setDeviceOrientationPortrait];
        }
    }
}

/**
 只能横屏
 */
+ (void)allowOrientationOnlyLandscape {
    [[UIDevice currentDevice] setdtt_orientation:UIInterfaceOrientationMaskLandscape];
    [self dtt_setDeviceOrientationLandscapeRight];
}

/**
 只能横屏
 */
+ (void)allowOrientationOnlyLandscapeLeft {
    [[UIDevice currentDevice] setdtt_orientation:UIInterfaceOrientationMaskLandscapeLeft];
    [self dtt_setDeviceOrientationLandscapeLeft];
}

/**
 只能横屏
 */
+ (void)allowOrientationOnlyLandscapeRight {
    [[UIDevice currentDevice] setdtt_orientation:UIInterfaceOrientationMaskLandscapeRight];
    [self dtt_setDeviceOrientationLandscapeRight];
}

/**
 只能竖屏
 */
+ (void)allowOrientationOnlyPortrait {
    [[UIDevice currentDevice] setdtt_orientation:UIInterfaceOrientationMaskPortrait];
    [self dtt_setDeviceOrientationPortrait];
}

/** 自动固定当前屏幕方向*/
+ (void)dtt_autoFitToCurrentOrientation {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (UIDeviceOrientationIsValidInterfaceOrientation(orientation)) {
        if (orientation == UIDeviceOrientationPortrait) {
            [UIDevice allowOrientationOnlyPortrait];
        } else if (orientation == UIDeviceOrientationLandscapeLeft) {
            [UIDevice allowOrientationOnlyLandscapeRight];
        } else if (orientation == UIDeviceOrientationLandscapeRight) {
            [UIDevice allowOrientationOnlyLandscapeLeft];
        }
    }
}

- (UIInterfaceOrientationMask)dtt_orientation {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setdtt_orientation:(UIInterfaceOrientationMask)dtt_orientation {
    objc_setAssociatedObject(self,
                             @selector(dtt_orientation),
                             @(dtt_orientation),
                             OBJC_ASSOCIATION_COPY);
}

/** 是否是iphoneX*/
- (BOOL)dtt_isiPhoneX {
    static BOOL _dtt_isiPhoneX = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dtt_isiPhoneX = [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO;
    });
    return _dtt_isiPhoneX;
}

#pragma mark - 设备信息
static NSString*    dtt_systVersion;
static NSString*    dtt_systVersionPatch;
static int          dtt_sysctl_err; // Sticky error after last call
+ (NSString*)dtt_machine {
    char str[256];
    size_t size = sizeof(str);
    dtt_sysctl_err = sysctlbyname("hw.machine", str, &size, NULL, 0);
    return strlen(str) ?[NSString stringWithCString:str encoding:NSASCIIStringEncoding] : @"";
}

+ (NSString*)dtt_model {
    char str[256];
    size_t size = sizeof(str);
    dtt_sysctl_err = sysctlbyname("hw.model", str, &size, NULL, 0);
    return strlen(str) ?[NSString stringWithCString:str encoding:NSASCIIStringEncoding] : @"";
}

+ (NSString*)dtt_cpu {
    
    int cputype;
    size_t size = sizeof(cputype);
    dtt_sysctl_err = sysctlbyname("hw.cputype", &cputype, &size, NULL, 0);
    
    
    switch (cputype) {
        case CPU_TYPE_MC680x0:
            return @"mc680x0";
        case CPU_TYPE_I386:
            return @"i386";
        case CPU_TYPE_X86_64:
            return @"x86_64";
        case CPU_TYPE_ARM:
            return @"arm";
        case CPU_TYPE_ARM64:
            return @"arm64";
        default:
            return @"unknown";
    }
}

+ (NSInteger)dtt_byteorder {
    int byteorder;
    size_t size = sizeof(byteorder);
    dtt_sysctl_err = sysctlbyname("hw.byteorder", &byteorder, &size, NULL, 0);
    return byteorder;
}

+ (NSString*)dtt_architecture {
    char str[256];
    size_t size = sizeof(str);
    dtt_sysctl_err = sysctlbyname("hw.arch", str, &size, NULL, 0);
    return strlen(str) ?[NSString stringWithCString:str encoding:NSASCIIStringEncoding] : @"";
}

+ (NSString*)kernelVersion {
    char str[256];
    size_t size = sizeof(str);
    dtt_sysctl_err = sysctlbyname("kern.version", str, &size, NULL, 0);
    return strlen(str) ?[NSString stringWithCString:str encoding:NSASCIIStringEncoding] : @"";
}

#pragma mark - System

+ (NSString*)kernelRelease {
    char str[256];
    size_t size = sizeof(str);
    dtt_sysctl_err = sysctlbyname("kern.osrelease", str, &size, NULL, 0);
    return strlen(str) ?[NSString stringWithCString:str encoding:NSASCIIStringEncoding] : @"";
}

+ (NSString*)kernelRevision {
    char str[256];
    size_t size = sizeof(str);
    dtt_sysctl_err = sysctlbyname("kern.osrev", str, &size, NULL, 0);
    return strlen(str) ?[NSString stringWithCString:str encoding:NSASCIIStringEncoding] : @"";
}

+ (NSString*)dtt_systemVersionPatch {
    NSOperatingSystemVersion opSystVersion = [[NSProcessInfo processInfo] operatingSystemVersion];
    if (!dtt_systVersionPatch) {
        dtt_systVersionPatch = [NSString stringWithFormat:@"%lu.%lu.%lu",(unsigned long)opSystVersion.majorVersion,(unsigned long)opSystVersion.minorVersion,(unsigned long)opSystVersion.patchVersion];
    }
    return dtt_systVersionPatch;
}

+ (NSString *)dtt_phoneModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if([platform isEqualToString:@"iPhone1,1"]) {
        return @"iPhone 2G";
    } else if([platform isEqualToString:@"iPhone1,2"]) {
        return @"iPhone 3G";
    } else if([platform isEqualToString:@"iPhone2,1"]) {
        return @"iPhone 3GS";
    } else if([platform isEqualToString:@"iPhone3,1"]) {
        return @"iPhone 4";
    } else if([platform isEqualToString:@"iPhone3,2"]) {
        return @"iPhone 4";
    } else if([platform isEqualToString:@"iPhone3,3"]) {
        return @"iPhone 4";
    } else if([platform isEqualToString:@"iPhone4,1"]) {
        return @"iPhone 4S";
    } else if([platform isEqualToString:@"iPhone5,1"]) {
        return @"iPhone 5";
    } else if([platform isEqualToString:@"iPhone5,2"]) {
        return @"iPhone 5";
    } else if([platform isEqualToString:@"iPhone5,3"]) {
        return @"iPhone 5c";
    } else if([platform isEqualToString:@"iPhone5,4"]) {
        return @"iPhone 5c";
    } else if([platform isEqualToString:@"iPhone6,1"]) {
        return @"iPhone 5s";
    } else if([platform isEqualToString:@"iPhone6,2"]) {
        return @"iPhone 5s";
    } else if([platform isEqualToString:@"iPhone7,1"]) {
        return @"iPhone 6 Plus";
    } else if([platform isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6";
    } else if([platform isEqualToString:@"iPhone8,1"]) {
        return @"iPhone 6s";
    } else if([platform isEqualToString:@"iPhone8,2"]) {
        return @"iPhone 6s Plus";
    } else if([platform isEqualToString:@"iPhone8,4"]) {
        return @"iPhone SE";
    } else if([platform isEqualToString:@"iPhone9,1"]) {
        return @"iPhone 7";
    } else if([platform isEqualToString:@"iPhone9,2"]) {
        return @"iPhone 7 Plus";
    } else if([platform isEqualToString:@"iPhone10,1"]) {
        return @"iPhone 8";
    } else if([platform isEqualToString:@"iPhone10,4"]) {
        return @"iPhone 8";
    } else if([platform isEqualToString:@"iPhone10,2"]) {
        return @"iPhone 8 Plus";
    } else if([platform isEqualToString:@"iPhone10,5"]) {
        return @"iPhone 8 Plus";
    } else if([platform isEqualToString:@"iPhone10,3"]) {
        return @"iPhone X";
    } else if([platform isEqualToString:@"iPhone10,6"]) {
        return @"iPhone X";
    } else if ([platform isEqualToString:@"iPhone11,8"]) {
        return @"iPhone XR";
    } else if ([platform isEqualToString:@"iPhone11,2"]) {
        return @"iPhone XS";
    } else if ([platform isEqualToString:@"iPhone11,4"]) {
        return @"iPhone XS Max";
    } else if ([platform isEqualToString:@"iPhone11,6"]) {
        return @"iPhone XS Max";
    } else if([platform isEqualToString:@"iPod1,1"]) {
        return @"iPod Touch 1G";
    } else if([platform isEqualToString:@"iPod2,1"]) {
        return @"iPod Touch 2G";
    } else if([platform isEqualToString:@"iPod3,1"]) {
        return @"iPod Touch 3G";
    } else if([platform isEqualToString:@"iPod4,1"]) {
        return @"iPod Touch 4G";
    } else if([platform isEqualToString:@"iPod5,1"]) {
        return @"iPod Touch 5G";
    } else if([platform isEqualToString:@"iPad1,1"]) {
        return @"iPad 1G";
    } else if([platform isEqualToString:@"iPad2,1"]) {
        return @"iPad 2";
    } else if([platform isEqualToString:@"iPad2,2"]) {
        return @"iPad 2";
    } else if([platform isEqualToString:@"iPad2,3"]) {
        return @"iPad 2";
    } else if([platform isEqualToString:@"iPad2,4"]) {
        return @"iPad 2";
    } else if([platform isEqualToString:@"iPad2,5"]) {
        return @"iPad Mini 1G";
    } else if([platform isEqualToString:@"iPad2,6"]) {
        return @"iPad Mini 1G";
    } else if([platform isEqualToString:@"iPad2,7"]) {
        return @"iPad Mini 1G";
    } else if([platform isEqualToString:@"iPad3,1"]) {
        return @"iPad 3";
    } else if([platform isEqualToString:@"iPad3,2"]) {
        return @"iPad 3";
    } else if([platform isEqualToString:@"iPad3,3"]) {
        return @"iPad 3";
    } else if([platform isEqualToString:@"iPad3,4"]) {
        return @"iPad 4";
    } else if([platform isEqualToString:@"iPad3,5"]) {
        return @"iPad 4";
    } else if([platform isEqualToString:@"iPad3,6"]) {
        return @"iPad 4";
    } else if([platform isEqualToString:@"iPad4,1"]) {
        return @"iPad Air";
    } else if([platform isEqualToString:@"iPad4,2"]) {
        return @"iPad Air";
    } else if([platform isEqualToString:@"iPad4,3"]) {
        return @"iPad Air";
    } else if([platform isEqualToString:@"iPad4,4"]) {
        return @"iPad Mini 2G";
    } else if([platform isEqualToString:@"iPad4,5"]) {
        return @"iPad Mini 2G";
    } else if([platform isEqualToString:@"iPad4,6"]) {
        return @"iPad Mini 2G";
    } else if([platform isEqualToString:@"iPad4,7"]) {
        return @"iPad Mini 3";
    } else if([platform isEqualToString:@"iPad4,8"]) {
        return @"iPad Mini 3";
    } else if([platform isEqualToString:@"iPad4,9"]) {
        return @"iPad Mini 3";
    } else if([platform isEqualToString:@"iPad5,1"]) {
        return @"iPad Mini 4";
    } else if([platform isEqualToString:@"iPad5,2"]) {
        return @"iPad Mini 4";
    } else if([platform isEqualToString:@"iPad5,3"]) {
        return @"iPad Air 2";
    } else if([platform isEqualToString:@"iPad5,4"]) {
        return @"iPad Air 2";
    } else if([platform isEqualToString:@"iPad6,3"]) {
        return @"iPad Pro 9.7";
    } else if([platform isEqualToString:@"iPad6,4"]) {
        return @"iPad Pro 9.7";
    } else if([platform isEqualToString:@"iPad6,7"]) {
        return @"iPad Pro 12.9";
    } else if([platform isEqualToString:@"iPad6,8"]) {
        return @"iPad Pro 12.9";
    } else if([platform isEqualToString:@"i386"]) {
        return @"iPhone Simulator";
    } else if([platform isEqualToString:@"x86_64"]) {
        return @"iPhone Simulator";
    }
    return @"unknow";
}

+ (NSString *)dtt_ip {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // 检索当前接口,在成功时,返回0
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // 循环链表的接口
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // 检查接口是否en0 wifi连接在iPhone上
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // 得到NSString从C字符串
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // 释放内存
    freeifaddrs(interfaces);
    return address;
}

+ (NSString *)dtt_phoneSystemName {
    static NSString *systemName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemName = [UIDevice currentDevice].systemName;
    });
    return systemName;
}

/** 手机运营商 */
+ (NSString *)dtt_mobileOperators {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    if (!carrier.isoCountryCode) {
        return @"无运营商";
    } else {
        return [carrier carrierName];
    }
}

/**
+(NSString*)dtt_systemVersion
{
    NSOperatingSystemVersion opSystVersion = [[NSProcessInfo processInfo] operatingSystemVersion];
    if (!dtt_systVersion) {
        dtt_systVersion = [NSString stringWithFormat:@"%lu.%lu",(unsigned long)opSystVersion.majorVersion,(unsigned long)opSystVersion.minorVersion];
    }
    return dtt_systVersion;
}

+(float)systemVersionFloat
{
    NSOperatingSystemVersion opSystVersion = [[NSProcessInfo processInfo] operatingSystemVersion];
    if (systVersionFloat==0.0f) {
        systVersionFloat = [[NSString stringWithFormat:@"%lu.%lu",(unsigned long)opSystVersion.majorVersion,(unsigned long)opSystVersion.minorVersion] floatValue];
    }
    return systVersionFloat;
}

+(float)systemVersionPatchFloat
{
    NSOperatingSystemVersion opSystVersion = [[NSProcessInfo processInfo] operatingSystemVersion];
    if (systVersionPatchFloat==0.0f) {
        systVersionPatchFloat = [[NSString stringWithFormat:@"%lu.%lu%lu",(unsigned long)opSystVersion.majorVersion,(unsigned long)opSystVersion.minorVersion,(unsigned long)opSystVersion.patchVersion] floatValue];
    }
    return systVersionPatchFloat;
}
*/
@end
