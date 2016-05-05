//
//  GetUserInfoCommand.m
//  SuningEBuy
//
//  Created by liukun on 14-3-20.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "GetUserInfoCommand.h"
#import "SFHFKeychainUtils.h"

@implementation GetUserInfoCommand

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
    
    [service beginGetUserInfo];
}

- (void)userLoginCompletedWithResult:(BOOL)successfulLogin
                           errorCode:(NSString *)errorCode
{
    if (successfulLogin)
    {
        //JUST post a notification
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_OK_MESSAGE object:nil];
        
        [SFHFKeychainUtils storeUsername:kSuningLoginUserNameKey andPassword:[UserCenter defaultCenter].userInfoDTO.logonId forServiceName:kSNKeychainServiceNameSuffix updateExisting:YES error:nil];
//        [Config currentConfig].username = [UserCenter defaultCenter].userInfoDTO.logonId;
    }
    
    [self done];
}


@end
