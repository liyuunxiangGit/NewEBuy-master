//
//  OSQuitChatCommand.h
//  SuningEBuy
//
//  Created by  liukun on 13-12-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "Command.h"
#import "OSChatDTO.h"
#import "OSChatService.h"

@interface OSQuitChatCommand : Command <OSChatServiceDelegate>
{
    OSChatService *service;
    OSChatDTO *chatDTO;
}

- (id)initWithChat:(OSChatDTO *)chat;

@end
