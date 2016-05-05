//
//  FlightOrderService.m
//  SuningEBuy
//
//  Created by admin on 12-9-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "FlightOrderService.h"
#import "BoardingInfoDTO.h"
#import "FlightRoomInfoDTO.h"
#import "PlanTicketSwitch.h"

@interface  FlightOrderService()

//包装传递的用户信息
- (void)saveUserInfoToPostDic:(NSMutableDictionary *)dic
                CustomerCount:(int)customerCount;
//包装常用登机人信息
- (void)saveBoardingList:(NSMutableDictionary *)dic
             BordingList:(NSMutableArray *)bordingList;
//包装地址信息
- (void)saveAddressInfo:(NSMutableDictionary *)dic
            AddressInfo:(AddressInfoDTO*)addressInfoDTO
            AddressType:(NSString *)addressType;
//封装机票信息
- (void)packToDictionary:(NSMutableDictionary *)postDataDic
                     key:(NSString *)key
                     dto:(FlightInfoDTO *)dto;

- (void)didSendFlightOrderSubmitRequestFinished:(BOOL)isSuccess
                                      ErrorCode:(NSString *)errorCode;

- (void)didSendPayOnBankRequestFinished:(BOOL)isSuccess
                                    xml:(NSString *)xml
                              errorCode:(NSString *)errorCode;

- (void)saveInsuranceInToDic:(NSMutableDictionary *)dic
                   Insurance:(InsuranceDTO *)insurance
                boardingList:(NSArray *)bordingList
                    isOneWay:(BOOL)isOneWay;

- (void)payByEppOk:(BOOL)isSuccess status:(int)status;
- (void)payByHftxOk:(BOOL)isSuccess payUrl:(NSString *)url status:(int)status;

- (void)parseEppPayItem:(NSDictionary *)items;
- (void)parseHftxPayItem:(NSDictionary *)items;
- (void)parsePayOnBankItem:(NSDictionary *)items;

@end

@implementation FlightOrderService

@synthesize delegate = _delegate;
@synthesize orderStatus = _orderStatus;

@synthesize orderId = _orderId;
@synthesize shouldPay = _shouldPay;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_shouldPay);
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(flghtOrderSubmitMsg);
    HTTPMSG_RELEASE_SAFELY(payByEppHttpMsg);
    HTTPMSG_RELEASE_SAFELY(payByHftxHttpMsg);
    HTTPMSG_RELEASE_SAFELY(payOnBankHttpMsg);
}

- (id)init {
    self = [super init];
    if (self) {
        _shouldPay = nil;
        _orderStatus = eOrderFail;
    }
    return self;
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    
    NSDictionary *items = receiveMsg.jasonItems;
    
    switch (receiveMsg.cmdCode)
    {
        case CC_FlightPayByEpp:
        {
            if (!items)
            {
                self.errorMsg = L(@"BTSorryForPayFail");
                [self payByEppOk:NO status:0];
            }
            else
            {
                [self parseEppPayItem:items];
            }
            
            break;
        }
        case CC_FlightPayByHftx:
        {
            if (!items)
            {
                self.errorMsg = L(@"BTSorryForPayFail");
                [self payByHftxOk:NO payUrl:nil status:0];
            }
            else
            {
                [self parseHftxPayItem:items];
            }
            
            break;
        }
        case CC_FlightOrderSubmit:
        {
            [self parseAddrsList:items];
            
            break;
        }
        case CC_FlightPayOnBank:
        {
            [self parsePayOnBankItem:items];
            
            break;
        }
            
        default:
            break;
    }
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode)
    {
        case CC_FlightPayByEpp:
        {
            [self payByEppOk:NO status:0];
        }
            break;
        case CC_FlightPayByHftx:
        {
            [self payByHftxOk:NO payUrl:nil status:0];
        }
            break;
        case CC_FlightOrderSubmit:
        {
            
            [self didSendFlightOrderSubmitRequestFinished:NO ErrorCode:nil];
        }
            
            break;
        case CC_FlightPayOnBank:
        {
            [self didSendPayOnBankRequestFinished:NO xml:nil errorCode:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark 易付宝支付

- (void)beginPaymentByEppWithOrderId:(NSString *)orderId
                              userId:(NSString *)userId
                         epayAccount:(NSString *)epayAccount
                            password:(NSString *)password
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    [postDataDic setObject:orderId?orderId:@"" forKey:@"orderId"];
    [postDataDic setObject:userId?userId:@"" forKey:@"userId"];
    [postDataDic setObject:epayAccount?epayAccount:@"" forKey:@"epayAccount"];
    [postDataDic setObject:password?password:@"" forKey:@"pwd"];
    
    NSString *url = nil;
    if ([PlanTicketSwitch canUserNewServer]) {
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketOctForHttp,KPlaneTicketPayByEpp];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketForHttp,KPlaneTicketPayByEpp];
    }
    
    HTTPMSG_RELEASE_SAFELY(payByEppHttpMsg);
    
    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDataDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        payByEppHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:dic
                                                        cmdCode:CC_FlightPayByEpp];
    }else{
        payByEppHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:postDataDic
                                                        cmdCode:CC_FlightPayByEpp];
    }
    
    payByEppHttpMsg.timeout = kPlaneTicketTimeOut;
    
    [self.httpMsgCtrl sendHttpMsg:payByEppHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)payByEppOk:(BOOL)isSuccess status:(int)status
{
    if ([_delegate respondsToSelector:@selector(paymentByEppCompletionWithResult:errorMsg:status:)])
    {
        [_delegate paymentByEppCompletionWithResult:isSuccess errorMsg:self.errorMsg status:status];
    }
}

