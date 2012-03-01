//
//  TDSLogger.m
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-3-2.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import "TDSLogger.h"

@implementation TDSLogger

+ (void) file:(const char*)sourceFile function:(const char*)functionName lineNumber:(int)lineNumber  level:(NSString*)level format:(NSString*)format, ...
{
    if (!format) {
        return;
    }
    
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	va_list ap;
	NSString *print, *file, *function;
	
	va_start(ap,format);
	
	file = [[NSString alloc] initWithBytes:sourceFile length: strlen(sourceFile) encoding:NSUTF8StringEncoding];
	
	function = [NSString stringWithCString:functionName encoding:NSUTF8StringEncoding];
	
	print = [[NSString alloc] initWithFormat:format arguments:ap];
	
	va_end(ap);

    NSDate *date = [NSDate date];
    NSString *logString = [NSString stringWithFormat:@"[%@]\r\n%@ ==> %@:%d %@:\n%@\n\n",date,level, [file lastPathComponent], lineNumber, function, print];
    const char *logInfo = [logString UTF8String];
    printf("%s",logInfo);
	
	[print release];
	
	[file release];
	
	[pool release];	
}

@end
