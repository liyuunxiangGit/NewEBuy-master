//
//  OrderDetailService.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "OrderDetailService.h"

#import "orderHttpDataSource.h"

@implementation OrderDetailService

@synthesize orderNamesDto = _orderNamesDto;

@synthesize orderDetailList = _orderDetailList;

@synthesize delegate = _delegate;

@synthesize isSucess = _isSucess;

@synthesize orderDetailCSList = _orderDetailCSList;


- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    
    
    TT_RELEASE_SAFELY(_orderNamesDto);
    
    TT_RELEASE_SAFELY(_orderDetailList);
    
    TT_RELEASE_SAFELY(_isSucess);
    
    TT_RELEASE_SAFELY(_orderDetailCSList);
    
    
    HTTPMSG_RELEASE_SAFELY(_orderDetailHttpMsg);
    
    HTTPMSG_RELEASE_SAFELY(_cancelOrderHttpMsg);
}


- (void)httpMsgRelease{
    
    HTTPMSG_RELEASE_SAFELY(_orderDetailHttpMsg);
    
    HTTPMSG_RELEASE_SAFELY(_cancelOrderHttpMsg);
    
    [super httpMsgRelease];
    
}

-(void)beginSendOrderDetailDTOHttpRequest:(NSString *)orderId WithCode:(NSString*)supplierCode
{
    
    //    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,kHttpRequestMemberOrderSpecific];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,kHttpRequestMemberOrderSpecific];
    
    NSMutableDictionary  *postDataDic = [[NSMutableDictionary alloc]init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
    [postDataDic setObject:(orderId == nil ? @"" : orderId) forKey:kResponseMemberOrderId];
    
    //传非空
    [postDataDic setObject:@"1" forKey:@"packageFlag"];

    //供应商编码,自营商品传空
    [postDataDic setObject:supplierCode?supplierCode:@"" forKey:@"supplierCode"];
    
    HTTPMSG_RELEASE_SAFELY(_orderDetailHttpMsg);
    
    _orderDetailHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_OrderDetail];
    
    _orderDetailHttpMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:_orderDetailHttpMsg];
}

-(void)beginSendOldOrderDetailDTOHttpRequest:(NSString *)orderId WithCode:(NSString*)supplierCode
{
    
    //    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,kHttpRequestMemberOrderSpecific];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,kHttpRequestMemberOrderSpecific];
    
    NSMutableDictionary  *postDataDic = [[NSMutableDictionary alloc]init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
    [postDataDic setObject:(orderId == nil ? @"" : orderId) forKey:kResponseMemberOrderId];
    
    //传非空
    [postDataDic setObject:@"" forKey:@"packageFlag"];
    
    //供应商编码,自营商品传空
    [postDataDic setObject:supplierCode?supplierCode:@"" forKey:@"supplierCode"];
    
    HTTPMSG_RELEASE_SAFELY(_orderDetailHttpMsg);
    
    _orderDetailHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_OrderDetail];
    
    _orderDetailHttpMsg.requestMethod =RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:_orderDetailHttpMsg];
}



- (void)orderDetailDTOHttpRequestOK:(HttpMessage *)receiveMsg{
    
    NSDictionary *items = receiveMsg.jasonItems;
    
    if ([[items objectForKey:@"errorCode"] isEqualToString:@"1"]) {
        Background_Begin
        NSArray *tempOrderDetailArray = [[NSArray alloc]initWithArray:[orderHttpDataSource parseDetailOrderDTO:items]];
        
        self.orderDetailList = tempOrderDetailArray;
        
        NSArray *tempOrderDetailCSArray = [[NSArray alloc]initWithArray:[orderHttpDataSource parseDetailOrderCSDTO:items]];
        
        self.orderDetailCSList = tempOrderDetailCSArray;
        
        NSArray *displayArr = [[NSArray alloc] initWithArray:[orderHttpDataSource parseDetailHeadDTO:items]];
        
        self.detailHeadList = displayArr;
        
        MemberOrderNamesDTO *tempOrderNameDto =  [orderHttpDataSource parseOrderNameDTO:items];
        
        self.orderNamesDto = tempOrderNameDto;
        
        Foreground_Begin
        if (self.delegate && [_delegate respondsToSelector:@selector(orderDetailDTOHttpRequestCompletedWith:ordeNamesDto:isSucess:errorCode:WithCSList:WithHeadList:)]) {
            
            [_delegate orderDetailDTOHttpRequestCompletedWith:_orderDetailList
                                                 ordeNamesDto:_orderNamesDto
                                                     isSucess:YES
                                                    errorCode:receiveMsg.errorCode
                                                   WithCSList:_orderDetailCSList
                                                 WithHeadList:_detailHeadList];
        }
        
        Foreground_End
        Background_End
    }else{
        [_delegate orderDetailDTOHttpRequestCompletedWith:nil ordeNamesDto:nil isSucess:NO errorCode:L(@"Sorry loading failed") WithCSList:nil WithHeadList:nil];
    }
}