- (void)parseEppPayItem:(NSDictionary *)items
{
    NSString *isSucc = [items objectForKey:@"isSucc"];
    NSString *errorString=[items objectForKey:@"errorMsg"];
    
    if ([isSucc isEqualToString:@"1"])  //成功
    {
        [self payByEppOk:YES status:0];
    }
    else
    {
        if ([PlanTicketSwitch canUserNewServer])
        {
            if ([isSucc isEqualToString:@"3"])  //密码错误
            {
                NSUInteger errorTimes = [[items objectForKey:@"passwordErrorTimes"] integerValue];
                
                if (errorTimes >= 3) {
                    self.errorMsg = L(@"BTErrorForCodeThreeTimes");
                }else{
                    self.errorMsg = [NSString stringWithFormat:
                                     L(@"Efubao_Password_Error%d"), 3-errorTimes];
                }
                [self payByEppOk:NO status:0];
            }
            else
            {
                NSString *status = [items objectForKey:@"status"];
                NSInteger statusInt = [status integerValue];
                
                switch (statusInt) {
                    case 1:
                    {
                        self.errorMsg = L(@"BTTicketsNotEnough");
                        break;
                    }
                    case 3:
                    {
                        self.errorMsg = L(@"BTOrderHasOverrun");
                        break;
                    }
                    case 5:
                    {
                        self.errorMsg = L(@"BTOrderHasOverrun2");
                        break;
                    }
                    case 2:
                    case 4:
                    case 6:
                    default:
                    {
                        self.errorMsg  = L(@"BTSorryForSystermBusy");
                        break;
                    }
                }
                [self payByEppOk:NO status:statusInt];
            }
            
        }
        else
        {
            if([errorString isEqualToString:L(@"BTCodeErrorThirdTimes")])
            {
                self.errorMsg = L(@"BTErrorForCodeThreeTimes");
            }else{
                self.errorMsg = NotNilAndNull(errorString)?errorString:L(@"GBOrderPayFail");
                [self payByEppOk:NO status:0];
            }
        }
        
        
    }
}

#pragma mark -
#pragma mark 汇付支付

- (void)beginPaymentByHftxWithOrderId:(NSString *)orderId
                               userId:(NSString *)userId
                          epayAccount:(NSString *)epayAccount
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [postDataDic setObject:orderId?orderId:@"" forKey:@"orderId"];
    [postDataDic setObject:userId?userId:@"" forKey:@"userId"];
    [postDataDic setObject:epayAccount?epayAccount:@"" forKey:@"epayAccount"];
    
    NSString *url = nil;
    if ([PlanTicketSwitch canUserNewServer]) {
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketOctForHttp,KPlaneTicketPayByHftx];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketForHttp,KPlaneTicketPayByHftx];
    }
    
    HTTPMSG_RELEASE_SAFELY(payByHftxHttpMsg);
    
    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDataDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        
        payByHftxHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:dic
                                                         cmdCode:CC_FlightPayByHftx];
    }else{
        payByHftxHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_FlightPayByHftx];
    }
    
    payByHftxHttpMsg.timeout = kPlaneTicketTimeOut;
    
    [self.httpMsgCtrl sendHttpMsg:payByHftxHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)payByHftxOk:(BOOL)isSuccess payUrl:(NSString *)url status:(int)status
{
    if ([_delegate respondsToSelector:@selector(paymentByHftxCompletionWithResult:errorMsg:payUrl:status:)])
    {
        [_delegate paymentByHftxCompletionWithResult:isSuccess
                                            errorMsg:self.errorMsg
                                              payUrl:url
                                              status:status];
    }
}

