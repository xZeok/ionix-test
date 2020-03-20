//
//  DES.m
//  test
//
//  Created by Jaime Capponi on 20-03-20.
//  Copyright © 2020 Jaime Capponi. All rights reserved.
//

#import "DES.h"
#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonCryptor.h>

@implementation DES

- (NSString *) encrypt: (NSString *)rut {
    const void *vplainText;
    size_t plainTextBufferSize = [rut length];
    vplainText = (const void *)[rut UTF8String];
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = nil;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc(bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    NSString *key = @"ionix123456";
    const void *vkey = (const void *) [key UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySizeDES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *) bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    NSData *myData = [NSData dataWithBytes: (const void *) bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [myData base64Encoding];
    return result;
}

@end
