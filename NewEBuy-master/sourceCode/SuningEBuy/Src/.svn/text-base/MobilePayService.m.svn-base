//
//  MobilePayService.m
//  SuningEBuy
//
//  Created by shasha on 12-9-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MobilePayService.h"

#define kERRORCOUNT     @"errorCount"
#define kLASTERRORTIME  @"lastErrorTime"


@interface MobilePayService ()
{
    NSUserDefaults *userDefaults;
}
- (void)didSendMobilePayHttpRequestFinished:(BOOL)isSuccess;
- (void)didSendHuifuMobilePayHttpRequestFinished:(BOOL)isSuccess;
- (void)didSendPayOnBankHttpRequestFinished:(BOOL)isSuccess
                                        url:(NSURL *)url
                                        xml:(NSString *)xml;

@end

@implementation MobilePayService
@synthesize delegate = _delegate;
@synthesize orderNumber = _orderNumber;


- (void)dealloc {
    
    _delegate = nil;
    
    TT_RELEASE_SAFELY(_orderNumber);
    
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}


-(void)httpMsgRelease{
    
    HTTPMSG_RELEASE_SAFELY(mobilePayHttpMsg);
    HTTPMSG_RELEASE_SAFELY(huifuPayHTTpMsg);
    HTTPMSG_RELEASE_SAFELY(payOnBankHttpMsg);
    HTTPMSG_RELEASE_SAFELY(mobilePaySdkHttpMsg);
}


-(void)didSendMobilePayHttpRequestFinished:(BOOL)isSuccess{
    
    if ([self.delegate respondsToSelector:@selector(didSendMobilePayCompleted:errorMsg:)]) {
        
        if (isSuccess) {
            
            [self.delegate  didSendMobilePayCompleted:YES errorMsg:nil];
            
        }else{
            
            [self.delegate didSendMobilePayCompleted:NO errorMsg:self.errorMsg];
            
        }
        
    }
}

-(void)didSendHuifuMobilePayHttpRequestFinished:(BOOL)isSuccess{
    
    if ([self.delegate respondsToSelector:@selector(didSendHuifuMobilePayCompleted:errorMsg:)]) {
        if (isSuccess) {
            [self.delegate didSendHuifuMobilePayCompleted:isSuccess errorMsg:nil];
        }else{
            [self.delegate didSendHuifuMobilePayCompleted:isSuccess errorMsg:self.errorMsg];
        }
    }
}

- (void)didSendPayOnBankHttpRequestFinished:(BOOL)isSuccess url:(NSURL *)url xml:(NSString *)xml
{
    
    if ([self.delegate respondsToSelector:@selector(didSendPayOnBankCompleted:errorMsg:punchoutUrl:punchoutForm:)]) {
        if (isSuccess) {
            [self.delegate didSendPayOnBankCompleted:isSuccess errorMsg:nil punchoutUrl:url
                                        punchoutForm:xml];
        }else{
            [self.delegate didSendPayOnBankCompleted:isSuccess errorMsg:self.errorMsg punchoutUrl:url punchoutForm:xml];
        }
    }
    
    
}
#pragma mark -
#pragma mark - send http request for getting whole Information

//手机充值提交订单

- (void)beginSendMobilePayHttpRequest:(payMobileOrderDTO *)orderDTO yifubaoPassWord:(NSString *)password validateCode:(NSString *)validateCode {
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:orderDTO.mobileNumber?orderDTO.mobileNumber:@"" forKey:@"mobileNum"];
    
    [postDataDic setObject:orderDTO.payPrice?orderDTO.payPrice:@"" forKey:@"fillMoney"];
    
    [postDataDic setObject:orderDTO.ispType?orderDTO.ispType:@"" forKey:@"ispType"];
    
    [postDataDic setObject:orderDTO.provinceId?orderDTO.provinceId:@"" forKey:@"provinceId"];
    
    [postDataDic setObject:orderDTO.provinceName?orderDTO.provinceName:@"" forKey:@"provinceName"];
    
    [postDataDic setObject: orderDTO.providerNO?orderDTO.providerNO:@"" forKey:@"providerNo"];
    
    [postDataDic setObject:kPartnerValue forKey:kPartnerKey];
    
    NSString *accountNo = [UserCenter defaultCenter].userInfoDTO.accountNo;
    [postDataDic setObject:accountNo?accountNo:@"" forKey:@"accountNO"];
    
    NSString *passwordMD5 = [NSString md5HexDigest:password];
    [postDataDic setObject:passwordMD5?passwordMD5:@"" forKey:@"yfbpassword"];
    //
    [postDataDic setObject:validateCode forKey:@"validateCode"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, [@"SNMTMobilePayConfirm" passport]];
    
    HTTPMSG_RELEASE_SAFELY(mobilePayHttpMsg);
    
    mobilePayHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_MobilePay];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:mobilePayHttpMsg];
    
}


