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

+ (TDSRequestObject*)request{
    TDSRequestObject *requestObject = [[TDSRequestObject alloc] init];
    return [requestObject autorelease];
}
+ (id)requestObjectForQuery:(NSMutableDictionary*)query{
    TDSRequestObject *requestObject = [TDSRequestObject request];
    requestObject.parametersDic = query;
    return requestObject;
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
    TDSLOG_debug(@" ##requestURL:%@",urlString);
    
    return [NSURL URLWithString:urlString];

}
@end
