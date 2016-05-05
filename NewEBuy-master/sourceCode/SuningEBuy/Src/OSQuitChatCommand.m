//
//  OSQuitChatCommand.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OSQuitChatCommand.h"

@implementation OSQuitChatCommand

- (void)cancel
{
    SERVICE_RELEASE_SAFELY(service);
}

- (id)initWithChat:(OSChatDTO *)chat
{
    self = [super init];
    if (self)
    {
        chatDTO = chat;
        service = [[OSChatService alloc] init];
        service.delegate = self;
    }
    return self;
}

- (void)execute
{
    if (chatDTO.chatState == OSChatStateOnWaitQueue)
    {
        [service requestQuitWaitQueue:chatDTO.companyId
                                  GId:chatDTO.gId
                                  VId:chatDTO.vId];//5. 退出排队
    }
    else if (chatDTO.chatState == OSChatStateOnChat)
    {
        [service requestEndChat:chatDTO.companyId
                         ChatId:chatDTO.chatId
                            VId:chatDTO.chatId];//8. 结束对话
    }
    else
    {
        [self done];
    }
}

- (void)osService:(OSChatService *)service quitWaitQueueComplete:(BOOL)isSuccess
{
    [self done];
}

- (void)osService:(OSChatService *)service endChatComplete:(BOOL)isSuccess
{
    [self done];
}

@end
