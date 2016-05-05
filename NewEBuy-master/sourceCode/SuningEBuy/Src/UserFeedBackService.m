//
//  UserFeedBackService.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "UserFeedBackService.h"

@implementation UserFeedBackService

@synthesize delegate = _delegate;

@synthesize isSucess = _isSucess;
@synthesize serviceErrorCode = _serviceErrorCode;
@synthesize errorMessage = _errorMessage;
@synthesize isNetWorkError = _isNetWorkError;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_isSucess);
    TT_RELEASE_SAFELY(_serviceErrorCode);
    TT_RELEASE_SAFELY(_errorMessage);
    HTTPMSG_RELEASE_SAFELY(__UserFeedBackMsg);
    
}

- (void)beginSendFeedBackRequest:(UserFeedBackDTO *)backDto{
    
    UserFeedBackDTO *dto = backDto;
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    [postDic setObject:dto.feedbackType forKey:@"feedbackType"];
    [postDic setObject:dto.feedbackContext forKey:@"feedbackContext"];
    [postDic setObject:dto.contactInfo forKey:@"contactInfo"];
    [postDic setObject:dto.terminal forKey:@"terminal"];
    [postDic setObject:dto.terminalOsVersion forKey:@"terminalOsVersion"];
    [postDic setObject:dto.appId forKey:@"appId"];
    [postDic setObject:dto.terminalAppVersion forKey:@"terminalAppVersion"];
    [postDic setObject:dto.clientId forKey:@"clientId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kMobileHostAddress, @"addClientFeedbackInfo.do"];
    
    HTTPMSG_RELEASE_SAFELY(__UserFeedBackMsg);
    __UserFeedBackMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDic cmdCode:CC_UserFeedback];
    
    [self.httpMsgCtrl sendHttpMsg:__UserFeedBackMsg];
    
    TT_RELEASE_SAFELY(postDic);
    TT_RELEASE_SAFELY(dto);
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_UserFeedback) {
        self.isNetWorkError = YES;
        [self getGroupListFinish:NO];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems ;
    
    if (receiveMsg.cmdCode == CC_UserFeedback) {
        self.isNetWorkError = NO;
        if (!items) {
            [self getGroupListFinish:NO];
        }else{
            [self parsePanicData:items];
        }
    }
}

- (void)parsePanicData:(NSDictionary *)items
{
    NSArray *result = [items objectForKey:@"resultInfo"];
    if (result.count > 0) {
        NSDictionary *resultArr = [result objectAtIndex:0];
        
        self.isSucess = [NSString stringWithFormat:@"%@",[resultArr objectForKey:@"isSucess"]];
        self.serviceErrorCode = [NSString stringWithFormat:@"%@",[resultArr objectForKey:@"errorCode"]];
        self.errorMessage = [NSString stringWithFormat:@"%@",[resultArr objectForKey:@"errorMessage"]];
        
        if ([self.isSucess isEqualToString:@"0"]) {
            [self getGroupListFinish:YES];
        }else {
            [self getGroupListFinish:NO];
        }
    }else {
        [self getGroupListFinish:NO];
    }
}

- (void)getGroupListFinish:(BOOL)isSuccess
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_delegate && [_delegate respondsToSelector:@selector(didSendFeedBackRequestComplete:Result:)]) {
            [_delegate didSendFeedBackRequestComplete:self Result:isSuccess];
        }
    });
}


@end
