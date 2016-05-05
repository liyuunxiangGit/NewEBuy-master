//
//  MessagePushCommand.m
//  SuningEBuy
//
//  Created by  liukun on 12-12-18.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MessagePushCommand.h"

@implementation MessagePushCommand

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(service);
}

- (void)cancel
{
    SERVICE_RELEASE_SAFELY(service);
    
    [super cancel];
}

- (id)init
{
    self = [super init];
    if (self) {
        service = [[MessagePushService alloc] init];
        service.delegate = self;
    }
    return self;
}

- (void)execute
{
    [service beginGetPushMessage];
}

- (void)getPushMsgCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    if (isSuccess)
    {
        //将获取到的消息messageId和本地配置文件中的messageId对比，如果不相同，进行更换，如果相同，不做任何操作
        if (![service.pushMessageId isEqualToString:[Config currentConfig].pushMessageId])
        {
            NSString *__pushMessageContent = service.pushMessageContent;
            
            BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil
                                                                message:__pushMessageContent
                                                               delegate:nil
                                                      cancelButtonTitle:L(@"AlertIKnow")
                                                      otherButtonTitles:nil];
            [alertView show];
            
            //重写messageid
            [Config currentConfig].pushMessageId = service.pushMessageId;
        }
    }
    
    [self done];
}

@end
