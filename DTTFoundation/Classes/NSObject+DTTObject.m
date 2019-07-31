//
//  NSObject+DTTObject.m
//  Pods
//
//  Created by dtt on 16/6/6.
//
//

#import "NSObject+DTTObject.h"
#import <objc/runtime.h>

NSString * DTTAvoidCrashExceptionNotification = @"DTTAvoidCrashExceptionNotification";

@implementation NSObject (DTTObject)

BOOL DTTIsEmpty(id obj)
{
    return ((obj) == nil || [(obj) isEqual:[NSNull null]]);
}

/*!
 *  不是空对象
 */
BOOL DTTIsNotEmpty(id obj) {
    
    return !DTTIsEmpty(obj);
}

//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    [anInvocation invokeWithTarget:@"111"];
//    NSLog(@"%c",anInvocation.methodSignature.methodReturnType);
////    id target = anInvocation.target;
//////    NSString * selString = NSStringFromSelector([anInvocation selector]);
////    SEL selector = anInvocation.selector;
////    NSString * selString = nil;
////    [anInvocation getArgument:&selString atIndex:1];
////    [anInvocation getArgument:&selString atIndex:0];
////    if ([self.voidNoParams containsObject:selString]) {
////        if ([selString isEqualToString:@"stringValue"]) {
////            [anInvocation invokeWithTarget:@""];
////        }
////    }
//    NSMethodSignature * signature = anInvocation.methodSignature;
//    NSUInteger argCount = [signature numberOfArguments];
//    for (NSInteger i=0 ; i<argCount ; i++) {
//        NSLog(@"%s" , [signature getArgumentTypeAtIndex:i]);
//    }
//    NSLog(@"returnType:%s ,returnLen:%d" , [signature methodReturnType] , [signature methodReturnLength]);
//    NSLog(@"signature:%@" , signature);
//}
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    
//    NSString * selString = NSStringFromSelector(aSelector);
//    if ([self.voidNoParams containsObject:selString]) {
//        return [NSMethodSignature signatureWithObjCTypes:"*@"];
//    }
//    
//    return nil;
//}

+ (void)exchangeInstanceMethod:(Class)aClass method:(SEL)oriMethod toMethod:(SEL)newMethod {
    Method origin = class_getInstanceMethod(aClass, oriMethod);
    Method new = class_getInstanceMethod(aClass, newMethod);
    method_exchangeImplementations(origin, new);
}

+ (void)exchangeClassMethod:(SEL)oriMethod toMethod:(SEL)newMethod {
    [NSObject exchangeClassMethod:[self class] method:oriMethod toMethod:newMethod];
}

+ (void)exchangeClassMethod:(Class)aClass method:(SEL)oriMethod toMethod:(SEL)newMethod {
    Method origin = class_getClassMethod(aClass, oriMethod);
    Method new = class_getClassMethod(aClass, newMethod);
    method_exchangeImplementations(origin, new);
}

+ (void)exchangeInstanceMethod:(SEL)oriMethod toMethod:(SEL)newMethod {
    [NSObject exchangeInstanceMethod:[self class] method:oriMethod toMethod:newMethod];
}

+ (void)notiException:(NSException *)exception appendingInfo:(NSString *)info {
    if (NO == [exception isKindOfClass:[NSException class]]) {
        return;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:DTTAvoidCrashExceptionNotification object:exception];
}

- (void)notiException:(NSException *)exception appendingInfo:(NSString *)info {
    [[self class] notiException:exception appendingInfo:info];
}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    
//    if ([self respondsToSelector:aSelector]) {
//        return self;
//    }
//#ifndef DEBUG
//    [NSObject notiException:[NSException unrecognizedSelectorExceptionWithInstance:self forMethod:aSelector] appendingInfo:nil];
//    BOOL addSucces = class_addMethod([DTTUnrecognizeSelectorObject class], aSelector, (IMP)dtt_forwardDefaultMethod, "L@:@");
//    if (addSucces) {
//        NSLog(@"添加成功");
//    }
//
//    return [DTTUnrecognizeSelectorObject sharedObj];
//#else
//    return self;
//#endif
//}

#pragma mark - 类型判断
- (BOOL)dtt_isNSDictionary {
    return [self isKindOfClass:[NSDictionary class]];
}

- (BOOL)dtt_isNSArray {
    return [self isKindOfClass:[NSArray class]];
}

- (BOOL)dtt_isNSString {
    return [self isKindOfClass:[NSString class]];
}

- (BOOL)dtt_isNSNumber {
    return [self isKindOfClass:[NSNumber class]];
}

- (BOOL)dtt_isNSNumberBool {
    if(self == (id)kCFBooleanFalse || self == (id)kCFBooleanTrue) {
        return YES;
    }
    
    return NO;
}

- (BOOL)dtt_isNSDate {
    return [self isKindOfClass:[NSDate class]];
}

- (BOOL)dtt_isNSNull {
    return [self isKindOfClass:[NSNull class]];
}

- (BOOL)dtt_isUIViewController {
    return [self isKindOfClass:[UIViewController class]];
}
- (BOOL)dtt_isUINavigationController {
    return [self isKindOfClass:[UINavigationController class]];
}

- (BOOL)dtt_isNSError {
    return [self isKindOfClass:[NSError class]];
}

#pragma mark - 转换
- (NSString *)dtt_toString {
    return @"";
}
- (NSNumber *)dtt_toNumber {
    return @0;
}
/**
 转义字符
 */
- (id)dtt_replacingPercentEscapes {
    return self;
}

#pragma mark - 系统判断

/** iOS11*/
- (BOOL)dtt_iOS11Available {
    if(@available(iOS 11.0,*)) {
        return YES;
    }
    return NO;
}

- (BOOL)dtt_iOS10Available {
    if (@available(iOS 10.0,*)) {
        return YES;
    }
    return NO;
}

@end




