//
//  TDSLogger.h
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-3-2.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 TDSLOG_debug(...)
 TDSLOG_info(...)
 TDSLOG_warn(...)
 TDSLOG_error(...)
 TDSLOG_fatal(...)
 
 */

// NSLog 也定义了去！！
#define NSLog TDSLOG_debug 

@interface TDSLogger : NSObject

+ (void) file:(const char*)sourceFile function:(const char*)functionName lineNumber:(int)lineNumber level:(NSString*)level format:(NSString*)format, ...;

#ifndef _XN_LOG_
#define _XN_LOG_ 1



//日志相关宏定义

#define LOG_LEVEL_DEBUG    1<<4

#define LOG_LEVEL_INFO     1<<3

#define LOG_LEVEL_WARN     1<<2

#define LOG_LEVEL_ERROR    1<<1

#define LOG_LEVEL_FATAL    1

#define LOG_LEVEL_NONE     0

#define LOG_LEVEL_ALL      LOG_LEVEL_DEBUG|LOG_LEVEL_INFO|LOG_LEVEL_WARN|LOG_LEVEL_ERROR|LOG_LEVEL_FATAL

//这里是log输出级别控制开关
#define LOG_LEVEL   LOG_LEVEL_ALL


#if (LOG_LEVEL &  LOG_LEVEL_DEBUG)
#define TDSLOG_debug(s,...) [TDSLogger file:(char*)__FILE__ function:(char*)__FUNCTION__ lineNumber:__LINE__  level:@"debug:" format:(s),##__VA_ARGS__]
#else
#define TDSLOG_debug(...) do { } while (0)  
#endif

#if (LOG_LEVEL &  LOG_LEVEL_INFO)
#define TDSLOG_info(s,...) [TDSLogger file:(char*)__FILE__ function:(char*)__FUNCTION__ lineNumber:__LINE__ level:@"info:" format:(s),##__VA_ARGS__]
#else
#define TDSLOG_info(...) do { } while (0)  
#endif

#if (LOG_LEVEL &  LOG_LEVEL_WARN)
#define TDSLOG_warn(s,...) [TDSLogger file:(char*)__FILE__ function:(char*)__FUNCTION__ lineNumber:__LINE__ level:@"warn:" format:(s),##__VA_ARGS__]
#else
#define TDSLOG_warn(...) do { } while (0)  
#endif

#if (LOG_LEVEL &  LOG_LEVEL_ERROR)
#define TDSLOG_error(s,...) [TDSLogger file:(char*)__FILE__ function:(char*)__FUNCTION__ lineNumber:__LINE__ level:@"error:" format:(s),##__VA_ARGS__]
#else
#define TDSLOG_error(...) do { } while (0)  
#endif

#if (LOG_LEVEL &  LOG_LEVEL_FATAL)
#define TDSLOG_fatal(s,...) [TDSLogger file:(char*)__FILE__ function:(char*)__FUNCTION__ lineNumber:__LINE__ level:@"fatal:" format:(s),##__VA_ARGS__]
#else
#define TDSLOG_fatal(...) do { } while (0)  
#endif


#endif


@end
