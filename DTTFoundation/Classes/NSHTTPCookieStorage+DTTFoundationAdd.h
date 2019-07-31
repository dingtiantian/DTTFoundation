//
//  NSHTTPCookieStorage+DTTFoundationAdd.h
//  Pods
//
//  Created by dtt on 2017/4/10.
//
//

#import <Foundation/Foundation.h>
#import <DTTFoundation/NSString+DTTString.h>
#import <DTTFoundation/NSArray+DTTArray.h>

@interface NSHTTPCookieStorage (DTTFoundationAdd)

- (void)dtt_removeCookiesForDomain:(NSString *)domain;

- (void)dtt_removeCookiesForDomains:(NSArray*)domains;

@end
