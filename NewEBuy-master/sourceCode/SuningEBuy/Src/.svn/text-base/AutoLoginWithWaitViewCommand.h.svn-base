//
//  AutoLoginWithWaitViewCommand.h
//  SuningEBuy
//
//  Created by chupeng on 14-3-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//
#import "AutoLoginWaitingViewController.h"
#import "Command.h"
#import "UserLoginService.h"

@interface AutoLoginWithWaitViewCommand : Command <UserLoginServiceDelegate>
{
    UserLoginService *service;
}

@property (nonatomic, strong) AutoLoginWaitingViewController *waitingViewController;

/** isok */
@property (nonatomic, assign) BOOL isLoginOk;

@end
