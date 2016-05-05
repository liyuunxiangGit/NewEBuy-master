//
//  CheckNeedVerifyCodeService.m
//  SuningEBuy
//
//  Created by chupeng on 14-1-6.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CheckNeedVerifyCodeService.h"

@implementation CheckNeedVerifyCodeService

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(checkHttpMsg);
}

- (void)beginCheckNeedVerifyCode:(NSString *)userName
{
    self.userName = userName;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [dic setObject:self.userName?self.userName:@"" forKey:KUserName];
    
    NSString *url = [NSString stringWithFormat:kPassportNeedVerifyCode];
    
    HTTPMSG_RELEASE_SAFELY(checkHttpMsg);
    
    checkHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:dic cmdCode:CC_CheckNeedVerifyCode];
    [self.httpMsgCtrl sendHttpMsg:checkHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
}

#pragma mark -
#pragma mark httpMessage delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSString *response = receiveMsg.responseString;
    DLog(@"%@", response);
    if ([response isEqualToString:@"false"])
    {
        [_delegate CheckNeedVerifyCodeCompletedWithResult:NO];
    }
    else
    {
        [_delegate CheckNeedVerifyCodeCompletedWithResult:YES];
    }
}
@end