- (void)orderDetailHttpRequestFail:(HttpMessage *)receiveMsg{
    
    
    if (self.delegate && [_delegate respondsToSelector:@selector(orderDetailDTOHttpRequestCompletedWith:ordeNamesDto:isSucess:errorCode:WithCSList:WithHeadList:)]) {
        
        [_delegate orderDetailDTOHttpRequestCompletedWith:nil ordeNamesDto:nil isSucess:NO errorCode:self.errorMsg WithCSList:nil WithHeadList:nil];
    }
    
}

- (void)cancelOrderHttpRequestFail:(HttpMessage *)receiveMsg{
    
    if (self.delegate && [_delegate respondsToSelector:@selector(orderCancelHttpRequestCompletedWith:errorMsg:)]) {
        
        [_delegate orderCancelHttpRequestCompletedWith:NO errorMsg:self.errorMsg];
        
    }
    
}

- (void)cancelOrderHttpRequestOK:(HttpMessage *)receiveMsg{
    NSDictionary *items = receiveMsg.jasonItems;
    if (!items) {
        self.errorMsg = kSERVERBUSY_ERRORDESC;
        if (self.delegate && [_delegate respondsToSelector:@selector(orderCancelHttpRequestCompletedWith:errorMsg:)]) {
            [_delegate orderCancelHttpRequestCompletedWith:NO errorMsg:self.errorMsg];
        }
        return;
    }
    NSString *isSuccess = [items objectForKey:@"isSuccess"];
    if (isSuccess && [isSuccess isEqualToString:@"1"]) {
        self.errorMsg = L(@"Cancel Order Success!");
        if (self.delegate && [_delegate respondsToSelector:@selector(orderCancelHttpRequestCompletedWith:errorMsg:)]) {
            [_delegate orderCancelHttpRequestCompletedWith:YES errorMsg:self.errorMsg];
        }
    }else{
        self.errorMsg = L(@"Cancel Order Failed!");
        if (self.delegate && [_delegate respondsToSelector:@selector(orderCancelHttpRequestCompletedWith:errorMsg:)]) {
            [_delegate orderCancelHttpRequestCompletedWith:NO errorMsg:self.errorMsg];
        }
    }
}



- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_OrderDetail) {
        
        [self orderDetailHttpRequestFail:receiveMsg];
    }
    else if(receiveMsg.cmdCode == CC_CancelOrder)
    {
        [self cancelOrderHttpRequestFail:receiveMsg];
    }else if (receiveMsg.cmdCode == CC_OrderRemove) {
        
        // 删除订单
        if (nil != _delegate
            && [_delegate respondsToSelector:@selector(orderDeleteOperationCommplete:)]) {
            
            [_delegate orderDeleteOperationCommplete:[NSError errorWithDomain:@""
                                                                         code:-1
                                                                     userInfo:@{NSLocalizedDescriptionKey:self.errorMsg}]];
        }
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    if (receiveMsg.cmdCode ==  CC_OrderDetail) {
        
        [self orderDetailDTOHttpRequestOK:receiveMsg];
    }
    else if(receiveMsg.cmdCode == CC_CancelOrder){
        
        [self cancelOrderHttpRequestOK:receiveMsg];
        
    }else if (receiveMsg.cmdCode == CC_OrderRemove) {
        // 删除订单
        
        if (nil != _delegate
            && [_delegate respondsToSelector:@selector(orderDeleteOperationCommplete:)]
            && nil != receiveMsg.jasonItems) {
            
            NSError *err = nil;
            NSString *success = EncodeStringFromDic(receiveMsg.jasonItems,@"isSuccess");
            if (nil == success
                || ![success isEqualToString:@"1"]) {
                NSString *errDesc = receiveMsg.jasonItems[@"errorMessage"];
                err = [NSError errorWithDomain:@""
                                          code:-1
                                      userInfo:@{NSLocalizedDescriptionKey:errDesc}];
            }
            [_delegate orderDeleteOperationCommplete:err];
        }
    }
}

-(void)beginSendCancelOrderHttpRequest:(NSString *)userId orderId:(NSString *)orderId
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, [kHttpRequestMemberOrderCancel passport]];
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
    
    
    [postDataDic setObject:(userId == nil ? @"" : userId) forKey:kHttpResponseUserId];
    
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
    [postDataDic setObject:(orderId == nil ? @"" : orderId) forKey:kResponseMemberOrderId];
    
    [postDataDic setObject:@"orderList" forKey:@"fromFlag"];
    [postDataDic setObject:@"" forKey:@"URL"];

    
    HTTPMSG_RELEASE_SAFELY(_cancelOrderHttpMsg);
    
    _cancelOrderHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_CancelOrder];
    
    
    [self.httpMsgCtrl sendHttpMsg:_cancelOrderHttpMsg];
    
}

- (void)beginRequestDeleteTheOrderWithOrderId:(NSString *)orderId {
    if (nil != orderId) {
        
        NSDictionary *paras = [NSDictionary dictionaryWithObjects:@[@"10052",@"1",orderId]
                                                          forKeys:@[@"storeId",@"status",@"orderId"]];
        
        HttpMessage *httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                          requestUrl:[NSString stringWithFormat:@"%@/SNMobileDeleteOrder",kHostAddressForHttps]
                                                         postDataDic:paras
                                                             cmdCode:CC_OrderRemove];
        httpMsg.delegate = self;
        
        [self.httpMsgCtrl sendHttpMsg:httpMsg];
    }
}

@end
