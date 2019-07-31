//
//  NSHTTPCookieStorage+DTTFoundationAdd.m
//  Pods
//
//  Created by dtt on 2017/4/10.
//
//

#import "NSHTTPCookieStorage+DTTFoundationAdd.h"

@implementation NSHTTPCookieStorage (DTTFoundationAdd)

- (void)dtt_removeCookiesForDomain:(NSString *)domain {
    if (DTTIsEmptyString(domain)) {
        return;
    }
    [self dtt_removeCookiesForDomains:@[domain]];
}

- (void)dtt_removeCookiesForDomains:(NSArray*)domains{
    if (DTTIsEmptyArray(domains)) {
        return;
    }
    for (NSHTTPCookie* cookie in self.cookies) {
        NSString* _domain = [cookie domain];
        for (NSString* domain in domains) {
            if ([_domain rangeOfString:domain options:NSCaseInsensitiveSearch].location != NSNotFound) {
                [self deleteCookie:cookie];
                break;
            }
        }
    }
}

@end
