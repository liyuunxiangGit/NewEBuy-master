//
//  AutoLoginCommand.h
//  SuningEBuy
//
//  Created by  liukun on 12-12-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "Command.h"
#import "UserLoginService.h"

@interface AutoLoginCommand : Command <UserLoginServiceDelegate>
{
    UserLoginService *service;
}

@end
