//
//  DTTFoundationMacros.h
//  Pods
//
//  Created by majian on 16/6/6.
//
//

#ifndef DTTFoundationMacros_h
#define DTTFoundationMacros_h
#import <Foundation/Foundation.h>

#ifndef DTTTOCOMPLETEMETHODS
#define DTTTOCOMPLETEMETHODS
/** 拼接图片完整地址*/
extern NSString* dtt_toCompleteImagePath(NSString* halfPath);
/** 拼接图片完整地址，指定宽高*/
extern NSString* dtt_toCompleteSizeImagePath(NSString* halfPath,int targetWidth,int targetHeight);
/** 拼接视频完整地址*/
extern NSString* dtt_toCompleteVideoPath(NSString* halfPath);
/** 拼接语音完整地址*/
extern NSString* dtt_toCompleteVoicePath(NSString* halfPath);
#endif

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil;
#endif

/*!
 *  主线程_异步_执行
 */
#ifndef dtt_dispatch_async_main_execute
#define dtt_dispatch_async_main_execute(block)                          \
    if ([NSThread isMainThread]) {                                      \
        block();                                                        \
    } else {                                                            \
        dispatch_async(dispatch_get_main_queue(), block);               \
    }
#endif

/*!
 *  主线程_同步_执行
 */
#ifndef dtt_dispatch_sync_main_execute
#define dtt_dispatch_sync_main_execute(block)                           \
    if ([NSThread isMainThread]) {                                      \
        block();                                                        \
    } else {                                                            \
        dispatch_sync(dispatch_get_main_queue(), block);                \
    }
#endif

#define kDTTCreateExternString(key) FOUNDATION_EXTERN NSString* const key ;
#define kDTTImplementionExtern(key,value) NSString* const key = value ;

#define DTTLog(format, ...) NSLog((@"\nfunc:%s" "line:%d\n" "💬" format "\n\n"), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define DTTLogFunc NSLog((@"\nfunc:%s" "line:%d\n" "\n"), __FUNCTION__, __LINE__)

// result macro
#define DTTLogBOOL(BOOL) NSLog((@"\nfunc:%s" "line:%d\n" "%@" "\n\n"), __FUNCTION__, __LINE__, BOOL ? @"🔵Success" : @"🔴Fail")

#define DTTLogSuccess(format, ...) NSLog((@"\nfunc:%s" "line:%d\n" "🔵success: " format "\n\n"), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define DTTLogFail(format, ...) NSLog((@"\nfunc:%s" "line:%d\n" "🔴error: " format "\n\n"), __FUNCTION__, __LINE__, ##__VA_ARGS__)

// obj macro
#define ATLogOBJ(NSObject) NSLog((@"\nfunc:%s" "line:%d\n" "💬%@" "\n\n"), __FUNCTION__, __LINE__, NSObject)


// CG macro
#define DTTLogNSInteger(NSInteger) NSLog((@"\nfunc:%s" "line:%d\n" "💬%ld" "\n\n"), __FUNCTION__, __LINE__, NSInteger)
#define DTTLogNSUInteger(NSUInteger) NSLog((@"\nfunc:%s" "line:%d\n" "💬%lld" "\n\n"), __FUNCTION__, __LINE__, NSUInteger)

#define DTTLogCGFloat(CGFloat) NSLog((@"\nfunc:%s" "line:%d\n" "💬%f" "\n\n"), __FUNCTION__, __LINE__, CGFloat)
#define DTTLogCGPoint(CGPoint) NSLog((@"\nfunc:%s" "line:%d\n" "💬%@" "\n\n"), __FUNCTION__, __LINE__, NSStringFromCGPoint(CGPoint))

#define DTTLogCGSize(CGSize) NSLog((@"\nfunc:%s" "line:%d\n" "💬%@" "\n\n"), __FUNCTION__, __LINE__, NSStringFromCGSize(CGSize))
#define DTTLogCGRect(CGRect) NSLog((@"\nfunc:%s" "line:%d\n" "💬%@" "\n\n"), __FUNCTION__, __LINE__, NSStringFromCGRect(CGRect))

