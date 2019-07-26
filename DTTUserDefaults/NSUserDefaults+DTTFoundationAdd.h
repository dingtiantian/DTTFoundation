//
//  NSUserDefaults+DTTFoundationAdd.h
//  Pods
//
//  Created by majian on 2017/4/18.
//
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (DTTFoundationAdd)

+ (void)dtt_setObject:(id)obj forKey:(NSString *)key;

+ (id)dtt_objectForKey:(NSString *)key;

@end
