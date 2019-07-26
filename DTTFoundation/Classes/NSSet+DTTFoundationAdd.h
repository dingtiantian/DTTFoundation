//
//  NSSet+DTTFoundationAdd.h
//  Pods
//
//  Created by majian on 2017/4/11.
//
//

#import <Foundation/Foundation.h>
#import <DTTFoundation/NSObject+DTTObject.h>
#import <DTTFoundation/NSArray+DTTArray.h>

extern BOOL DTTIsEmptySet(NSSet *set);
extern BOOL DTTIsNotEmptySet(NSSet *set);

@interface NSSet (DTTFoundationAdd)

- (NSArray *)dtt_toArray;

- (NSMutableArray *)dtt_toMutableArray;

- (NSSet *)dtt_removeObject:(id)obj;

@end