- (void)parseHftxPayItem:(NSDictionary *)items
{
    NSString *isSucc = [items objectForKey:@"isSucc"];
    NSString *payUrl = [items objectForKey:@"payUrl"];
    
    if ([PlanTicketSwitch canUserNewServer])
    {
        if ([isSucc isEqualToString:@"1"] && !IsStrEmpty(payUrl))
        {
            [self payByHftxOk:YES payUrl:payUrl status:0];
        }
        else
        {
            NSString *status = [items objectForKey:@"status"];
            NSInteger statusInt = [status integerValue];
            
            switch (statusInt) {
                case 1:
                {
                    self.errorMsg = L(@"BTTicketsNotEnough");
                    break;
                }
                case 3:
                {
                    self.errorMsg = L(@"BTOrderHasOverrun1");
                    break;
                }
                case 2:
                case 4:
                default:
                {
                    self.errorMsg  = L(@"BTSorryForSystermBusy");
                    break;
                }
            }
            
            [self payByHftxOk:NO payUrl:nil status:statusInt];
        }
    }
    else
    {
        if ([isSucc isEqualToString:@"1"] && !IsStrEmpty(payUrl))
        {
            [self payByHftxOk:YES payUrl:payUrl status:0];
        }
        else
        {
            NSString *errore = [items objectForKey:@"errorMsg"];
            self.errorMsg = NotNilAndNull(errore)?errore:L(@"GBOrderPayFail");
            [self payByHftxOk:NO payUrl:nil status:0];
        }
    }
}

#pragma mark - OrderSubmitRequest Methods
#pragma mark   银联支付

-(void)beginsendPayonBankwithOrderId:(NSString *)orderId userId:(NSString *)userId memberId:(NSString *)memeberId payAmout:(NSString *)payAmout
{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [postDataDic setObject:orderId?orderId:@"" forKey:@"orderId"];
    [postDataDic setObject:userId?userId:@"" forKey:@"userId"];
    [postDataDic setObject:payAmout?payAmout:@"" forKey:@"payAmount"];
    [postDataDic setObject:memeberId?memeberId:@"" forKey:@"memberId"];
    [postDataDic setObject:@"18003" forKey:@"paymentType"];
    
    NSString *url = nil;
    if ([PlanTicketSwitch canUserNewServer]) {
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketOctForHttp,KPlaneTicketPayOnBank];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketForHttp,KPlaneTicketPayOnBank];
    }
    
    HTTPMSG_RELEASE_SAFELY(payOnBankHttpMsg);
    
    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDataDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        payOnBankHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:dic
                                                         cmdCode:CC_FlightPayOnBank];
    }else{
        payOnBankHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_FlightPayOnBank];
    }
    
    payOnBankHttpMsg.timeout = kPlaneTicketTimeOut;
    
    [self.httpMsgCtrl sendHttpMsg:payOnBankHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
    
}

