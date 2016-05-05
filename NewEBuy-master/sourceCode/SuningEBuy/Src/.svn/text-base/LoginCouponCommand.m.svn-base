//
//  LoginCouponCommand.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-3-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "LoginCouponCommand.h"
#import "SNSwitch.h"

@interface LoginCouponCommand()

@property (nonatomic, strong) ActivitySwitchService *service;

@end

/*********************************************************************/

@implementation LoginCouponCommand

@synthesize service = _service;

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_userId);
}

- (void)cancel
{
    SERVICE_RELEASE_SAFELY(_service);
    
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

- (ActivitySwitchService *)service
{
    if (!_service) {
        _service = [[ActivitySwitchService alloc] init];
        _service.delegate = self;
    }
    return _service;
}


- (void)beginActivityRequest
{
    NSString *actionName = nil;
    if ([SNSwitch canLoginSendCounponActionKey:&actionName]) {
        
        [self.service beginActivityWithActionName:actionName userId:_userId];
    }else{
        [self done];
    }
}

- (void)execute
{    
    //先判断活动开关列表是否获取成功
    if ([SNSwitch isLoadOk])
    {
        [self beginActivityRequest];
    }
    else   //没有获取开关时，先获取开关列表
    {
        [SNSwitch updateWithCallBack:^{
            
            [self beginActivityRequest];
            
        }];
    }
}

- (void)handselCoupon:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:LOGIN_OK_MESSAGE
                                                  object:nil];
    
    [self execute];
    
}

- (void)service:(ActivitySwitchService *)service sendActivityActionComplete:(BOOL)isSuccess
{
    
    [self done];
}
@end
