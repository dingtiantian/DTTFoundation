//
//  DTTTimerProxy.m
//  DataBaseDemo
//
//  Created by dtt on 2016/11/16.
//  Copyright © 2016年 majian. All rights reserved.
//

#import "DTTTimerProxy.h"

@interface DTTTimerProxy ()
@property (nonatomic,weak) id target;
@end

@implementation DTTTimerProxy

- (instancetype)initWithTarget:(id)aTarget {
    _target = aTarget;
    return self;
}
+ (instancetype)proxyWithTarget:(id)aTarget {
    return [[DTTTimerProxy alloc] initWithTarget:aTarget];
}
- (id)forwardingTargetForSelector:(SEL)selector {
    return _target;
}
- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}
- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_target respondsToSelector:aSelector];
}
- (BOOL)isEqual:(id)object {
    return [_target isEqual:object];
}
- (NSUInteger)hash {
    return [_target hash];
}
- (Class)superclass {
    return [_target superclass];
}
- (Class)class {
    return [_target class];
}
- (BOOL)isKindOfClass:(Class)aClass {
    return [_target isKindOfClass:aClass];
}
- (BOOL)isMemberOfClass:(Class)aClass {
    return [_target isMemberOfClass:aClass];
}
- (BOOL)conformsToProtocol:(Protocol *)aProtocol {
    return [_target conformsToProtocol:aProtocol];
}
- (BOOL)isProxy {
    return YES;
}
- (NSString *)description {
    return [_target description];
}
- (NSString *)debugDescription {
    return [_target debugDescription];
}
@end
