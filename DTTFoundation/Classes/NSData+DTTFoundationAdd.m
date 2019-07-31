//
//  NSData+DTTFoundationAdd.m
//  Pods
//
//  Created by dtt on 2017/4/11.
//
//

#import "NSData+DTTFoundationAdd.h"

//static char kDTTBytesConversionStrings[512] = "000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c2d2e2f303132333435363738393a3b3c3d3e3f404142434445464748494a4b4c4d4e4f505152535455565758595a5b5c5d5e5f606162636465666768696a6b6c6d6e6f707172737475767778797a7b7c7d7e7f808182838485868788898a8b8c8d8e8f909192939495969798999a9b9c9d9e9fa0a1a2a3a4a5a6a7a8a9aaabacadaeafb0b1b2b3b4b5b6b7b8b9babbbcbdbebfc0c1c2c3c4c5c6c7c8c9cacbcccdcecfd0d1d2d3d4d5d6d7d8d9dadbdcdddedfe0e1e2e3e4e5e6e7e8e9eaebecedeeeff0f1f2f3f4f5f6f7f8f9fafbfcfdfeff";

@implementation NSData (DTTFoundationAdd)

+ (NSData *)dtt_dataWithBytesString:(NSString *)bytesString {
    if (!bytesString || !bytesString.length) return NULL;
    const char *scanner=[bytesString cStringUsingEncoding:NSUTF8StringEncoding];
    char twoChars[3]={0,0,0};
    long bytesBlockSize = bytesString.length/2;
    long counter = bytesBlockSize;
    Byte *bytesBlock = malloc(bytesBlockSize);
    Byte *writer = bytesBlock;
    while (counter--) {
        twoChars[0]=*scanner++;
        twoChars[1]=*scanner++;
        *writer++ = strtol(twoChars, NULL, 16);
    }
    
    return[NSData dataWithBytesNoCopy:bytesBlock length:bytesBlockSize freeWhenDone:YES];
}

/**
 获取到字符串
 */
- (NSString *)dtt_bytesString {
    return [[[[self description] dtt_trimNewLinesAndWhiteSpaces] dtt_removeFirstCharacter] dtt_removeLastCharacter];
//    UInt16* mapping = (UInt16*)kDTTBytesConversionStrings;
//    register UInt16 len = self.length;
//    if (!len) return NULL;
//    char* hexChars = (char*)malloc( sizeof(char) * (len*2) );
//    register UInt16* dst = ((UInt16*)hexChars) + len-1;
//    register unsigned char* src = (unsigned char*)self.bytes + len-1;
//    
//    while (len--) *dst-- = mapping[*src--];
//    
//    NSString* retVal = [[NSString alloc] initWithBytesNoCopy:hexChars length:self.length*2 encoding:NSASCIIStringEncoding freeWhenDone:YES];
//    return retVal;
}

@end
