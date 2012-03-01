//
//  TDSRequestObject.m
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-3-1.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSRequestObject.h"

@implementation TDSRequestObject
@synthesize URL;
@synthesize parametersDic = _parametersDic;
+ (id)requestObjectForQuery:(NSMutableDictionary*)query{
    TDSRequestObject *requestObject = [[TDSRequestObject alloc] init];
    requestObject.parametersDic = query;
    return [requestObject autorelease];
}

- (NSURL*)URL{
    TDSConfig *config = [TDSConfig getInstance];
    NSMutableString *urlString = [NSMutableString stringWithString:config.mApiUrl];
    if ([self.parametersDic allKeys]>0) {
        [urlString appendString:@"?"];
        for (id key in self.parametersDic.allKeys) {
            id value = [self.parametersDic objectForKey:key];
            [urlString appendFormat:@"%@=%@",key,value];
        }
    }
    NSLog(@" ##requestURL:%@",urlString);
    
    return [NSURL URLWithString:urlString];

}
@end
