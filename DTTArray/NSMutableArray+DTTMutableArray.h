//
//  NSMutableArray+DTTMutableArray.h
//  Pods
//
//  Created by majian on 16/6/20.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DTTNoNilObjectProtocol <NSObject>

+ (nonnull id)dtt_noNilObject;

@end

@interface NSMutableArray (DTTMutableArray)

/**  添加一个元素,如果传入的Obj为空，会自动添加一个相应cls非空的实例 */
- (NSMutableArray *)dtt_addObject:(_Nullable id)obj class:(_Nonnull Class)cls;

/**  添加一个元素，如果传入的obj为空，则忽略 */
- (NSMutableArray *)dtt_addObject:(_Nullable id)obj;

/** 移除第一个元素 */
- (NSMutableArray *)dtt_removeFirstObject;

/** 移除最后一个元素 */
- (NSMutableArray *)dtt_removeLastObject;

/** 在数组的最后添加元素 */
- (NSMutableArray *)dtt_insertObjectAtLast:(id)obj;

@end
NS_ASSUME_NONNULL_END
