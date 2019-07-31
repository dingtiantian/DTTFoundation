//
//  NSException+DTTException.h
//  Pods
//
//  Created by dtt on 2016/11/24.
//
//

#import <Foundation/Foundation.h>

/*
 OUNDATION_EXPORT NSExceptionName const NSGenericException;
 FOUNDATION_EXPORT NSExceptionName const NSRangeException;
 FOUNDATION_EXPORT NSExceptionName const NSInvalidArgumentException;
 FOUNDATION_EXPORT NSExceptionName const NSInternalInconsistencyException;
 
 FOUNDATION_EXPORT NSExceptionName const NSMallocException;
 
 FOUNDATION_EXPORT NSExceptionName const NSObjectInaccessibleException;
 FOUNDATION_EXPORT NSExceptionName const NSObjectNotAvailableException;
 FOUNDATION_EXPORT NSExceptionName const NSDestinationInvalidException;
 
 FOUNDATION_EXPORT NSExceptionName const NSPortTimeoutException;
 FOUNDATION_EXPORT NSExceptionName const NSInvalidSendPortException;
 FOUNDATION_EXPORT NSExceptionName const NSInvalidReceivePortException;
 FOUNDATION_EXPORT NSExceptionName const NSPortSendException;
 FOUNDATION_EXPORT NSExceptionName const NSPortReceiveException;
 
 FOUNDATION_EXPORT NSExceptionName const NSOldStyleException;
 */

@interface NSException (DTTException)

+ (NSException *)unrecognizedSelectorExceptionWithInstance:(NSObject *)aInstance forMethod:(SEL)aSelector;

/**
 没有实现协议
 */
+ (NSException *)didNotConforms:(Protocol *)protocl object:(id)object;


@end
