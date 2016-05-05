//
//  ActivitySwitchService.h
//  SuningEBuy
//
//  Created by  on 12-9-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      ActivitySwitchService
 @abstract    获取活动开关的service
 @author      刘坤
 @version     v2.0  12-9-24
 @discussion  12-11-9   获取所有的活动开关，包括版本号
 */
#import "DataService.h"

@class ActivitySwitchService;
@protocol ActivitySwitchServiceDelegate <NSObject>

@optional
- (void)getSwitchListCompletionWithResult:(BOOL)isSuccess 
                                      map:(NSDictionary *)swithMap;

- (void)service:(ActivitySwitchService *)service sendActivityActionComplete:(BOOL)isSuccess;

@end



@interface ActivitySwitchService : DataService
{
    HttpMessage     *getSwitchListHttpMsg;
    HttpMessage     *activityActionHttpMsg;
}

@property (nonatomic, weak) id<ActivitySwitchServiceDelegate> delegate;

/*!
 @abstract      获取活动列表的请求
 */
- (void)beginGetSwitchList;


- (void)beginGetSwitchListWithVersion:(NSString *)version;


/*!
 @abstract      获取活动列表的请求
 @param         actionName 活动名称
 @param         userId     用户id
 */
- (void)beginActivityWithActionName:(NSString *)actionName 
                             userId:(NSString *)userId;


+ (BOOL)isLoadingSwitchList;

@end
