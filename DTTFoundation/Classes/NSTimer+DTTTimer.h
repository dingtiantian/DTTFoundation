//
//  NSTimer+DTTTimer.h
//  Pods
//
//  Created by dtt on 2016/11/23.
//
//

#import <Foundation/Foundation.h>
#import <DTTFoundation/DTTTimerProxy.h>


NS_ASSUME_NONNULL_BEGIN
@interface NSTimer (DTTTimer)

- (void)dtt_invalidate;

@end
NS_ASSUME_NONNULL_END
