//
//  SecondPayService.m
//  SuningEBuy
//
//  Created by  liukun on 12-11-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SecondPayService.h"

@interface SecondPayService()



@end

/*********************************************************************/

@implementation SecondPayService

@synthesize delegate = _delegate;

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(secondPayHttpMsg);
}

#pragma mark -
#pragma mark service life

- (void)beginSecondPayOrderCheckWithOrderId:(NSString *)orderId
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    [postDataDic setObject:@"-7" forKey:@"langId"];
    [postDataDic setObject:orderId?orderId:@"" forKey:@"orderId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, [@"SNMobilePaymentCheck" passport]];

    HTTPMSG_RELEASE_SAFELY(secondPayHttpMsg);
    secondPayHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                  requestUrl:url
                                                 postDataDic:postDataDic
                                                     cmdCode:CC_SecondPayment];
    [self.httpMsgCtrl sendHttpMsg:secondPayHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

#pragma mark -
#pragma mark final

- (void)paymentCheckOk:(BOOL)isSuccess payDTO:(payFlowDTO *)payDTO
{
    if (_delegate && [_delegate respondsToSelector:
                      @selector(secondPayCheckCompletionWithResult:errorMsg:payDto:)]) {
        [_delegate secondPayCheckCompletionWithResult:isSuccess
                                             errorMsg:self.errorMsg
                                               payDto:payDTO];
    }
}

#pragma mark -
#pragma mark http message delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self paymentCheckOk:NO payDTO:nil];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    NSString *errorCode = receiveMsg.errorCode;
    
    if ([errorCode isEqualToString:@""])
    {
        NSString *orderId = [items objectForKey:@"orderId"];
        
        //收集订单数据
        if (NotNilAndNull(orderId) && ![orderId isEqualToString:@""]) {
            [[SuningMainClick sharedInstance] getOrderAndSave:orderId];
        }
        
        NSString *shouldPay = [items objectForKey:@"shouldPay"];
        
          float portage = [[items objectForKey:@"portage"] floatValue];//B2C 回过来的运费
        
        NSString *portageStr = nil;
        
        if (portage == 0) {
            portageStr = L(@"NoFreight");
        }else{
            portageStr = [NSString stringWithFormat:L(@"FreightIs"),portage];
        }
        
        payFlowDTO *orderDTO = [[payFlowDTO alloc]  init];
        
        [orderDTO encodeFromDictionary:items];
        
        orderDTO.orderId = [items objectForKey:@"orderId"];
        orderDTO.prepay = NotNilAndNull(shouldPay)?shouldPay:@"";
        orderDTO.eppPayPwd = @"";
        orderDTO.isPrepay = @"true"; // default yifuabo, other false
        orderDTO.langId = @"-7";
        orderDTO.policyId = @"";
        orderDTO.catalogId = @"10051";
        orderDTO.storeId = @"10052";
        orderDTO.subpolicyid = @"";
        orderDTO.subCodpolicyId = @"";
        orderDTO.portage = portageStr;
        
        [self paymentCheckOk:YES payDTO:orderDTO];
    }
    else if (!items)
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self paymentCheckOk:NO payDTO:nil];
    }
    else if ([errorCode isEqualToString:@"OrderError"])
    {
        self.errorMsg = L(@"OrderInfoExceptionRebuy");
        [self paymentCheckOk:NO payDTO:nil];
    }
    else if ([errorCode isEqualToString:@"LogonError"])
    {
        self.errorMsg = L(@"NeedLogin");
        [self paymentCheckOk:NO payDTO:nil];
    }
    else if ([errorCode isEqualToString:@"OrderStateSucess"])
    {
        self.errorMsg = L(@"OrderHavePayedNoNeedAgain");
        [self paymentCheckOk:NO payDTO:nil];
    }
    else if ([errorCode isEqualToString:@"OrderStateError"])
    {
        self.errorMsg = L(@"OrderInfoExceptionCantPay");
        [self paymentCheckOk:NO payDTO:nil];
    }
    else if ([errorCode isEqualToString:@"canNotSaled"])
    {
        self.errorMsg = L(@"OrderHaveCantSaleRebuy");
        [self paymentCheckOk:NO payDTO:nil];
    }
    else if ([errorCode isEqualToString:@"ERROR_CODE_ACT_STATUS"])
    {
        self.errorMsg = L(@"OrderRebuy_GroupBuyEnded");
        [self paymentCheckOk:NO payDTO:nil];
    }
    else if ([errorCode isEqualToString:@"ERROR_CODE_TOTAL_AMT"])
    {
        self.errorMsg = L(@"OrderRebuy_GroupBuyNumberLack");
        [self paymentCheckOk:NO payDTO:nil];
    }
    else if ([errorCode isEqualToString:@"ERROR_CODE_USER_AMT"])
    {
        self.errorMsg = L(@"OrderRebuy_BeyondLimitNumber");
        [self paymentCheckOk:NO payDTO:nil];
    }
    else if ([errorCode isEqualToString:@"checkgrpException"])
    {
        self.errorMsg = L(@"CannotPay_GroupBuyException");
        [self paymentCheckOk:NO payDTO:nil];
    }
    else if ([errorCode isEqualToString:@"orderItemNull"])
    {
        self.errorMsg = L(@"CannotPay_NoCanPayGood");
        [self paymentCheckOk:NO payDTO:nil];
    }
    else
    {
        self.errorMsg = L(@"OrderInfoExceptionCantPay");
        [self paymentCheckOk:NO payDTO:nil];
    }
}

#pragma mark -
#pragma mark parse data

@end
