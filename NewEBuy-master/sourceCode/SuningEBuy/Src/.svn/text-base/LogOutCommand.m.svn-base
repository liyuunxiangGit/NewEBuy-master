//
//  LogOutCommand.m
//  SuningEBuy
//
//  Created by  liukun on 12-12-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
#import "SNSwitch.h"
#import "LogOutCommand.h"

@implementation LogOutCommand

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(service);
}

- (void)cancel
{
    service.delegate = nil;
    service = nil;
    
    [super cancel];
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)execute
{
    if (!service)
    {
        service = [[UserLoginService alloc] init];
        service.delegate = self;
    }
    
    if ([SNSwitch isPassportLogin])
    {
        [service beginPassportLogout];
    }
    else
    {
        [service beginLogout];
    }
}

- (void)userLogoutCompletedWithResult:(BOOL)successfulLogout
                            errorCode:(NSString *)errorCode
{
    DLog(@"log out success!");
    
    [[UserCenter defaultCenter] clearUserInfo];
    
    NSDictionary *dic = @{@"errorDesc": errorCode?errorCode:@""};
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_OK_NOTIFICATION
                                                        object:nil
                                                      userInfo:dic];
    self.logoutSuccess = YES;
    
    [self done];
}


@end
