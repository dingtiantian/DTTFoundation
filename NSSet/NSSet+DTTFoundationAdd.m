//
//  NSSet+DTTFoundationAdd.m
//  Pods
//
//  Created by majian on 2017/4/11.
//
//

#import "NSSet+DTTFoundationAdd.h"

BOOL DTTIsEmptySet(NSSet *set) {
    if (DTTIsEmptyArray([set dtt_toArray])) {
        return YES;
    }
    
    return NO;
}

BOOL DTTIsNotEmptySet(NSSet *set) {
    return !DTTIsEmptySet(set);
}

@implementation NSSet (DTTFoundationAdd)

- (NSArray *)dtt_toArray {
    return self.allObjects;
}

- (NSMutableArray *)dtt_toMutableArray {
    return self.allObjects.mutableCopy;
}

- (NSSet *)dtt_removeObject:(id)obj {
    if (DTTIsEmpty(obj) || DTTIsEmptySet(self)) {
        return self;
    }
    
    NSMutableSet * setM = [self mutableCopy];
    [setM minusSet:[NSSet setWithObject:obj]];
    return setM;
}

@end
