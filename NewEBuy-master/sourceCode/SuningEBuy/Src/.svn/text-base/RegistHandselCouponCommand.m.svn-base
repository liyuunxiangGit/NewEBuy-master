//
//  RegistHandselCouponManage.m
//  SuningEBuy
//
//  Created by  liukun on 12-11-9.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "RegistHandselCouponCommand.h"
#import "SNSwitch.h"

@interface RegistHandselCouponCommand()
{
    NSMutableArray *serviceArray;
}


@end

/*********************************************************************/

@implementation RegistHandselCouponCommand


- (void)dealloc
{
    TT_RELEASE_SAFELY(_userId);
}

- (void)cancel
{
    for (ActivitySwitchService *service in serviceArray)
    {
        service.delegate = nil;
    }
    serviceArray = nil;
    [super cancel];
}

- (id)initWithUserId:(NSString *)userId
{
    self = [super init];
    if (self) {
        _userId = [userId copy];
    }
    return self;
}

- (void)beginActivityRequest
{
    NSArray *actionArr = nil;
    
    [SNSwitch canRegistSendCounponActionKey:&actionArr];
    
    if ([actionArr count] > 0)
    {
        for (NSString *actionName in actionArr)
        {
            ActivitySwitchService *service = [[ActivitySwitchService alloc] init];
            service.delegate = self;
            
            if (!serviceArray)
            {
                serviceArray = [[NSMutableArray alloc] init];
            }
            
            [serviceArray addObject:service];
            
            [service beginActivityWithActionName:actionName userId:_userId];
            
        }
    }
    else
    {
        [self done];
    }
}

- (void)execute
{
    //先判断活动开关列表是否获取成功
    NSDictionary *activityMap = [GlobalDataCenter defaultCenter].activitySwitchMap;
    if (activityMap)
    {
        [self beginActivityRequest];
    }
    else  //没有获取开关时，先获取开关列表
    { 
        
        [SNSwitch updateWithCallBack:^{
            
            [self beginActivityRequest];

        }];
    }
}

- (void)service:(ActivitySwitchService *)service sendActivityActionComplete:(BOOL)isSuccess
{
    if ([serviceArray containsObject:service])
    {
        [serviceArray removeObject:service];
    }
    
    if ([serviceArray count] == 0)
    {
        serviceArray = nil;
        [self done];
    }
}

@end
