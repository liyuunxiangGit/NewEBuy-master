//
//  MessagePushCommand.h
//  SuningEBuy
//
//  Created by  liukun on 12-12-18.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "Command.h"
#import "MessagePushService.h"

@interface MessagePushCommand : Command <MessagePushDelegate>
{
    MessagePushService *service;
}

@end
