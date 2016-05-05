//
//  GetUserInfoCommand.h
//  SuningEBuy
//
//  Created by liukun on 14-3-20.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "Command.h"
#import "UserLoginService.h"

@interface GetUserInfoCommand : Command<UserLoginServiceDelegate>
{
    UserLoginService *service;
}

@end