/** 自动创建对象*/
#ifndef DTTLazyCreateInstanceAuto
#define DTTLazyCreateInstanceAuto(class,name)                           \
    - (class*)name {                                                    \
        if (_##name == nil) _##name = [class new]; return _##name;      \
    }
#endif

/** 创建可变数组*/
#ifndef DTTLazyCreateMutableArray
    #define DTTLazyCreateMutableArray(name) DTTLazyCreateInstanceAuto(NSMutableArray,name)
#endif

/** 创建可变字典*/
#ifndef DTTLazyCreateMutableDictionary
    #define DTTLazyCreateMutableDictionary(name) DTTLazyCreateInstanceAuto(NSMutableDictionary,name)
#endif

/** 自动初始化对象*/
#ifndef DTTLazyCreateInstanceManual
#define DTTLazyCreateInstanceManual(class,name,initCode)                \
    - (class*)name {                                                    \
        if (_##name == nil) _##name = initCode; return _##name;         \
    }
#endif

/** 手动初始化对象*/
#ifndef DTTLazyCreateInstanceManualMore
#define DTTLazyCreateInstanceManualMore(class,name,moreCode)            \
    - (class*)name {                                                    \
        if (_##name == nil) {                                           \
            moreCode                                                    \
        }                                                               \
        return _##name;                                                 \
    }
#endif

#undef DTTSingletonInterface
/**
 单例定义
 */
#define DTTSingletonInterface()                                         \
+ (instancetype)sharedInstance;

#ifndef DTTSingletonImplementation
#define DTTSingletonImplementation(__Class)                             \
    + (instancetype)sharedInstance {                                    \
        static __Class * _instance = nil;                               \
        static dispatch_once_t onceToken;                               \
        dispatch_once(&onceToken, ^{                                    \
            _instance = [[super allocWithZone:NULL] init];              \
        });                                                             \
        return _instance;                                               \
    }                                                                   \
    + (instancetype)allocWithZone:(struct _NSZone *)zone {              \
        return [__Class sharedInstance];                                \
    }                                                                   \
    - (id)copyWithZone:(struct _NSZone *)zone {                         \
        return [__Class sharedInstance];                                \
    }
#endif /* DTTFoundationMacros_h */

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
            #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif


#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
            #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif

#ifndef dtt_CUSTOM_HANDLER
#define dtt_CUSTOM_HANDLER

/** 无参 无返回*/
typedef void (^DTTVoidCallback)(void);
#define DTTInvokeBlock(block) if(block) { block();}
#define DTTInvokeVoidBlock(block) if(block) { block();}

/** 无参 一返回*/
typedef id(^DTTOneReturnCallback)(void);

/** 一参 一返回*/
typedef id(^DTTOneParamReturnCallback)(id);

/** 一参 无返回*/
typedef void(^DTTOneParamCallback)(id);

/** 两参 一返回*/
typedef id(^DTTTwoParamReturnCallback)(id,id);

/** 两参 无返回*/
typedef void(^DTTTwoParamCallback)(id,id);

/** 三参 一返回*/
typedef id(^DTTThreeParamReturnCallback)(id,id,id);

/** 三参 无返回*/
typedef void(^DTTThreeParamCallback)(id,id,id);

#endif

#ifndef dtt_PROPERTY_DEFINE
#define dtt_PROPERTY_DEFINE
    #define dtt_PROPERTY_STRING(s)                              \
        @property (nonatomic,copy) NSString* (s);

    #define dtt_PROPERTY_ARRAY(s)                               \
        @property (nonatomic,copy) NSArray* (s);

    #define dtt_PROPERTY_MUTABLE_ARRAY(s)                       \
        @property (nonatomic,strong) NSMutableArray* (s);

    #define dtt_PROPERTY_DICTIONARY(s)                          \
        @property (nonatomic,copy) NSDictionary* (s);

    #define dtt_PROPERTY_MUTABLE_DICTIONARY(s)                  \
        @property (nonatomic,strong) NSMutableDictionary* (s);

    #define dtt_PROPERTY_NUMBER(s)                              \
        @property (nonatomic,copy) NSNumber* (s);

    #define dtt_PROPERTY_FLOAT(s)                               \
        @property (nonatomic,assign) CGFloat (s);

    #define dtt_PROPERTY_INTEGER(s)                             \
        @property (nonatomic,assign) NSInteger (s);

    #define dtt_PROPERTY_UINTEGER(s)                            \
        @property (nonatomic,assign) NSUInteger (s);

    #define dtt_PROPERTY_LONG_LONG(s)                           \
        @property (nonatomic,assign) long long (s);

    #define dtt_PROPERTY_BLOCK(type,s)                          \
        @property (nonatomic,copy) type s;
#endif

#endif









