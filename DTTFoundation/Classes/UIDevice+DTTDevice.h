//
//  UIDevice+DTTDevice.h
//  Pods
//
//  Created by dtt on 16/6/7.
//
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
/**  是否是模拟器 */
extern BOOL DTTIsSimulater(void);

/**  是否是真机 */
extern BOOL DTTIsPhysical(void);

/**  是否是单元测试 */
extern BOOL DTTIsRunningTests(void);

@interface UIDevice (DTTDevice)

/**  iOS系统版本 */
+ (CGFloat)dtt_systemVersion;

+ (BOOL)dtt_greaterThan:(NSString *)sysVer;
+ (BOOL)dtt_lessThan:(NSString *)sysVer;

/** 系统大于6.0 */
+ (BOOL)dtt_greaterThan6;
/** 系统版本小于6.0 */
+ (BOOL)dtt_lessThan6;

/** 系统大于7.0 */
+ (BOOL)dtt_greaterThan7;
/** 系统版本小于7.0 */
+ (BOOL)dtt_lessThan7;

/** 系统大于8.0 */
+ (BOOL)dtt_greaterThan8;
/** 系统版本小于8.0 */
+ (BOOL)dtt_lessThan8;

/** 系统大于9.0 */
+ (BOOL)dtt_greaterThan9;
/** 系统版本小于9.0 */
+ (BOOL)dtt_lessThan9;

/** 系统大于10.0 */
+ (BOOL)dtt_greaterThan10;
/** 系统版本小于10.0 */
+ (BOOL)dtt_lessThan10;

/**  是否是模拟器 */
+ (BOOL)dtt_isSimulator;

/**  是否是真机 */
+ (BOOL)dtt_isPhysical;

/**  设置当前设备横竖屏方向 */
+ (void)dtt_setDeviceOrientation:(UIInterfaceOrientation)orientation;

/**  强制横屏 */
+ (void)dtt_setDeviceOrientationLandscapeRight;

/**  强制横屏 */
+ (void)dtt_setDeviceOrientationLandscapeLeft;

/**  强制竖屏 */
+ (void)dtt_setDeviceOrientationPortrait;

#pragma mark - 控制app界面的横竖屏
/** 可以横竖屏切换，不切换屏幕方向的情况下，会保持当前屏幕的方向 */
+ (void)allowOrientationAll;

/** 只能横屏 */
+ (void)allowOrientationOnlyLandscape;

/** 只能横屏 */
+ (void)allowOrientationOnlyLandscapeRight;

/** 只能横屏 */
+ (void)allowOrientationOnlyLandscapeLeft;

/** 自动固定当前屏幕方向*/
+ (void)dtt_autoFitToCurrentOrientation;

/** 只能竖屏 */
+ (void)allowOrientationOnlyPortrait;
@property (nonatomic,assign,readonly) UIInterfaceOrientationMask dtt_orientation;

/** 获取旋转角度*/
+ (CGAffineTransform)dtt_getTransformRotationAngle:(UIInterfaceOrientation)orientation;

/** 是否是iphoneX*/
- (BOOL)dtt_isiPhoneX;

#pragma mark - 设备信息
+ (NSString*)dtt_machine;

+ (NSString*)dtt_model;

+ (NSString*)dtt_cpu;

+ (NSInteger)dtt_byteorder;

+ (NSString*)dtt_architecture;

+ (NSString*)kernelVersion;

+ (NSString*)kernelRelease;

+ (NSString*)kernelRevision;

+ (NSString*)dtt_systemVersionPatch;

/** 手机机型 */
+ (NSString *)dtt_phoneModel;

/** ip */
+ (NSString *)dtt_ip;

/** 手机操作系统 */
+ (NSString *)dtt_phoneSystemName;

/** 手机运营商 */
+ (NSString *)dtt_mobileOperators;

@end
NS_ASSUME_NONNULL_END
