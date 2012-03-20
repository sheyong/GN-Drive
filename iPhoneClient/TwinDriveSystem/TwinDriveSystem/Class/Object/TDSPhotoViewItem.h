//
//  TDSPhotoViewItem.h
//  TwinDriveSystem
//
//  Created by 自 己 on 12-3-20.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDSPhotoViewItem : NSObject{
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
+ (TDSPhotoViewItem *)objectWithDictionary:(NSDictionary *)dictionary;

@end