-(void)parsePayOnBankItem:(NSDictionary *)items
{
    NSString *errorCode = [items objectForKey:@"errorCode"];
    self.errorMsg = [items objectForKey:@"errorMsg"];
    if ([errorCode isEqualToString:@"0000"])
    {
        NSString *xml = [items objectForKey:@"submitform"];
        xml = [xml stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        xml = [xml stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        xml = [xml stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        xml = [xml stringByReplacingOccurrencesOfString:@"&#xd;" withString:@" "];
        xml = [xml stringByReplacingOccurrencesOfString:@"&#92;" withString:@"\\"];
        
        //        NSLog(@"replace xml:%@",xml);
        
        [self didSendPayOnBankRequestFinished:YES xml:xml errorCode:errorCode];
    }
    else
    {
        
        [self didSendPayOnBankRequestFinished:NO xml:nil errorCode:errorCode];
        
    }
    
}
-(void)didSendPayOnBankRequestFinished:(BOOL)isSuccess xml:(NSString *)xml errorCode:(NSString *)errorCode
{
    
    if ([self.delegate respondsToSelector:@selector(paymentbyOnBankComPletionWithResult:errorMsg:errorCode:xml:)])
    {
        [self.delegate paymentbyOnBankComPletionWithResult:isSuccess errorMsg:self.errorMsg errorCode:errorCode xml:xml];
    }
    
}
#pragma mark - OrderSubmitRequest Methods
#pragma mark   机票订单提交方法

- (void)beginSendOrderSubmitRequest:(int)customerCount
                       BoardingList:(NSMutableArray *)boardingList
                        AddressInfo:(AddressInfoDTO *)addressInfoDTO
                        AddressType:(NSString *)addressType
                     BookPersonName:(NSString *)name
                   BookPersonMobile:(NSString *)mobile
                       GoFlightInfo:(FlightInfoDTO *)goFlightInfoDTO
                     BackFlightInfo:(FlightInfoDTO *)backFlightInfoDTO
                      insuranceInfo:(InsuranceDTO *)selectInsurance
{
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
    
    //第一部分 用户信息
    [self saveUserInfoToPostDic:postDic  CustomerCount:customerCount];
    
    //第二部分 常用乘机人信息
    [self saveBoardingList:postDic BordingList:boardingList];
    
    //第三部分 预订人信息
    [postDic setObject:name?name:@"" forKey:@"contactName"];
    [postDic setObject:mobile?mobile:@"" forKey:@"contactMobile"];
    [postDic setObject:@"" forKey:@"contactEmail"];
    
    //第四部分 收获地址信息
    [self saveAddressInfo:postDic AddressInfo:addressInfoDTO AddressType:addressType];
    
    //第五部分 机票信息
    if (IsNilOrNull(backFlightInfoDTO)) {
        //如果是单程
        [postDic setObject:@"OW" forKey:@"oneOrRoundWay"];
        [self packToDictionary:postDic key:@"1" dto:goFlightInfoDTO];
    }else{
        //如果是往返程
        [postDic setObject:@"RT" forKey:@"oneOrRoundWay"];
        [self packToDictionary:postDic key:@"2" dto:goFlightInfoDTO];
        [self packToDictionary:postDic key:@"3" dto:backFlightInfoDTO];
    }
    
    //第六部分 保险
    if (selectInsurance && [PlanTicketSwitch canUserNewServer] && selectInsurance.copyCount > 0) {
        [self saveInsuranceInToDic:postDic
                         Insurance:selectInsurance
                      boardingList:boardingList
                          isOneWay:backFlightInfoDTO?NO:YES];
    }
    
    NSString *url = nil;
    
    if ([PlanTicketSwitch canUserNewServer]) {
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketOctForHttp,KPlaneTicketSubmitOrder];
    }else{
        url = [NSString stringWithFormat:@"%@/%@",kHostPlaneTicketForHttp,KPlaneTicketSubmitOrder];
    }
    
    DLog(@"post Dic is %@", postDic);
    HTTPMSG_RELEASE_SAFELY(flghtOrderSubmitMsg);
    
    if ([PlanTicketSwitch isEncodeParam]) {
        NSString *str = [url queryStringNoEncodeFromDictionary:postDic];
        NSString *encodeStr = [PasswdUtil encryptString:str
                                                 forKey:kPlaneTicketParamEncodeKey
                                                   salt:kPlaneTicketParamEncodeSalt];
        NSDictionary *dic = [NSDictionary dictionaryWithObject:encodeStr forKey:@"data"];
        
        flghtOrderSubmitMsg = [[HttpMessage alloc] initWithDelegate:self
                                                         requestUrl:url
                                                        postDataDic:dic
                                                            cmdCode:CC_FlightOrderSubmit];
    }else{
        flghtOrderSubmitMsg = [[HttpMessage alloc] initWithDelegate:self
                                                         requestUrl:url
                                                        postDataDic:postDic
                                                            cmdCode:CC_FlightOrderSubmit];
    }
    flghtOrderSubmitMsg.timeout = kPlaneTicketTimeOut;
    [self.httpMsgCtrl sendHttpMsg:flghtOrderSubmitMsg];
    
    TT_RELEASE_SAFELY(postDic);
    
}

- (void)didSendFlightOrderSubmitRequestFinished:(BOOL)isSuccess ErrorCode:(NSString *)errorCode
{
    
    if ([_delegate respondsToSelector:@selector(didSendFlightOrderSubmitComplete:Result:ErrorMsg:ErrorCode:)])
    {
        [self.delegate didSendFlightOrderSubmitComplete:self
                                                 Result:isSuccess
                                               ErrorMsg:self.errorMsg
                                              ErrorCode:errorCode];
    }
}

- (void)parseAddrsList:(NSDictionary*)items
{
    if (IsNilOrNull(items)) {
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self didSendFlightOrderSubmitRequestFinished:NO ErrorCode:nil];
        return;
    }
    
    if ([PlanTicketSwitch canUserNewServer]) {
        
        self.orderId = [items objectForKey:@"ordersId"]?[items objectForKey:@"ordersId"]:@"";
        NSString *returnKey = [items objectForKey:@"returnKey"]?[items objectForKey:@"returnKey"]:@"";
        NSString *insuranceFlag  = [items objectForKey:@"insuranceFlag"]? [items objectForKey:@"insuranceFlag"]:@"";
        
        NSString *coupomAmountStr = [items objectForKey:@"newCouponAmount"]?[items objectForKey:@"newCouponAmount"]:@"0";
        NSString *newCoupomAmount = [NSString stringWithFormat:@"¥ %.2f",[coupomAmountStr floatValue]];
        self.shouldPay = [items objectForKey:@"totalAmount"]?[items objectForKey:@"totalAmount"]:@"0";
        
        NSString *retMessage = [items objectForKey:@"returnMessage"];
        
        if ([returnKey isEqualToString:@"2"]) //chenggong
        {
            if ([insuranceFlag isEqualToString:@"0"]) {
                self.orderStatus = eOrderSucc_InsuranceSucc;
                [self didSendFlightOrderSubmitRequestFinished:YES ErrorCode:nil];
            }else{
                self.orderStatus = eOrderSucc_InsuranceFail;
                self.errorMsg = [NSString stringWithFormat:L(@"BTGetOrderFail")];
                [self didSendFlightOrderSubmitRequestFinished:NO ErrorCode:nil];
            }
        }else if ([returnKey isEqualToString:@"3"]) {
            if ([insuranceFlag isEqualToString:@"0"]) {
                self.orderStatus = eOrderSucc_PriceChange_InsuranceSucc;
                NSString *newAccount = [items objectForKey:@"newTotalAmount"];
                if (!IsStrEmpty(newAccount)) {
                    self.errorMsg = [NSString stringWithFormat:L(@"BTPriceHasChanged"),newAccount,newCoupomAmount];
                }else{
                    self.errorMsg = [NSString stringWithFormat:L(@"BTPriceHasChanged1")];
                }
                
                [self didSendFlightOrderSubmitRequestFinished:NO ErrorCode:nil];
            }else{
                self.orderStatus = eOrderSucc_PriceChange_InsuranceSucc;
                NSString *newAccount = [items objectForKey:@"newTotalAmount"];
                if (!IsStrEmpty(newAccount)) {
                    self.errorMsg = [NSString stringWithFormat:L(@"BTPriceHasChanged2"),[items objectForKey:@"newTotalAmount"],newCoupomAmount];
                }else{
                    self.errorMsg = [NSString stringWithFormat:L(@"BTPriceHasChanged3")];
                }
                [self didSendFlightOrderSubmitRequestFinished:NO ErrorCode:nil];
            }
            
        }else if ([returnKey isEqualToString:@"1"]) {
            self.orderStatus = eOrderFail_DataCheckFail;
            self.errorMsg = retMessage?retMessage:L(@"BTCommunicationError");
            [self didSendFlightOrderSubmitRequestFinished:NO ErrorCode:nil];
        }else if([returnKey isEqualToString:@"4"]){
            self.orderStatus = eOrderFail_SaleOut;
            self.errorMsg = retMessage?retMessage:L(@"BTAirTicketIsOver");
            [self didSendFlightOrderSubmitRequestFinished:NO ErrorCode:nil];
        } else if([returnKey isEqualToString:@"5"]){
            self.orderStatus = eOrderFail_CheckFail;
            self.errorMsg = retMessage?retMessage:L(@"BTOrderSubmitFail");
            [self didSendFlightOrderSubmitRequestFinished:NO ErrorCode:nil];
        } else if([returnKey isEqualToString:@"6"]){
            self.orderStatus = eOrderFail_ReSubmit;
            self.errorMsg = L(@"BTAskForYourChoice");
            [self didSendFlightOrderSubmitRequestFinished:NO ErrorCode:nil];
        }else {
            self.errorMsg = retMessage?retMessage:L(@"BTOrderSubmitFail");
            [self didSendFlightOrderSubmitRequestFinished:NO ErrorCode:nil];
        }
        
    }else{
        
        if ([[items objectForKey:@"returnKey"] isEqualToString:@"2"]) //chenggong
        {
            self.orderId = [items objectForKey:@"ordersId"]?[items objectForKey:@"ordersId"]:@"";
            [self didSendFlightOrderSubmitRequestFinished:YES ErrorCode:nil];
            
        }else {
            //"FlightOrderSubmit_Failed"="订单提交失败，航班未预订"
            self.errorMsg = [items objectForKey:@"returnMessage"]
            ?[items objectForKey:@"returnMessage"]
            :@"FlightOrderSubmit_Failed";
            [self didSendFlightOrderSubmitRequestFinished:NO ErrorCode:nil];
        }
        
    }
}

#pragma mark - OrderSubmitRequest postData Methods
#pragma mark   拼接接口数据

- (void)packToDictionary:(NSMutableDictionary *)postDataDic
                     key:(NSString *)key
                     dto:(FlightInfoDTO *)dto
{
    [postDataDic setObject:@"" forKey:[NSString stringWithFormat:@"airCompanyShortName%@",key]];
    [postDataDic setObject:@"" forKey:[NSString stringWithFormat:@"airCompanyName%@",key]];
    [postDataDic setObject:@""
                    forKey:[NSString stringWithFormat:@"picName%@",key]];
    
    [postDataDic setObject:dto.oa?dto.oa:@"" forKey:[NSString stringWithFormat:@"oa%@",key]];
    if (dto.ot == nil ||[dto.ot isEqualToString:@""]) {
        [postDataDic setObject:@"ot" forKey:[NSString stringWithFormat:@"ot%@",key]];
    }else {
        [postDataDic setObject:dto.ot forKey:[NSString stringWithFormat:@"ot%@",key]];
    }
    [postDataDic setObject:dto.aa?dto.aa:@"" forKey:[NSString stringWithFormat:@"aa%@",key]];
    if (dto.at == nil ||[dto.at isEqualToString:@""]) {
        [postDataDic setObject:@"at" forKey:[NSString stringWithFormat:@"at%@",key]];
    }else {
        [postDataDic setObject:dto.at forKey:[NSString stringWithFormat:@"at%@",key]];
    }
    [postDataDic setObject:dto.fDate?dto.fDate:@"" forKey:[NSString stringWithFormat:@"fDate%@",key]];
    [postDataDic setObject:dto.fTime?dto.fTime:@"" forKey:[NSString stringWithFormat:@"fTime%@",key]];
    [postDataDic setObject:dto.aDate?dto.aDate:@"" forKey:[NSString stringWithFormat:@"aDate%@",key]];
    [postDataDic setObject:dto.aTime?dto.aTime:@"" forKey:[NSString stringWithFormat:@"aTime%@",key]];
    
    [postDataDic setObject:dto.fNo?dto.fNo:@"" forKey:[NSString stringWithFormat:@"fNo%@",key]];
    [postDataDic setObject:dto.craft?dto.craft:@"" forKey:[NSString stringWithFormat:@"craft%@",key]];
    [postDataDic setObject:dto.company?dto.company:@"" forKey:[NSString stringWithFormat:@"company%@",key]];
    [postDataDic setObject:dto.aptA?dto.aptA:@""
                    forKey:[NSString stringWithFormat:@"aptA%@",key]];
    [postDataDic setObject:dto.aptC?dto.aptC:@""
                    forKey:[NSString stringWithFormat:@"aptC%@",key]];
    [postDataDic setObject:dto.aotA?dto.aotA:@""
                    forKey:[NSString stringWithFormat:@"aotA%@",key]];
    [postDataDic setObject:dto.aotC?dto.aotC:@""
                    forKey:[NSString stringWithFormat:@"aotC%@",key]];
    [postDataDic setObject:dto.stop?dto.stop:@"" forKey:[NSString stringWithFormat:@"stop%@",key]];
    
    [postDataDic setObject:@""
                    forKey:[NSString stringWithFormat:@"promOffParm%@",key]];
    [postDataDic setObject:@""
                    forKey:[NSString stringWithFormat:@"promRetParm%@",key]];
    [postDataDic setObject:@""
                    forKey:[NSString stringWithFormat:@"minPrice%@",key]];
    [postDataDic setObject:@""
                    forKey:[NSString stringWithFormat:@"minPriceC%@",key]];
    [postDataDic setObject:dto.oaName?dto.oaName:@""
                    forKey:[NSString stringWithFormat:@"oaName%@",key]];
    [postDataDic setObject:dto.aaName?dto.aaName:@""
                    forKey:[NSString stringWithFormat:@"aaName%@",key]];
    [postDataDic setObject:dto.oaFullName?dto.oaFullName:@""
                    forKey:[NSString stringWithFormat:@"oaFullName%@",key]];
    [postDataDic setObject:dto.aaFullName?dto.aaFullName:@""
                    forKey:[NSString stringWithFormat:@"aaFullName%@",key]];
    
    [postDataDic setObject:dto.companyName?dto.companyName:@""
                    forKey:[NSString stringWithFormat:@"companyName%@",key]];
    [postDataDic setObject:dto.comid?dto.comid:@""
                    forKey:[NSString stringWithFormat:@"comid%@",key]];
    [postDataDic setObject:dto.brandid?dto.brandid:@""
                    forKey:[NSString stringWithFormat:@"brandid%@",key]];
    [postDataDic setObject:dto.gdsgroupid?dto.gdsgroupid:@""
                    forKey:[NSString stringWithFormat:@"gdsgroupid%@",key]];
    [postDataDic setObject:@"" forKey:[NSString stringWithFormat:@"flightPosition%@",key]];
    [postDataDic setObject:dto.fareOffId?dto.fareOffId:@""
                    forKey:[NSString stringWithFormat:@"fareOffId%@",key]];
    [postDataDic setObject:dto.ticketRetId?dto.ticketRetId:@""
                    forKey:[NSString stringWithFormat:@"ticketRetId%@",key]];
    [postDataDic setObject:@"" forKey:[NSString stringWithFormat:@"indexf%@",key]];
    
    [postDataDic setObject:dto.guid?dto.guid:@""
                    forKey:[NSString stringWithFormat:@"guid%@",key]];
    [postDataDic setObject:dto.size?dto.size:@""
                    forKey:[NSString stringWithFormat:@"size%@",key]];
    [postDataDic setObject:@"" forKey:[NSString stringWithFormat:@"baseOffParm%@",key]];
    [postDataDic setObject:@"" forKey:[NSString stringWithFormat:@"baseRetParm%@",key]];
    
    //第六部分，添加roomDto里面的字段
    if (![dto.roomList count]==0) {
        
        FlightRoomInfoDTO *frDto = [dto.roomList objectAtIndex:0];
        
        [postDataDic setObject:frDto.room?frDto.room:@"" forKey:[NSString stringWithFormat:@"room%@",key]];
        [postDataDic setObject:frDto.sysPrice?frDto.sysPrice:@"" forKey:[NSString stringWithFormat:@"sysPrice%@",key]];
        [postDataDic setObject:frDto.sysPriceC?frDto.sysPriceC:@"" forKey:[NSString stringWithFormat:@"sysPriceC%@",key]];
        [postDataDic setObject:frDto.roomB?frDto.roomB:@"" forKey:[NSString stringWithFormat:@"roomB%@",key]];
        
        [postDataDic setObject:frDto.sysBPrice?frDto.sysBPrice:@"" forKey:[NSString stringWithFormat:@"sysBPrice%@",key]];
        [postDataDic setObject:frDto.sysBPriceC?frDto.sysBPriceC:@"" forKey:[NSString stringWithFormat:@"sysBPriceC%@",key]];
        [postDataDic setObject:frDto.cliPrice?frDto.cliPrice:@"" forKey:[NSString stringWithFormat:@"cliPrice%@",key]];
        [postDataDic setObject:frDto.cliPriceC?frDto.cliPriceC:@"" forKey:[NSString stringWithFormat:@"cliPriceC%@",key]];
        [postDataDic setObject:frDto.last?frDto.last:@"" forKey:[NSString stringWithFormat:@"last%@",key]];
        
        [postDataDic setObject:frDto.rule?frDto.rule:@"" forKey:[NSString stringWithFormat:@"rule%@",key]];
        [postDataDic setObject:frDto.offRate?frDto.offRate:@"" forKey:[NSString stringWithFormat:@"offRate%@",key]];
        [postDataDic setObject:frDto.offPrice?frDto.offPrice:@"" forKey:[NSString stringWithFormat:@"offPrice%@",key]];
        [postDataDic setObject:frDto.retPrice?frDto.retPrice:@"" forKey:[NSString stringWithFormat:@"retPrice%@",key]];
        [postDataDic setObject:frDto.price?frDto.price:@"" forKey:[NSString stringWithFormat:@"price%@",key]];
        [postDataDic setObject:frDto.offPriceC?frDto.offPriceC:@"" forKey:[NSString stringWithFormat:@"offPriceC%@",key]];
        [postDataDic setObject:frDto.retPriceC?frDto.retPriceC:@"" forKey:[NSString stringWithFormat:@"retPriceC%@",key]];
        [postDataDic setObject:frDto.priceC?frDto.priceC:@"" forKey:[NSString stringWithFormat:@"priceC%@",key]];
        [postDataDic setObject:frDto.index?frDto.index:@"" forKey:[NSString stringWithFormat:@"index%@",key]];
        
        //liukun add at 12-11-20
        
        if ([PlanTicketSwitch canUserNewServer]) {
            [postDataDic setObject:frDto.supplyId?frDto.supplyId:@""
                            forKey:[NSString stringWithFormat:@"supplyId%@",key]];
            [postDataDic setObject:frDto.supplyPolicyId?frDto.supplyPolicyId:@""
                            forKey:[NSString stringWithFormat:@"supplyPolicyId%@",key]];
            [postDataDic setObject:frDto.md5Str?frDto.md5Str:@""
                            forKey:[NSString stringWithFormat:@"md5Str%@",key]];
        }
        
    }
    
}

- (void)saveUserInfoToPostDic:(NSMutableDictionary *)dic CustomerCount:(int)customerCount{
    
    //第一部分 用户信息
    [dic setObject:[UserCenter defaultCenter].userInfoDTO.userId?[UserCenter defaultCenter].userInfoDTO.userId:@"" forKey:@"userId"];
    
    [dic setObject:[UserCenter defaultCenter].userInfoDTO.memberCardNo?[UserCenter defaultCenter].userInfoDTO.memberCardNo:@"" forKey:@"memberCardNum"];
    
    [dic setObject:[UserCenter defaultCenter].userInfoDTO.internalNum?[UserCenter defaultCenter].userInfoDTO.internalNum:@"" forKey:@"internalNum"];
    
    [dic setObject:[NSNumber numberWithInt:customerCount] forKey:@"customerCount"];
    
    //liukun add in 12-11-21
    //易付宝户头号
    if ([PlanTicketSwitch canUserNewServer]) {
        NSString *accountNo = [UserCenter defaultCenter].userInfoDTO.accountNo;
        [dic setObject:accountNo?accountNo:@"" forKey:@"accountNo"];
    }
    
}



- (void)saveBoardingList:(NSMutableDictionary *)dic  BordingList:(NSMutableArray *)bordingList{
    
    // travellerId0 = 564;
    
    //第二部分 常用乘机人信息
    for (int i=0; i<[bordingList count]; i++) {
        BoardingInfoDTO *dto = [bordingList objectAtIndex:i];
        //NSString *intd = [NSString stringWithFormat:@"%d",i];
        NSString *str = [NSString stringWithFormat:@"travellerId%d",i];
        DLog(@"str is %@",str);
        [dic setObject:dto.travellerId?dto.travellerId:@"" forKey:str];
    }
    // [dic setObject:@"564" forKey:@"travellerId0"];
}

- (void)saveAddressInfo:(NSMutableDictionary *)dic
            AddressInfo:(AddressInfoDTO*)addressInfoDTO
            AddressType:(NSString *)addressType{
    
    //第四部分 收获地址信息
    [dic setObject:addressType?addressType:@"" forKey:@"addressType"];
    
    if ([addressType isEqualToString:@"3"]) {
        
        [dic setObject:addressInfoDTO.recipient?addressInfoDTO.recipient:@"" forKey:@"addressName"];
        [dic setObject:addressInfoDTO.province?addressInfoDTO.province:@"" forKey:@"proCode"];
        [dic setObject:addressInfoDTO.city?addressInfoDTO.city:@"" forKey:@"cityId"];
        [dic setObject:addressInfoDTO.district?addressInfoDTO.district:@"" forKey:@"districtId"];
        if (![PlanTicketSwitch canUserNewServer]) {
            [dic setObject:addressInfoDTO.town?addressInfoDTO.town:@"" forKey:@"town"];
        }
        
        [dic setObject:addressInfoDTO.addressContent?addressInfoDTO.addressContent:@"" forKey:@"address"];
        [dic setObject:@"210000" forKey:@"zipCode"];//邮政编码
        [dic setObject:addressInfoDTO.tel?addressInfoDTO.tel:@"" forKey:@"addressMoblie"];
        [dic setObject:@"" forKey:@"addressPhone"];
    }
    
}

- (void)saveInsuranceInToDic:(NSMutableDictionary *)dic
                   Insurance:(InsuranceDTO *)insurance
                boardingList:(NSArray *)bordingList
                    isOneWay:(BOOL)isOneWay
{
    if (insurance == nil || bordingList == nil || isOneWay > 2) {
        return;
    }
    
    CopyCount copyCount = insurance.copyCount;
    NSString *insuranceCount = [NSString stringWithFormat:@"%d", copyCount];
    
    for (int i=0; i<[bordingList count]; i++) {
        
        [dic setObject:insurance.prdId?insurance.prdId:@""
                forKey:[NSString stringWithFormat:@"insuranceId%d_0", i]];
        [dic setObject:insuranceCount
                forKey:[NSString stringWithFormat:@"insuranceNum%d_0", i]];
        [dic setObject:@"1" forKey:[NSString stringWithFormat:@"insuranceTypeNum%d", i]];
        
    }
}

@end
