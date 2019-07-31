//
//  DTTFoundationShorthandMarcos.h
//  DTTFoundation
//
//  Created by dtt on 2018/8/17.
//

#ifndef DTTFoundationShorthandMarcos_h
#define DTTFoundationShorthandMarcos_h
#import <Foundation/Foundation.h>

/** 判断代理能不能执行 */
static inline BOOL DTTIsRespondsToSelector(id<NSObject> delegate, SEL sel) {
    return (delegate && [delegate respondsToSelector:sel]);
}

/** 判断某个类里面时候包含此协议 */
static inline BOOL DTTIsConformsToProtocol(id object, Protocol *protocol) {
    return [[object class] conformsToProtocol:protocol];
}


#endif /* DTTFoundationShorthandMarcos_h */
