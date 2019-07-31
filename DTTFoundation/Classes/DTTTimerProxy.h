//
//  DTTTimerProxy.h
//  DataBaseDemo
//
//  Created by dtt on 2016/11/16.
//  Copyright © 2016年 majian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTTTimerProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)aTarget;
- (instancetype)initWithTarget:(id)aTarget;

@end
