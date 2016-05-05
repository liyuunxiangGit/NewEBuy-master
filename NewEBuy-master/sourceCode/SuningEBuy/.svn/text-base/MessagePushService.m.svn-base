//
//  MessagePushService.m
//  SuningEBuy
//
//  Created by shasha on 12-11-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MessagePushService.h"

@interface MessagePushService ()

- (void)parseMessage:(NSDictionary*)responseDic;

- (void)didGetPushMessageCompleteWithResult:(BOOL)isSuccess;

@end

@implementation MessagePushService

@synthesize delegate = _delegate;
@synthesize pushMessageId = _pushMessageId;
@synthesize pushMessageContent = _pushMessageContent;
@synthesize isLoadOk = _isLoadOk;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_pushMessageId);
    TT_RELEASE_SAFELY(_pushMessageContent);
    
}


- (id)init {
    self = [super init];
    if (self) {
        _isLoadOk = NO;
    }
    return self;
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_getMessagePushHttpMsg);
}

- (void)didGetPushMessageCompleteWithResult:(BOOL)isSucces
{
    _isLoadOk = YES;

    if ([_delegate respondsToSelector:@selector(getPushMsgCompletionWithResult:errorMsg:)])
    {
        [_delegate getPushMsgCompletionWithResult:isSucces errorMsg:self.errorMsg];
    }
}

- (void)beginGetPushMessage
{
    
    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 kHttpRequestHomeStoreValue,kHttpRequestHomeStoreKey,
                                 @"3",@"client",nil];
	
	NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kHostAddressForHttp,@"SNMobileMessageListView"];
    
    HTTPMSG_RELEASE_SAFELY(_getMessagePushHttpMsg);
	
	_getMessagePushHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                        requestUrl:url
                                                       postDataDic:postDataDic
                                                           cmdCode:CC_MessagePush];
	   _getMessagePushHttpMsg.requestMethod=RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:_getMessagePushHttpMsg];
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    [self didGetPushMessageCompleteWithResult:NO];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    NSDictionary *items = receiveMsg.jasonItems;
    if (!items)
    {
        self.errorMsg =  kHttpResponseJSONValueFailError;
        [self didGetPushMessageCompleteWithResult:NO];
    }
    else
    {
        [self parseMessage:items];
    }
    
}

- (void)parseMessage:(NSDictionary*)responseDic
{
    @autoreleasepool {
        
        NSArray *array = [responseDic objectForKey:@"messageList"];
        DLog(@"[areaList count]:%d", [array count]);
        if(array != nil && [array count] > 0)
        {
            //获取字典中所有的消息（注，有效的消息只有第一条）
            //获取第一条记录
            NSDictionary *dic = [array objectAtIndex:0];
            NSString *messageId = [dic objectForKey:@"messageId"];
            NSString *content = [dic objectForKey:@"content"];  
            
            if (!IsStrEmpty(messageId) && !IsStrEmpty(content))
            {
                self.pushMessageId = messageId;
                self.pushMessageContent = content;
                [self didGetPushMessageCompleteWithResult:YES];
            }
            else
            {
                [self didGetPushMessageCompleteWithResult:NO];
            }
        }
        else
        {
            [self didGetPushMessageCompleteWithResult:NO];
        }
    }
}
@end
