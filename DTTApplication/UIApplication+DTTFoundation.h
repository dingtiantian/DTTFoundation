//
//  UIApplication+DTTFoundation.h
//  DTTFoundation
//
//  Created by admin on 2019/7/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (DTTFoundation)
/** 应用id*/
+ (NSString *)dtt_bundleId;

/** 应用版本号*/
+ (NSString *)dtt_version;

/** 应用build号,剔除所有小数点*/
+ (NSString *)dtt_buildNumber;

/** 应用build号*/
+ (NSString *)dtt_fullBuildNumber;
@end

NS_ASSUME_NONNULL_END
