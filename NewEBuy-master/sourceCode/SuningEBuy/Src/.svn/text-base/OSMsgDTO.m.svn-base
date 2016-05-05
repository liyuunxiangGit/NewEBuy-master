//
//  OSMsgDTO.m
//  SuningEBuy
//
//  Created by  liukun on 13-11-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OSMsgDTO.h"

@implementation OSMsgDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.chatId = EncodeStringFromDic(dic, @"chatId");
    self.from = EncodeStringFromDic(dic, @"from");
    self.msg = EncodeStringFromDic(dic, @"msg");
    self.to = EncodeStringFromDic(dic, @"to");
    
    NSString *type = EncodeStringFromDic(dic, @"type");
    if ([type isEqualToString:@"message"])
    {
        self.type = OSMsgNormal;
    }
    else if ([type isEqualToString:@"end"] || [type isEqualToString:@"close"])
    {
        self.type = OSMsgCloseChat;
        if (!self.msg.length) {
            self.msg = L(@"OnlineService_HuiHuaEnd");
        }
    }
    else if ([type isEqualToString:@"to"])
    {
        self.type = OSMsgTo;
    }
    else if ([type isEqualToString:@"screenshot"])
    {
        self.type = OSMsgScreenShot;
    }
    else if ([type isEqualToString:@"file"])
    {
        self.type = OSMsgFile;
    }
    else if ([type isEqualToString:@"opinion"])
    {
        self.type = OSMsgOpinion;
        if (!self.msg.length) {
            self.msg = L(@"OnlineService_PleaseEvaluateMyService");
        }
    }
    else if ([type isEqualToString:@"transchat"])
    {
        self.type = OSMsgTranschat;
        
        NSArray *parts = [self.msg componentsSeparatedByString:@","];
        NSString *transKefuId = [parts safeObjectAtIndex:0];
        NSString *transChatId = [parts safeObjectAtIndex:1];
        NSString *transKefuNick = [parts safeObjectAtIndex:2];
        
        self.chatId = transChatId;
        self.from = transKefuNick;
        self.msg = [NSString stringWithFormat:@"%@%@%@",L(@"OnlineService_SystemSwitch"), transKefuId,L(@"OnlineService_ServerOnYourService")];
    }
    else
    {
        self.type = OSMsgNormal;
    }
    
    self.time = [NSDate date];
}

+ (instancetype)msgForEndChat
{
    OSMsgDTO *msg = [[OSMsgDTO alloc] init];
    msg.type = OSMsgCloseChat;
    msg.msg = L(@"OnlineService_HuiHuaEnd");
    return msg;
}

@end
