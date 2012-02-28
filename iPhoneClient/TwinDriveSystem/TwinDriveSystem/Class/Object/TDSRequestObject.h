//
//  TDSRequestObject.h
//  TwinDriveSystem
//
//  Created by zhongsheng on 12-2-28.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDSRequestObject : NSObject{
    NSString *_kWeiboID;
    NSString *_describeText;
    NSString *_picUrlText;
    NSDate   *_createTime;
}
@property (nonatomic, copy) NSString *kWeiboID;
@property (nonatomic, copy) NSString *describeText;
@property (nonatomic, copy) NSString *picUrlText;
@property (nonatomic, copy) NSDate   *createTime;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (TDSRequestObject *)objectWithDictionary:(NSDictionary *)dictionary;

@end
