//
//  TDSResponseObject.h
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-2-28.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDSResponseObject : NSObject{
    
    id _rootObject;
    NSError *_error;
    NSString *_responseString;
}

@property (nonatomic, retain) id rootObject;
@property (nonatomic, retain) NSError *error;
@property (nonatomic, copy) NSString *responseString;

+ (TDSResponseObject *)response;

@end
