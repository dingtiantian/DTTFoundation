//
//  NSMutableArray+DTTMutableArray.m
//  Pods
//
//  Created by majian on 16/6/20.
//
//

#import "NSMutableArray+DTTMutableArray.h"

#import <DTTFoundation/NSObject+DTTObject.h>
#import <DTTFoundation/NSArray+DTTArray.h>

@implementation NSMutableArray (DTTMutableArray)

/**
 *  添加一个元素,如果传入的Obj为空，会自动添加一个相应cls非空的实例
 */
- (NSMutableArray *)dtt_addObject:(_Nullable id)obj class:(_Nonnull Class)cls {
    id object = obj;
    
    if (DTTIsEmpty(object)) {
//        DTTLogWarn(@"传入的obj为空");
//        object = [[cls alloc] init];
        if ([NSString class]) {
            
        }
        [cls dtt_noNilObject];
    }
    
    [self addObject:object];
    return self;
}

/**
 *  添加一个元素，如果传入的obj为空，则忽略
 */
- (NSMutableArray *)dtt_addObject:(_Nullable id)obj {
    
    id object = obj;
    
    if (DTTIsEmpty(object)) {
        
//        DTTLogWarn(@"传入的obj为空");
        return self;
    }
    
    [self addObject:object];
    
    return self;
}

- (NSMutableArray *)dtt_removeObjects:(NSArray *)objs {
    
    return nil;
}

/**
 移除第一个元素
 */
- (NSMutableArray *)dtt_removeFirstObject {
    if (DTTIsNotEmptyArray(self)) {
        [self removeObjectAtIndex:0];
    }
    
    return self;
}

- (NSMutableArray *)dtt_removeLastObject {
    if (DTTIsNotEmptyArray(self)) {
        [self removeLastObject];
    }
    return self;
}

//- (NSMutableArray *)dtt_insertObjectAtFirst:(id)obj {
//    if (DTTIsEmpty(obj)) {
//        return self;
//    }
//    
//    [self insertObject:obj atIndex:0];
//    return self;
//}

/**
 在数组的最后添加元素
 */
- (NSMutableArray *)dtt_insertObjectAtLast:(id)obj {
    if (DTTIsEmpty(obj)) {
        return self;
    }
    
    [self addObject:obj];
    return self;
}


@end












