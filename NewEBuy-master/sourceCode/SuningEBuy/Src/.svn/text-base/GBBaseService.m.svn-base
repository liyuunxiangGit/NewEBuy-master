//
//  GBBaseService.m
//  SuningEBuy
//
//  Created by shasha on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBBaseService.h"

@implementation GBBaseService
@synthesize errorCode = _errorCode;

- (void)dealloc
{
}

- (void)httpMsgRelease{

}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];

    [self receiveDataFinished:receiveMsg Data:nil Result:NO];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg{

    NSDictionary *items = receiveMsg.jasonItems;
    
    self.errorCode = EncodeStringFromDic(items, @"errorCode");
    
    self.errorMsg = EncodeStringFromDic(items, @"errorMsg");
    
    NSDictionary *dataDic = [items objectForKey:@"data"];
    
    if ([self.errorCode isEqualToString:@"400000"]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SESSION_FAILURE_NEED_LOGIN_GROUP object:nil];
    }
    
    if (IsStrEmpty(self.errorMsg)||![self.errorCode isEqualToString:kGBHttpRequestErrorCodeSuccess]) {
        
        [self receiveDataFinished:receiveMsg Data:nil Result:NO];
    }else{
        [self receiveDataFinished:receiveMsg Data:dataDic Result:YES];
    }
}

- (void)receiveDataFinished:(HttpMessage *)recieveMsg Data:(NSDictionary *)dataDic Result:(BOOL)isSuccess{

    [NSException raise:NSInternalInconsistencyException format:@"you must ovrride %@ in a subclass",NSStringFromSelector(@selector(receiveDataFinished:Data:Result:))];

}
@end
