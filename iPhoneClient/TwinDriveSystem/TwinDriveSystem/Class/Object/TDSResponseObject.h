//
//  TDSResponseObject.h
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-2-28.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDSResponseObject : NSObject{
    NSString *_kWeiboID;
    NSString *_describeText;
    NSString *_picUrlText;
    NSDate   *_createTime;
    NSString *_error;
}
@property (nonatomic, copy) NSString *kWeiboID;
@property (nonatomic, copy) NSString *describeText;
@property (nonatomic, copy) NSString *picUrlText;
@property (nonatomic, copy) NSDate   *createTime;
@property (nonatomic, copy) NSString *error;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (TDSResponseObject *)objectWithDictionary:(NSDictionary *)dictionary;

@end
