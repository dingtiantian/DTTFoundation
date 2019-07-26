//
//  NSArray+DTTArray.m
//  DTTFoundation
//
//  Created by admin on 2019/7/26.
//

#import "NSArray+DTTArray.h"

@implementation NSArray (DTTArray)
BOOL DTTIsEmptyArray(NSArray *array) {
    if (DTTIsEmpty(array) || NO == [array dtt_isNSArray]) {
        return YES;
    }
    
    return array.count == 0;
}

/**
 *  不是空数组
 */
BOOL DTTIsNotEmptyArray(NSArray *array) {
    return !DTTIsEmptyArray(array);
}

NSArray * DTTNoNilArray(id array) {
    if (DTTIsEmpty(array)) return @[];
    return array;
}

/*!
 *  删除第一个元素
 */
- (NSArray *)dtt_removeFirstObject {
    if (self.count <= 1) return @[];
    return [self subarrayWithRange:NSMakeRange(1, self.count - 1)];
}

- (NSArray *)dtt_insertObjectAtFirst:(id)obj {
    if (DTTIsEmpty(obj)) return self;
    return [@[obj] arrayByAddingObjectsFromArray:self];
}

- (NSArray *)dtt_insertObjectAtLast:(id)obj {
    if (DTTIsEmpty(obj)) return self;
    return [self arrayByAddingObject:obj];
}

/** 转成可变字典，如果本身是NSArray，则执行mutableCopy方法，
 如果是NSMutableArray，则直接返回*/
- (NSMutableArray*)dtt_toMutable {
    if ([self isKindOfClass:[NSMutableArray class]]) return self;
    return self.mutableCopy;
}

/*!
 *  删除最后一个元素
 */
- (NSArray *)dtt_removeLastObject {
    if (self.count <= 1) return @[];
    return [self subarrayWithRange:NSMakeRange(0, self.count - 1)];
}

/*!
 *  删除存在的指定元素
 */
- (NSArray *)dtt_removeObjectIfExists:(_Nonnull id)obj {
    if (NO == [self containsObject:obj]) return self;
    NSMutableArray * aArrayM = [[NSMutableArray alloc] initWithArray:self];
    if ([aArrayM containsObject:obj]) {
        [aArrayM removeObject:obj];
    }
    return aArrayM;
}

/*!
 *  删除指定索引的元素
 */
- (NSArray *)dtt_removeObjectAtIndex:(NSInteger)index {
    
    if (self.count <= 0) {
        return self;
    }
    
    if (NO == [self dtt_isValidIndex:index]) {
        return self;
    }
    
    id obj = self[index];
    return [self dtt_removeObjectIfExists:obj];
}

/**
 第一个元素
 */
- (id)dtt_firstObject {
    if (DTTIsNotEmptyArray(self)) {
        return self.firstObject;
    }
    return nil;
}

/**
 最后一个元素
 */
- (id)dtt_lastObject {
    if (DTTIsNotEmptyArray(self)) {
        return self.lastObject;
    }
    
    return nil;
}


/*!
 *  删除元素组
 */
- (NSArray *)dtt_removeObjects:(NSArray *)objs {
    NSMutableArray * aArrayM = [[NSMutableArray alloc] initWithArray:self];
    for (id obj in objs) {
        if ([aArrayM containsObject:obj]) {
            [aArrayM removeObject:obj];
        }
    }
    
    return aArrayM;
}

/**
 从 0 到 toIndex，不包含toIndex所指向的元素
 */
- (NSArray *)dtt_subArrayToIndex:(NSUInteger)toIndex {
    if ([self dtt_isValidIndex:(toIndex - 1)]) {
        NSUInteger count = toIndex;
        return [self subarrayWithRange:NSMakeRange(0, count)];
    }
    
    return @[];
}
/**
 从 fromIndex 到 最后一个元素，包含fromIndex所指向的元素
 */
- (NSArray *)dtt_subArrayFromIndex:(NSUInteger)fromIndex {
    if ([self dtt_isValidIndex:fromIndex]) {
        return [self subarrayWithRange:NSMakeRange(fromIndex, self.count - fromIndex)];
    }
    
    return @[];
}

/**
 不包含obj
 */
- (NSArray *)dtt_subArrayToObject:(id)obj {
    if (DTTIsNotEmpty(obj)) {
        return [self dtt_subArrayToIndex:[self indexOfObject:obj]];
    }
    
    return @[];
}
/**
 包含obj
 */
- (NSArray *)dtt_subArrayFromObject:(id)obj {
    if (DTTIsNotEmpty(obj)) {
        return [self dtt_subArrayFromIndex:[self indexOfObject:obj]];
    }
    return @[];
}