- (void)beginSendHuifuMobilePayHttpRequest:(payMobileOrderDTO *)orderDTO{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:orderDTO.mobileNumber?orderDTO.mobileNumber:@"" forKey:@"mobileNum"];
    
    [postDataDic setObject:orderDTO.payPrice?orderDTO.payPrice:@"" forKey:@"amount"];
    
    NSString *accountNo = [UserCenter defaultCenter].userInfoDTO.accountNo;
    [postDataDic setObject:accountNo?accountNo:@""  forKey:@"accountNO"];
    
    [postDataDic setObject:orderDTO.ispType?orderDTO.ispType:@"" forKey:@"ispType"];
    
    [postDataDic setObject:orderDTO.provinceId?orderDTO.provinceId:@"" forKey:@"provinceId"];
    
    [postDataDic setObject:orderDTO.providerNO?orderDTO.providerNO:@"" forKey:@"providerNO"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, @"SNMCreatelPhonePayOrder"];
    
    HTTPMSG_RELEASE_SAFELY(huifuPayHTTpMsg);
    
    huifuPayHTTpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_HuifuMobilePay];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:huifuPayHTTpMsg];
    
}

- (void)beginsendPayOnSdkBankHttpRequest:(payMobileOrderDTO *)orderDTO
{//sdk
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:@"SN_IPHONE" forKey:@"partner"];
    [postDataDic setObject:orderDTO.mobileNumber forKey:@"mobileNum"];
    [postDataDic setObject:orderDTO.payPrice forKey:@"amount"];
    [postDataDic setObject:orderDTO.ispType forKey:@"ispType"];
    [postDataDic setObject:orderDTO.provinceId forKey:@"provinceId"];
    [postDataDic setObject:orderDTO.providerNO forKey:@"providerNO"];
    NSString* str = [orderDTO.provinceName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [postDataDic setObject:str forKey:@"provinceName"];
    [postDataDic setObject:@"12" forKey:@"terminalId"];
    NSString *url = [NSString stringWithFormat:@"%@/mylife/private/mobilePay.html",kEbuyWapHostURL];

    HTTPMSG_RELEASE_SAFELY(payOnBankHttpMsg);
    
    mobilePaySdkHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_MobilePaySdkOnBank];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:mobilePaySdkHttpMsg];
}

- (void)beginsendPayOnBankHttpRequest:(payMobileOrderDTO *)orderDTO;
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:@"SN_IPHONE" forKey:@"partner"];
    [postDataDic setObject:orderDTO.mobileNumber forKey:@"mobileNum"];
    [postDataDic setObject:orderDTO.payPrice forKey:@"fillMoney"];
    [postDataDic setObject:orderDTO.factPayPrice forKey:@"payAmount"];
    [postDataDic setObject:orderDTO.ispType forKey:@"ispType"];
    [postDataDic setObject:orderDTO.provinceId forKey:@"provinceId"];
    [postDataDic setObject:orderDTO.providerNO forKey:@"providerNo"];
    [postDataDic setObject:@"2" forKey:@"unionPayVersion"];
    
//    NSString *accountNo = [UserCenter defaultCenter].userInfoDTO.accountNo;
//    [postDataDic setObject:accountNo forKey:@"accountNO"];
    NSString *custNO = [UserCenter defaultCenter].userInfoDTO.memberCardNo;
    [postDataDic setObject:custNO forKey:@"accountNO"];

    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, [@"SNMTCreateYinLianOrder" passport]];
    
    HTTPMSG_RELEASE_SAFELY(payOnBankHttpMsg);
    
    payOnBankHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_MobilePayOnBank];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:payOnBankHttpMsg];
    
}


