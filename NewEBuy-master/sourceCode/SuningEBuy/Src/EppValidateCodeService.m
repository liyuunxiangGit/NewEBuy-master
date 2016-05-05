//
//  EppValidateCodeService.m
//  SuningEBuy
//
//  Created by  liukun on 13-2-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "EppValidateCodeService.h"

static Calculagraph *eppValidateCodeCalculagraph = nil;

/*********************************************************************/

@implementation EppValidateCodeService

@synthesize delegate = _delegate;


+ (void)initialize
{
    eppValidateCodeCalculagraph = [[Calculagraph alloc] init];
    eppValidateCodeCalculagraph.timeOut = 120.0f;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopCalculagraph)
                                                 name:LOGOUT_OK_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopCalculagraph)
                                                 name:LOGIN_OK_MESSAGE
                                               object:nil];
}

+ (void)stopCalculagraph
{
    if (eppValidateCodeCalculagraph.isValidate)
    {
        [eppValidateCodeCalculagraph stop];
    }
}

- (void)stopPayCalculagraph
{
    if (eppValidateCodeCalculagraph.isValidate)
    {
        [eppValidateCodeCalculagraph stop];
    }    
}

- (BOOL)available
{
    return !eppValidateCodeCalculagraph.isValidate;
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(eppValidateHttpMsg);
}

- (id)init
{
    self = [super init];
    if (self) {
        [eppValidateCodeCalculagraph addObserver:self
                                      forKeyPath:@"time"
                                         options:NSKeyValueObservingOptionNew
                                         context:NULL];
        
        
    }
    return self;
}

- (void)dealloc
{
    [eppValidateCodeCalculagraph removeObserver:self forKeyPath:@"time"];
}

#pragma mark -
#pragma mark service life

- (void)requestValidateCode
{
    if (eppValidateCodeCalculagraph.isValidate) {
        return;
    }
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
	[postDataDic setObject:@"10052" forKey:@"storeId"];
    
	NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,
                     [@"SNMobileEppPayValidatecode" passport]];
    
    HTTPMSG_RELEASE_SAFELY(eppValidateHttpMsg);
	eppValidateHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                    requestUrl:url
                                                   postDataDic:postDataDic
                                                       cmdCode:CC_GetVerifyCode];
    eppValidateHttpMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:eppValidateHttpMsg];
	
	TT_RELEASE_SAFELY(postDataDic);
}

#pragma mark -
#pragma mark final

- (void)requestValidateCodeOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(requestValidateCodeComplete:errorMsg:)])
    {
        [_delegate requestValidateCodeComplete:isSuccess errorMsg:self.errorMsg];
    }
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self requestValidateCodeOk:NO];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSString *erorCode = receiveMsg.errorCode;
    NSString  *isSuccess = [receiveMsg.jasonItems objectForKey:@"isSuccess"];
    
    if ([erorCode isEqualToString:@""] && [isSuccess isEqualToString:@"1"])
    {
        [eppValidateCodeCalculagraph start];
        [self requestValidateCodeOk:YES];
        return;
    }
    else if ([erorCode isEqualToString:@"5015"])
    {
        self.errorMsg = L(@"PleaseRelogin");
    }
    else if ([erorCode isEqualToString:@"1001"])
    {
        self.errorMsg = L(@"PleaseActivateEBuy");
    }
    else
    {
        self.errorMsg = L(@"LOGIN_GetAuthCodeFail");
    }
    [self requestValidateCodeOk:NO];
}

#pragma mark -
#pragma mark kvo time

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (object == eppValidateCodeCalculagraph && [keyPath isEqualToString:@"time"])
    {
        int remainTime = 120.0f-eppValidateCodeCalculagraph.time;
        
        if ([_delegate respondsToSelector:@selector(eppRemainTimeToRetry:)]) {
            [_delegate eppRemainTimeToRetry:remainTime];
        }
    }
}

#pragma mark -
#pragma mark 校验验证码

+ (BOOL)checkVerifyCode:(NSString *)code error:(NSString **)errorMsg
{
    code = [code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([code isEqualToString:@""])
    {
        *errorMsg = L(@"verifyCode_NotNull");
        return NO;
    }
    
    NSString *verifyCodeRegex = [NSString stringWithFormat:@"([a-z,A-Z,0-9]+)"];
    NSPredicate *verifyCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verifyCodeRegex];
    if ([verifyCodeTest evaluateWithObject:code]==NO)
    {
        *errorMsg = L(@"Please_input_correct_VerifyNum");
        return NO;
    }
    return YES;
}

@end
