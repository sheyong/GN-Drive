//
//  NSString+NSStringEx.m
//  TwinDriveSystem
//
//  Created by 自 己 on 12-3-21.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "NSString+NSStringExt.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Addition)
- (NSString*) MD5String
{
	const char *cStr = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
    if(cStr)
    {
        CC_MD5( cStr, strlen(cStr), result );
        return [[NSString stringWithFormat:
                 @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                 result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                 result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
                 ] lowercaseString];
    }
    else {
        return nil;
    }
}

@end
