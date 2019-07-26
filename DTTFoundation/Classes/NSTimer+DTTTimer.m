//
//  NSTimer+DTTTimer.m
//  Pods
//
//  Created by majian on 2016/11/23.
//
//

#import "NSTimer+DTTTimer.h"

@implementation NSTimer (DTTTimer)

- (void)dtt_invalidate {
    if (self.isValid) {
        self.fireDate = [NSDate distantFuture];
        [self invalidate];
    }
}

@end
