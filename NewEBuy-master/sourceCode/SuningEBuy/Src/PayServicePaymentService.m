//
//  PayServicePaymentService.m
//  SuningEBuy
//
//  Created by 谢 伟 on 12-10-11.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PayServicePaymentService.h"

@interface PayServicePaymentService ()
{
    NSInteger          _selectedPayModeRow;
}

- (void)sendPaymentApplyHttpRequestWith:(PayServiceDTO *)payServiceDTO
                                PayMode:(NSInteger)selectedPayMode
                            PayPassword:(NSString *)payPassword;
- (void)getPaymentApplyDidFinish:(BOOL)isSuccess;


@end


@implementation PayServicePaymentService

@synthesize payDataSource = _payDataSource;
@synthesize wwwUrl = _wwwUrl;
@synthesize desc = _desc;
@synthesize isNotSuccess = _isNotSuccess;
@synthesize delegate = _delegate;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_payDataSource);
    TT_RELEASE_SAFELY(_wwwUrl);
    TT_RELEASE_SAFELY(_desc);
    
}


-(void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(efubaoHttpMsg);
    HTTPMSG_RELEASE_SAFELY(paymentApplyHttpMsg);
    HTTPMSG_RELEASE_SAFELY(payOnBankHttpMsg);
}

- (PayServiceDTO *)payDataSource
{
    if (!_payDataSource) {
        _payDataSource = [[PayServiceDTO alloc] init];
    }
    
    return _payDataSource;
}


- (void)beginGetPaymentApplyWith:(PayServiceDTO *)payServiceDTO
                         PayMode:(NSInteger)selectedPayMode
                     PayPassword:(NSString *)payPassword
{
    [self sendPaymentApplyHttpRequestWith:payServiceDTO PayMode:selectedPayMode PayPassword:payPassword];
}


- (void)sendPaymentApplyHttpRequestWith:(PayServiceDTO *)payServiceDTO
                                PayMode:(NSInteger)selectedPayMode
                            PayPassword:(NSString *)payPassword
{
    NSString *url;
    _selectedPayModeRow = selectedPayMode;
    self.payDataSource = payServiceDTO;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    //yifubaozhifu
    if (_selectedPayModeRow == 0) {
        [postDataDic setObject:self.payDataSource.model forKey:@"modelId"];
        NSString *passwordMD5 = [NSString md5HexDigest:payPassword];
        [postDataDic setObject:passwordMD5 forKey:@"password"];
        url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps, [@"SNMTChargeBillPay" passport]];
    }
    else
    {
        [postDataDic setObject:self.payDataSource.model forKey:@"modelId"];
        url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,@"SNMChargeCreateOreder"];
    }
	
	[postDataDic setObject:self.payDataSource.chargeAccount forKey:@"chargeAccount"];
    [postDataDic setObject:self.payDataSource.customerName forKey:@"customerName"];

//    [postDataDic setObject:self.payDataSource.accountNo forKey:@"accountNo"];
    [postDataDic setObject:self.payDataSource.payAmount forKey:@"payAmount"];
    [postDataDic setObject:self.payDataSource.contractNo forKey:@"contractNo"];
    [postDataDic setObject:self.payDataSource.beginDate forKey:@"beginDate"];
    [postDataDic setObject:self.payDataSource.endDate forKey:@"endDate"];
    [postDataDic setObject:self.payDataSource.accountTerm forKey:@"accountTerm"];
    
    [postDataDic setObject:[UserCenter defaultCenter].userInfoDTO.custNum forKey:@"custNO"];
    [postDataDic setObject:@"SN_IPHONE" forKey:@"partner"];

    
    HTTPMSG_RELEASE_SAFELY(paymentApplyHttpMsg);
    
    paymentApplyHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_PaymentApply];
    
    [self.httpMsgCtrl sendHttpMsg:paymentApplyHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}
- (void)beginsendPayOnSdkBankHttpRequest:(PayServiceDTO *)orderDTO
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:@"SN_IPHONE" forKey:@"partner"];
    [postDataDic setObject:orderDTO.model forKey:@"modelId"];
    [postDataDic setObject:orderDTO.chargeAccount forKey:@"chargeAccount"];
    [postDataDic setObject:orderDTO.customerName forKey:@"customerName"];
    [postDataDic setObject:orderDTO.payAmount forKey:@"payAmount"];
    [postDataDic setObject:orderDTO.contractNo forKey:@"contractNo"];
    [postDataDic setObject:orderDTO.beginDate forKey:@"beginDate"];
    [postDataDic setObject:orderDTO.endDate forKey:@"endDate"];
    [postDataDic setObject:orderDTO.accountTerm forKey:@"accountTerm"];
    [postDataDic setObject:@"12" forKey:@"terminalId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/mylife/private/lifeCharge.html", kEbuyWapHostURL];
    
    HTTPMSG_RELEASE_SAFELY(payOnBankHttpMsg);
    
    payOnBankHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_GDWPaySdkOnBank];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:payOnBankHttpMsg];
}

