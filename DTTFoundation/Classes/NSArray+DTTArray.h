//
//  NSArray+DTTArray.h
//  DTTFoundation
//
//  Created by admin on 2019/7/26.
//

#import <Foundation/Foundation.h>
#import <DTTFoundation/NSObject+DTTObject.h>

NS_ASSUME_NONNULL_BEGIN
/**  是否是空数组 */
extern BOOL DTTIsEmptyArray(NSArray *array);

/**  不是空数组 */
extern BOOL DTTIsNotEmptyArray(NSArray *array);

/**  防止出现空数组 */
extern NSArray * _Nonnull DTTNoNilArray(id array);

@interface NSArray (DTTArray)

/**  删除存在的指定元素 */
- (NSArray *)dtt_removeObjectIfExists:(_Nonnull id)obj;

/**  删除指定索引的元素 */
- (NSArray *)dtt_removeObjectAtIndex:(NSInteger)index;

/** 转成可变字典，如果本身是NSArray，则执行mutableCopy方法，
 如果是NSMutableArray，则直接返回*/
- (NSMutableArray*)dtt_toMutable;

/** 第一个元素 */
- (id)dtt_firstObject;

/** 最后一个元素 */
- (id)dtt_lastObject;

/** 移除第一个元素 */
- (NSArray *)dtt_removeFirstObject;
- (NSArray *)dtt_removeLastObject;

/** 在 index = 0 插入一个元素 */
- (NSArray *)dtt_insertObjectAtFirst:(id)obj;

/** 在数组的最后添加元素 */
- (NSArray *)dtt_insertObjectAtLast:(id)obj;

/**  删除元素组 */
- (NSArray *)dtt_removeObjects:(NSArray *)objs;

/** 从 0 到 toIndex，不包含toIndex所指向的元素 */
- (NSArray *)dtt_subArrayToIndex:(NSUInteger)toIndex;
/** 从 fromIndex 到 最后一个元素，包含fromIndex所指向的元素 */
- (NSArray *)dtt_subArrayFromIndex:(NSUInteger)fromIndex;
/** 不包含obj */
- (NSArray *)dtt_subArrayToObject:(id)obj;
/** 包含obj */
- (NSArray *)dtt_subArrayFromObject:(id)obj;

/* *  翻转数组：如：[@1,@2,@3] ====> [@3,@2,@1] */
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray * _Nonnull dtt_reversedObjects;

/**  取到对应索引的对象，如果index越界会返回cls的实例 */
- (id)dtt_objectAtIndex:(NSInteger)index class:(Class)cls;

/**  是否是有效的索引 */
- (BOOL)dtt_isValidIndex:(NSInteger)index;

/* NSArray ==> NSSet */
- (NSSet *)dtt_toSet;
/** NSArray ==> NSMutableSett */
- (NSMutableSet *)dtt_toMutableSet;
/** 组合Array，允许相同obj存在 */
- (NSArray *)dtt_appendingArray:(NSArray * _Nullable)aArray;
- (NSArray *)dtt_appendingObject:(NSObject * _Nullable)aObj;
/** 组合Array，obj唯一 */
- (NSArray *)dtt_appendingArrayUnique:(NSArray * _Nullable)aArray;
- (NSArray *)dtt_appendingObjectUnique:(NSObject *_Nullable)aObj;

/** 是否包含aArray中的所有元素，不关心顺序 */
- (BOOL)dtt_containArray:(NSArray *_Nullable)aArray;

#pragma mark - "循环"获取前一个/后一个索引/对象
/** 获取前一个对象索引，找不到为NSNotFound */
- (NSUInteger)dtt_preIndexForObject:(nullable id)obj;
/** 获取前一个对象,找不到为nil */
- (id)dtt_preObjectForObject:(nullable id)obj;
/** 获取后一个对象索引,找不到为NSNotFound */
- (NSUInteger)dtt_nextIndexForObject:(nullable id)obj;
/** 获取后一个对象,找不到为nil */
- (id)dtt_nextObjectForObject:(nullable id)obj;

#pragma mark - 转义
/** 转义字符 */
- (id)dtt_replacingPercentEscapes;

@end

NS_ASSUME_NONNULL_END
