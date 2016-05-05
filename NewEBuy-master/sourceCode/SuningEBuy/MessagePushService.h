//
//  MessagePushService.h
//  SuningEBuy
//
//  Created by shasha on 12-11-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"

@protocol MessagePushDelegate <NSObject>

@optional
- (void)getPushMsgCompletionWithResult:(BOOL)isSuccess
                              errorMsg:(NSString *)errorMsg;

@end

@interface MessagePushService : DataService
{
    HttpMessage     *_getMessagePushHttpMsg;
}

@property (nonatomic, weak) id<MessagePushDelegate> delegate;

@property (nonatomic, copy) NSString  *pushMessageId;
@property (nonatomic, copy) NSString  *pushMessageContent;

@property (nonatomic, assign) BOOL      isLoadOk;

- (void)beginGetPushMessage;
@end