-(void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    switch (receiveMsg.cmdCode) {
        case CC_MobilePay:{
            [self didSendMobilePayHttpRequestFinished:NO];
        }
            break;
        case CC_MobilePaySdkOnBank:
        {
            [self didSendPayOnSdkHttpRequestFinished:NO xml:nil];
        }
            break;
        case CC_HuifuMobilePay:{
            [self didSendHuifuMobilePayHttpRequestFinished:NO];
        }
            break;
        case CC_MobilePayOnBank:{
            [self didSendPayOnBankHttpRequestFinished:NO url:nil xml:nil];
        }
            break;
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    NSDictionary *items = receiveMsg.jasonItems;
   
    if (receiveMsg.jasonItems == nil) {
        
        self.errorMsg = kHttpResponseJSONValueFailError;
        
        [self didSendMobilePayHttpRequestFinished:NO];
        
    }
    else
    {
        switch (receiveMsg.cmdCode)
        {
            case CC_MobilePay:{
                NSString *isSuccss = [items objectForKey:@"returncode"];
                
                if (!IsStrEmpty(isSuccss)&&[isSuccss isEqualToString:@"1"]) {
                    NSString *orderNumStr = [items objectForKey:@"orderNo"];
                    
                    self.orderNumber = IsStrEmpty(orderNumStr)?@"":orderNumStr;
                    
                    [self didSendMobilePayHttpRequestFinished:YES];
                    
                }
                else
                {
                    
                    NSString *errorCode = [items objectForKey:@"errorCode"];
                    
                    if (!IsStrEmpty(errorCode)) {
                        
                        self.errorMsg = errorCode;
                        
                    }else{
                        
                        self.errorMsg = kVirsualMobilePayFaildDesc;
                    }
                    
                    [self didSendMobilePayHttpRequestFinished:NO];
                }
                
            }
                break;
            case CC_MobilePaySdkOnBank:{

                NSDictionary* ddic = [items objectForKey:@"data"];
                NSString *isSuccess = [ddic objectForKey:@"isSuccess"];
                //NSString *tempCode = [items objectForKey:@"code"];
                if (NotNilAndNull(isSuccess) && [isSuccess isEqualToString:@"T"])
                {
                    NSString *xml = [ddic objectForKey:@"orderInfo"];
                    if(NotNilAndNull(xml))
                    {
                        [self didSendPayOnSdkHttpRequestFinished:YES xml:xml];
                    }
                    else
                    {
                        [self didSendPayOnSdkHttpRequestFinished:YES xml:nil];
                    }

                }
                else
                {
                    NSString *errorCode = [ddic objectForKey:@"returnCode"];
                    
                    if (!IsStrEmpty(errorCode)) {
                        
                        NSString *errorDesc = [ddic objectForKey:@"errorDesc"];
                        self.errorMsg = errorDesc;
                        
                    }
                    [self didSendPayOnSdkHttpRequestFinished:NO xml:nil];
                }
            }
                break;
            case CC_HuifuMobilePay:{
                
                NSString *isSuccss = [items objectForKey:@"isSuccess"];
                
                if (!IsStrEmpty(isSuccss)&&[isSuccss isEqualToString:@"1"]) {
                    
                    NSString *orderNumStr = [items objectForKey:@"payOrderId"];
                    
                    self.orderNumber = IsStrEmpty(orderNumStr)?@"":orderNumStr;
                    
                    [self didSendHuifuMobilePayHttpRequestFinished:YES];
                    
                }else{
                    
                    NSString *errorCode = [items objectForKey:@"desc"];
                    
                    if (!IsStrEmpty(errorCode)) {
                        
                        self.errorMsg = errorCode;
                        
                    }
                    else{
                        
                        self.errorMsg = kVirsualMobilePayFaildDesc;
                    }
                    
                    [self didSendHuifuMobilePayHttpRequestFinished:NO];
                }
            }
                break;
            case CC_MobilePayOnBank:
            {
                NSString *isSuccess = [items objectForKey:@"isSuccess"];
                
                if (NotNilAndNull(isSuccess) && [isSuccess isEqualToString:@"T"]) {
                    NSString *xml = [items objectForKey:@"netpayInfo"];
                    xml = [xml stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                    xml = [xml stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                    xml = [xml stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
                    xml = [xml stringByReplacingOccurrencesOfString:@"&#xd;" withString:@" "];
                    xml = [xml stringByReplacingOccurrencesOfString:@"&#92;" withString:@"\\"];
                    
                    DLog(@"replace xml:%@",xml);
                    if(NotNilAndNull(xml))
                    {
                        [self didSendPayOnBankHttpRequestFinished:YES url:nil xml:xml];
                    }
                    else
                    {
                        [self didSendPayOnBankHttpRequestFinished:YES url:nil xml:nil];
                    }
                }
                else{
                    
                    NSString *errorCode = [items objectForKey:@"errorCode"];
                    
                    if (!IsStrEmpty(errorCode)) {
                        
                        NSString *errorDesc = [items objectForKey:@"errorDesc"];
                        self.errorMsg = errorDesc;
                        
                    }
                    else{
                        if ([errorCode isEqualToString:@"300001"]) {
                            
                            self.errorMsg = kBankCardPayOrderNOEmpty;
                            
                        }
                        else if([errorCode isEqualToString:@"300002"])
                        {
                            self.errorMsg = kBankCardPayVipNOEmpty;
                            
                        }
                        else if([errorCode isEqualToString:@"300003"])
                        {
                            self.errorMsg = kBankCardPayOrderAmoutError;
                            
                        }
                        else if([errorCode isEqualToString:@"300004"])
                        {
                            self.errorMsg = kBankCardPayYifubaoAmoutError;
                            
                        }else if([errorCode isEqualToString:@"300005"])
                        {
                            self.errorMsg = kBankCardPayOrderInfoFail;
                            
                        }else if([errorCode isEqualToString:@"300006"])
                        {
                            self.errorMsg = kBankCardPayOrderNotExist;
                            
                        }else if([errorCode isEqualToString:@"300007"])
                        {
                            self.errorMsg = kBankCardPayAmoutNotEqual;
                            
                        }else if([errorCode isEqualToString:@"300008"])
                        {
                            self.errorMsg = kBankCardPayOrderNOtWaitPay;
                            
                        }else if([errorCode isEqualToString:@"300009"])
                        {
                            self.errorMsg = kBankCardPayValidateCodeEmpty;
                            
                        }else if([errorCode isEqualToString:@"300010"])
                        {
                            self.errorMsg = kBankCardPayPayPswEmpty;
                            
                        }else if([errorCode isEqualToString:@"300011"])
                        {
                            self.errorMsg = kBankCardPayInOrderTableFail;
                            
                        }else if([errorCode isEqualToString:@"3000012"])
                        {
                            self.errorMsg = kBankCardPayMethodEmpty;
                            
                        }else if([errorCode isEqualToString:@"3000013"])
                        {
                            self.errorMsg = kBankCardPayProductOffShelf;
                            
                        }else if([errorCode isEqualToString:@"3000014"])
                        {
                            self.errorMsg = kBankCardPayYifubaoAmoutFail;
                            
                        }else if([errorCode isEqualToString:@"300015"])
                        {
                            self.errorMsg = kBankCardPaySavePayInfoFail;
                            
                        }else if([errorCode isEqualToString:@"300016"])
                        {
                            self.errorMsg = kBankCardPayOrderPayFail;
                            
                        }else if([errorCode isEqualToString:@"300017"])
                        {
                            self.errorMsg = kBankCardValidateYifubaoPswFail;
                            
                        }else if([errorCode isEqualToString:@"300018"])
                        {
                            self.errorMsg = kBankCardPayProuctAmoutNotEnough;
                            
                        }else if([errorCode isEqualToString:@"300019"])
                        {
                            self.errorMsg = kBankCardGroupBuyEnd;
                            
                        }else if([errorCode isEqualToString:@"300020"])
                        {
                            self.errorMsg = kBankCardPayQueryEppOrderStateFail;
                            
                        }
                    }
                    
                    [self didSendPayOnBankHttpRequestFinished:NO url:nil xml:nil];

                }
                
            }
                break;
                
            default:
                break;
        }
        
        
    }
    
}

- (void)didSendPayOnSdkHttpRequestFinished:(BOOL)isSuccess xml:(NSString *)xml
{
    if ([self.delegate respondsToSelector:@selector(didSendMobileSdkPayCompleted:xml:code:)])
    {
        if (isSuccess)
        {
            [self.delegate didSendMobileSdkPayCompleted:isSuccess xml:xml code:nil];
        }
        else
        {
            [self.delegate didSendMobileSdkPayCompleted:isSuccess xml:xml code:self.errorMsg];
        }
    }
}

@end