- (NSArray *)dtt_reversedObjects {
    
    if (self.count <= 1) {
        return self;
    }
    
    return [self reverseObjectEnumerator].allObjects;
}

/**
 *  取到对应索引的对象，如果index越界会返回cls的实例
 */
- (id)dtt_objectAtIndex:(NSInteger)index class:(Class)cls {
    
    if ([self dtt_isValidIndex:index]) {
        
        return self[index];
    }
    
    return [[cls alloc] init];
}

- (BOOL)dtt_isValidIndex:(NSInteger)index {
    
    return (index >= 0 && index < self.count);
}

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
        // for-in all objects
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    
    [str appendString:@"]"];
    
        // range of the last ','
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
            // remove the last ','
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

/**
 NSArray ==> NSSet
 */
- (NSSet *)dtt_toSet {
    return [NSSet setWithArray:self];
}
/**
 NSArray ==> NSMutableSett
 */
- (NSMutableSet *)dtt_toMutableSet {
    return [NSMutableSet setWithArray:self];
}
/**
 组合Array，允许相同obj存在
 */
- (NSArray *)dtt_appendingArray:(NSArray * _Nullable)aArray {
    if (DTTIsEmptyArray(aArray)) {
        return self;
    }
    if (DTTIsEmptyArray(self)) {
        return aArray;
    }
    return [self arrayByAddingObjectsFromArray:aArray];
}
- (NSArray *)dtt_appendingObject:(NSObject * _Nullable)aObj {
    if (DTTIsEmpty(aObj)) {
        return self;
    }
    return [self dtt_appendingArray:@[aObj]];
}
/**
 组合Array，obj唯一
 */
- (NSArray *)dtt_appendingArrayUnique:(NSArray * _Nullable)aArray {
    if (DTTIsEmptyArray(aArray)) {
        return self;
    }
    if (DTTIsEmptyArray(self)) {
        return aArray;
    }
    
    NSMutableArray * selfArrayM = [self mutableCopy];
    for (id obj in aArray) {
        if (NO == [self containsObject:obj]) {
            [selfArrayM addObject:obj];
        }
    }
    return [selfArrayM copy];
}
- (NSArray *)dtt_appendingObjectUnique:(NSObject *_Nullable)aObj {
    if (DTTIsEmpty(aObj)) {
        return self;
    }
    return [self dtt_appendingArrayUnique:@[aObj]];
}

/**
 是否包含aArray中的所有元素，不关心顺序
 */
- (BOOL)dtt_containArray:(NSArray *_Nullable)aArray {
    if (DTTIsEmptyArray(aArray)) {
        return NO;
    }
    __block BOOL contain = YES;
    [aArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NO == [self containsObject:obj]) {
            contain = NO;
            *stop = YES;
        }
    }];
    return contain;
}

#pragma mark - "循环"获取前一个/后一个索引/对象
/**
 获取前一个对象索引
 */
- (NSUInteger)dtt_preIndexForObject:(nullable id)obj {
    NSUInteger curIndex = [self indexOfObject:obj];
    NSUInteger preIndex = curIndex;
    if (curIndex != NSNotFound) {
        preIndex = (curIndex - 1 + self.count) % self.count;
    }
    
    return preIndex;
}
/**
 获取前一个对象
 */
- (id)dtt_preObjectForObject:(nullable id)obj {
    NSUInteger preIndex = [self dtt_preIndexForObject:obj];
    if ([self dtt_isValidIndex:preIndex]) {
        return [self objectAtIndex:preIndex];
    }
    return nil;
}
/**
 获取后一个对象索引
 */
- (NSUInteger)dtt_nextIndexForObject:(nullable id)obj {
    NSUInteger curIndex = [self indexOfObject:obj];
    NSUInteger nextIndex = curIndex;
    if (curIndex != NSNotFound) {
        nextIndex = (curIndex + 1) % self.count;
    }
    
    return nextIndex;
}
/**
 获取后一个对象
 */
- (id)dtt_nextObjectForObject:(nullable id)obj {
    NSUInteger nextIndex = [self dtt_nextIndexForObject:obj];
    if ([self dtt_isValidIndex:nextIndex]) {
        return [self objectAtIndex:nextIndex];
    }
    return nil;
}

/**
 转义字符
 */
- (id)dtt_replacingPercentEscapes {
    NSMutableArray * params = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [params addObject:[obj dtt_replacingPercentEscapes]];
    }];
    return [params copy];
}

@end
