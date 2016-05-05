//
//  MobileRechargeNewService.m
//  SuningEBuy
//
//  Created by 家兴 王 on 12-9-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MobileRechargeNewService.h"
#import "payMobileOrderDTO.h"

@implementation MobileRechargeNewService

@synthesize delegate=_delegate;
@synthesize preferentPrice;
@synthesize providerNO;
@synthesize backError;
@synthesize numberInfo;
@synthesize ispCode;
@synthesize ispName;
@synthesize ispType;
@synthesize provinceId;
@synthesize provinceName;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(checkPreferentialMsg);
    HTTPMSG_RELEASE_SAFELY(checkMobileNumberMsg);
    
    [super httpMsgRelease];
}

#pragma mark -
#pragma mark Preferential

- (void)beginGetCheckPreferential:(NSString *)phoneNum money:(NSString *)money
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:phoneNum,@"mobileNum",money,@"fillMoney",kPartnerValue,kPartnerKey, nil];
    
    if (!isLoadingCheckPreferential) {
        [self sendCheckPreferentialHttpRequest:dic];
    }
    TT_RELEASE_SAFELY(dic);
}

- (void)sendCheckPreferentialHttpRequest:(NSDictionary *)parametersDic
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, kCheckPreferentialPrice];
    
    isLoadingCheckPreferential=YES;
    
    HTTPMSG_RELEASE_SAFELY(checkPreferentialMsg);
    
    checkPreferentialMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:parametersDic
                                                         cmdCode:CC_Preferential];
    checkPreferentialMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:checkPreferentialMsg];
}

- (void)getCheckPreferentialFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getCheckPreferentialHttpRequestCompletedWithService:isSucess:errorCode:)]) {
        [_delegate getCheckPreferentialHttpRequestCompletedWithService:self isSucess:isSuccess errorCode:self.errorMsg];
    }
}

#pragma mark -
#pragma mark MobilNumber
- (void)beginGetCheckMobileNumber:(NSString *)mobileNumber
{
    if (!isLoadingCheckMobileNumber) {
        [self sendCheckMobileNumberHttpRequest:mobileNumber];
    }
}

- (void)sendCheckMobileNumberHttpRequest:(NSString *)mobileNumber
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                         kIspTypeAndProviceValue,kIspTypeAndProviceKey,
                         mobileNumber?mobileNumber:@"",kMobileNumberKey,
                         kPartnerValue,kPartnerKey,nil];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, kIspTypeAndProviceForNumber];
    
    isLoadingCheckMobileNumber=YES;
    
    HTTPMSG_RELEASE_SAFELY(checkMobileNumberMsg);
    
    checkMobileNumberMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:dic
                                                         cmdCode:CC_MobileNumber];
    checkMobileNumberMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:checkMobileNumberMsg];
    
    TT_RELEASE_SAFELY(dic);
}

- (void)getCheckMobileNumberFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getCheckMobileNumberHttpRequestCompletedWithService:isSucess:errorCode:)]) {
        [_delegate getCheckMobileNumberHttpRequestCompletedWithService:self isSucess:isSuccess errorCode:self.errorMsg];
    }
}

#pragma mark -
#pragma mark delegate
- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    [super receiveDidFailed:receiveMsg];
    
    isLoadingCheckPreferential = NO;
    isLoadingCheckMobileNumber = NO;
    
    switch (receiveMsg.cmdCode) {
        case CC_Preferential:
        {
            [self getCheckPreferentialFinish:NO];
        }
            break;
            
        case CC_MobileNumber:
        {
            [self getCheckMobileNumberFinish:NO];
        }
            break;
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    isLoadingCheckPreferential = NO;
    isLoadingCheckMobileNumber = NO;
    
    NSDictionary *items = receiveMsg.jasonItems;
        
    switch (receiveMsg.cmdCode) {
        case CC_Preferential:
        {
            if (!items)
            {
                self.errorMsg = L(@"load_failed");
                
                [self getCheckPreferentialFinish:NO];
                
                return;
            }
            else
            {
                [self parserResponseMessage:items];
            }
        }
            break;
            
        case CC_MobileNumber:
        {
            if (!items) {
                self.errorMsg = L(@"load_failed");
                
                [self getCheckMobileNumberFinish:NO];
                
                return;
            }
            else
            {
                [self parserMobileNumberResponseMessage:items];
            }
        }
            break;
            
        default:
            break;
    }
    
}


#pragma mark -
#pragma mark methods
- (void)parserResponseMessage:(NSDictionary *)dic
{
	
    backError = [dic objectForKey:@"errorCode"];
    
    if (IsStrEmpty(backError)) {
        
        self.preferentPrice=[dic objectForKey:@"reduceMoney"];
        self.providerNO=[dic objectForKey:@"providerNO"];
        [self getCheckPreferentialFinish:YES];
    }else{
    
        self.errorMsg = backError;
        [self getCheckPreferentialFinish:NO];

    }
}

- (void)parserMobileNumberResponseMessage:(NSDictionary *)dic
{
    if ([[dic objectForKey:kHttpResponseErrorCode] isEqualToString:@""]) {
        
        self.numberInfo = [dic objectForKey:@"provinceName"];
        
        self.ispCode = [dic objectForKey:@"ispType"];
        
        self.ispName = [dic objectForKey:@"ispName"];
        
        if (IsStrEmpty(self.ispName)) {
            if ([self.ispCode isEqualToString: @"0"]) {
                self.ispName = L(@"Unicom");
            }else if ([ispCode isEqualToString: @"1"])
                self.ispName = L(@"Mobile");
            else if ([ispCode isEqualToString: @"2"])
                self.ispName = L(@"Telecom");
            else
                self.ispName = @"";
        }
        
        self.numberInfo = [numberInfo stringByAppendingString: self.ispName];
        
        DLog(@"numberInfo =%@", numberInfo);
        
        self.ispType = [dic objectForKey:@"ispType"];
        
        self.provinceId = [dic objectForKey:@"provinceId"];
        
        self.provinceName = [dic objectForKey:@"provinceName"];
        
        [self getCheckMobileNumberFinish:YES];
        
    }else{
    
        NSString *errorDesc = [dic objectForKey:@"errorDesc"];
        
        if (IsStrEmpty(errorDesc)) {
            errorDesc = kSERVERBUSY_ERRORDESC;
        }
        
        self.errorMsg = errorDesc;
        
        [self getCheckMobileNumberFinish:NO];
    }
    
}
@end
