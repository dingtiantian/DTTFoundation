//
//  DTTWeakObjectContainer.m
//  Pods
//
//  Created by dtt on 16/10/16.
//
//

#import "DTTWeakObjectContainer.h"

@implementation DTTWeakObjectContainer

- (instancetype)initWithWeakObject:(id)weakObj {
    if (self = [super init]) {
        self.weakObj = weakObj;
    }
    
    return self;
}

@end
