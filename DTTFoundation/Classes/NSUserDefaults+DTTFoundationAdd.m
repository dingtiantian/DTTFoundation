//
//  NSUserDefaults+DTTFoundationAdd.m
//  Pods
//
//  Created by dtt on 2017/4/18.
//
//

#import "NSUserDefaults+DTTFoundationAdd.h"

@implementation NSUserDefaults (DTTFoundationAdd)

+ (void)dtt_setObject:(id)obj forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
}

+ (id)dtt_objectForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
