//
//  OSChatDTO.m
//  SuningEBuy
//
//  Created by  liukun on 13-11-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OSChatDTO.h"

@implementation OSChatDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.b2cGroupId = EncodeStringFromDic(dic, @"b2cGroupId");
    self.shopCode = EncodeStringFromDic(dic, @"sc");
    self.gId = EncodeStringFromDic(dic, @"gId");
    self.companyId = EncodeStringFromDic(dic, @"companyId");
    self.vId = EncodeStringFromDic(dic, @"vId");
    self.chatId = EncodeStringFromDic(dic, @"chatId");
    self.customerId = EncodeStringFromDic(dic, @"customerId");
    self.nickName = EncodeStringFromDic(dic, @"nickName");
    self.greeting = EncodeStringFromDic(dic, @"greeting");
    
    self.waitQueueId = EncodeStringFromDic(dic, @"waitQueueId");

    if (self.chatId.length)
    {
        self.chatState = OSChatStateOnChat;
    }
    else if (self.waitQueueId.length)
    {
        self.chatState = OSChatStateOnWaitQueue;
    }
    else
    {
        self.chatState = OSChatStateUnCreated;
    }
}

- (NSMutableArray *)sessionMsgs
{
    if (!_sessionMsgs) {
        _sessionMsgs = [[NSMutableArray alloc] init];
    }
    return _sessionMsgs;
}

- (NSMutableArray *)waitSendMsgs
{
    if (!_waitSendMsgs) {
        _waitSendMsgs = [[NSMutableArray alloc] init];
    }
    return _waitSendMsgs;
}

@end