- (void)beginsendPayOnBankHttpRequest:(PayServiceDTO *)orderDTO
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:@"SN_IPHONE" forKey:@"partner"];
    [postDataDic setObject:orderDTO.model forKey:@"modelId"];
    [postDataDic setObject:orderDTO.chargeAccount forKey:@"chargeAccount"];
    [postDataDic setObject:[UserCenter defaultCenter].userInfoDTO.memberCardNo forKey:@"custNO"];
    [postDataDic setObject:orderDTO.customerName forKey:@"customerName"];
    [postDataDic setObject:orderDTO.payAmount forKey:@"payAmount"];
    [postDataDic setObject:orderDTO.contractNo forKey:@"contractNo"];
    [postDataDic setObject:orderDTO.beginDate forKey:@"beginDate"];
    [postDataDic setObject:orderDTO.endDate forKey:@"endDate"];
    [postDataDic setObject:orderDTO.accountTerm forKey:@"accountTerm"];
    [postDataDic setObject:@"2" forKey:@"unionPayVersion"];//银联2.0
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, [@"SNMTChargeUnionPayOrder" passport]];
    
    HTTPMSG_RELEASE_SAFELY(payOnBankHttpMsg);
    
    payOnBankHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_PaymentPayOnBank];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:payOnBankHttpMsg];
    
}

#pragma mark -
#pragma mark 网络请求回调
- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
        case CC_PaymentApply:
            
            [self getPaymentApplyDidFinish:NO];
            
            break;
        case CC_GDWPaySdkOnBank:
            [self didSendPayOnSdkHttpRequestFinished:NO xml:nil];
            break;
        case CC_PaymentPayOnBank:
            [self didSendPayOnBankHttpRequestFinished:NO url:nil xml:nil];
            break;
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    
    switch (receiveMsg.cmdCode) {
        case CC_PaymentApply:
            if (_selectedPayModeRow == 0) {
                
                [self parseApplyInfo:items];
            }
            else
            {
                
                if ([[items objectForKey:@"isSuccess"] isEqualToString:@"1"])
                {
                    
                    NSString *key = [items objectForKey:@"payId"];
                    
                    if ([key isEqualToString:@""] || key == nil) {
                        DLog(@"payId is  nil");
                        [self getPaymentApplyDidFinish:NO];
                    }else {
                        
                        self.wwwUrl = [NSString stringWithFormat:@"%@=%@",kHostHuiFuHttp,key];
                        DLog(@"shuidianmei url is  %@",self.wwwUrl);
                        [self getPaymentApplyDidFinish:YES];
                    }
                }else {
                    NSString *desc = [items objectForKey:@"desc"];
                    DLog(@"shuidianmei url is  %@",desc);
                    if (![desc isEqualToString:@""]) {
                        self.isNotSuccess = YES;
                        self.desc = desc;
                        [self getPaymentApplyDidFinish:NO];
                    }
                }
            }
            break;
        case CC_GDWPaySdkOnBank:
        {
            NSDictionary* ddic = [items objectForKey:@"data"];
            NSString *isSuccess = [ddic objectForKey:@"isSuccess"];
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
        case CC_PaymentPayOnBank:
        {
            
            NSString *isSuccess = [items objectForKey:@"isSuccess"];
            
            if (NotNilAndNull(isSuccess) && [isSuccess isEqualToString:@"T"]) {
                
                NSString *xml = [items objectForKey:@"netpayInfo"];
                xml = [xml stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                xml = [xml stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                xml = [xml stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
                xml = [xml stringByReplacingOccurrencesOfString:@"&#xd;" withString:@" "];
                xml = [xml stringByReplacingOccurrencesOfString:@"&#92;" withString:@"\\"];
                
                //                    NSLog(@"replace xml:%@",xml);
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
                
                if (!errorCode.length) {
                    
                    NSString *errorDesc = [items objectForKey:@"errorDesc"];
                    self.errorMsg = errorDesc.length?errorDesc:kSERVERBUSY_ERRORDESC;
                    
                }
                else
                {
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
                    else
                    {
                        NSString *errorDesc = [items objectForKey:@"errorDesc"];
                        self.errorMsg = errorDesc.length?errorDesc:kSERVERBUSY_ERRORDESC;
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

- (void)parseApplyInfo:(NSDictionary *)dic
{
    if ([[dic objectForKey:@"errorCode"] isEqualToString:@""])
    {
        NSString *efubao = [NSString stringWithFormat:@"%.2f", [[[[UserCenter  defaultCenter] userInfoDTO] yifubaoBalance] doubleValue] - [self.payDataSource.payAmount doubleValue]/100];
        
        [[UserCenter defaultCenter] userInfoDTO].yifubaoBalance = efubao;
        
        self.desc = [dic objectForKey:@"payInfo"];
        
        [self getPaymentApplyDidFinish:YES];
    }
    else
    {
        self.desc = [dic objectForKey:@"errorCode"];
        
        [self getPaymentApplyDidFinish:NO];
    }
}

#pragma mark -
#pragma mark 调用回调函数

- (void)getPaymentApplyDidFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getPaymentApplyCompleteWithService:Result:errorMsg:)]) {
        [_delegate getPaymentApplyCompleteWithService:self Result:isSuccess errorMsg:self.errorMsg];
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
- (void)didSendPayOnSdkHttpRequestFinished:(BOOL)isSuccess xml:(NSString *)xml
{
    if ([self.delegate respondsToSelector:@selector(didSendPaySdkOnBankCompleted:xml:code:)])
    {
        if (isSuccess)
        {
            [self.delegate didSendPaySdkOnBankCompleted:isSuccess xml:xml code:nil];
        }
        else
        {
            [self.delegate didSendPaySdkOnBankCompleted:isSuccess xml:xml code:self.errorMsg];
        }
    }
}
@end
