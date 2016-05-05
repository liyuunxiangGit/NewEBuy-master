//
//  PayServiceQueryService.m
//  SuningEBuy
//
//  Created by 谢 伟 on 12-10-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PayServiceQueryService.h"
#import "PayServiceQueryDTO.h"

@interface PayServiceQueryService ()

- (void)sendFeeListHttpRequest:(NSString *)typeCode;
- (void)getFeeListDidFinish:(BOOL)isSuccess;

@end


@implementation PayServiceQueryService

@synthesize isEmptyHistory = _isEmptyHistory;
@synthesize itemLists = _itemLists;
@synthesize delegate = _delegate;

- (void)dealloc
{
    HTTPMSG_RELEASE_SAFELY(paymentQueryHttpMsg);
    
    TT_RELEASE_SAFELY(_itemLists);
    
}

- (void)beginGetFeeListWithTypeCode:(NSString *)typeCode
{
    [self sendFeeListHttpRequest:typeCode];
}

- (void)sendFeeListHttpRequest:(NSString *)typeCode
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
	[postDataDic setObject:typeCode forKey:KHttpRequestTypeCode];
    [postDataDic setObject:@"3" forKey:@"timeRange"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, kHttpRequestFeePaymentQueryViewKey];
    
    HTTPMSG_RELEASE_SAFELY(paymentQueryHttpMsg);
    
    paymentQueryHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_PaymentQuery];
    
    [self.httpMsgCtrl sendHttpMsg:paymentQueryHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

#pragma mark -
#pragma mark 网络请求回调
- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
        case CC_PaymentQuery:
        {
            [self getFeeListDidFinish:NO];
        }
            break;
            
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    switch (receiveMsg.cmdCode) {
        case CC_PaymentQuery:
        {
            NSDictionary *items = receiveMsg.jasonItems;
            [self parseFeeListInfo:items];
        }
            break;
            
        default:
            break;
    }
}

- (void)parseFeeListInfo:(NSDictionary *)dic
{
    Background_Begin
    if ([[dic objectForKey:@"errorCode"] isEqualToString:@""])
    {
        NSArray *accountInfoArray = [dic objectForKey:@"accountInfo"];
        
        if (accountInfoArray == nil || [accountInfoArray count] == 0)
        {
            self.isEmptyHistory = YES;
            [self getFeeListDidFinish:NO];
            return;
        }
        
        NSMutableArray *feeList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *account in accountInfoArray)
        {
            PayServiceQueryDTO *_accountTemp = [[PayServiceQueryDTO alloc] init];
            [_accountTemp encodeFromDictionary:account];
            [feeList addObject:_accountTemp];
            TT_RELEASE_SAFELY(_accountTemp);
        }
        
        self.itemLists = feeList;
        TT_RELEASE_SAFELY(feeList);
        [self getFeeListDidFinish:YES];
    }
    else
    {
        [self getFeeListDidFinish:NO];
    }
    Background_End
}

#pragma mark -
#pragma mark 回调代理方法
- (void)getFeeListDidFinish:(BOOL)isSuccess
{
    Foreground_Begin
    if ([_delegate respondsToSelector:@selector(getFeeListCompleteWithService:Result:errorMsg:)])
    {
        [_delegate getFeeListCompleteWithService:self Result:isSuccess errorMsg:self.errorMsg];
    }
    Foreground_End
}


@end
