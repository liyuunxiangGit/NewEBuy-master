//
//  MobilePayOrderListService.m
//  SuningEBuy
//
//  Created by shasha on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MobilePayOrderListService.h"
@interface MobilePayOrderListService ()
- (void)didGetMobilePayOrderListHttpRequestFinished:(BOOL)isSuccess;
@end

@implementation MobilePayOrderListService
@synthesize delegate = _delegate;
@synthesize orderList = _orderList;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_orderList)
    _delegate = nil;
}

-(void)httpMsgRelease{
    
    HTTPMSG_RELEASE_SAFELY(mobilePayOrderListHttpMsg);
}

- (void)didGetMobilePayOrderListHttpRequestFinished:(BOOL)isSuccess{
    
    if ([self.delegate respondsToSelector:@selector(didGetMobilePayOrderListCompleted:errorMsg:)])
    {
        [self.delegate didGetMobilePayOrderListCompleted:isSuccess errorMsg:self.errorMsg];
    }
}

- (void)beginGetMobilePayOrderListHttpRequest{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:@"" forKey:@"startDate"];
    [postDataDic setObject:@"" forKey:@"endDate"];
    NSString *accountNo = [UserCenter defaultCenter].userInfoDTO.accountNo;
    [postDataDic setObject:accountNo?accountNo:@"" forKey:@"accountNO"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNiPhoneFillQueryAllOrderView"];
    
    HTTPMSG_RELEASE_SAFELY(mobilePayOrderListHttpMsg);
    
    mobilePayOrderListHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_MobilepayOrderList];
    mobilePayOrderListHttpMsg.requestMethod=RequestMethodGet;
    TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:mobilePayOrderListHttpMsg];
    
}

- (void)parseOrderList:(NSDictionary *)items
{
    Background_Begin
    NSMutableArray *array = [items objectForKey:@"accountInfo"];
    
    DLog(@"accountInfo is : %@", array);
    
    if (array == nil || [array count] == 0)
    {
        self.errorMsg = @"History is empty";
    }
    
    if (_orderList == nil)
    {
        _orderList = [[NSMutableArray alloc] init];
        
    }else{
        
        [self.orderList removeAllObjects];
    }
    
    for (NSDictionary *listInfo in array)
    {
        MobileQueryDTO *_mobileQueryDto = [[MobileQueryDTO alloc] init];
        
        [_mobileQueryDto encodeFromDictionary:listInfo];
        
        [self.orderList addObject:_mobileQueryDto];
        
        TT_RELEASE_SAFELY(_mobileQueryDto);
    }
    
    Foreground_Begin
    [self didGetMobilePayOrderListHttpRequestFinished:YES];
    Foreground_End
    
    Background_End
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    [self didGetMobilePayOrderListHttpRequestFinished:NO];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    NSDictionary *items = receiveMsg.jasonItems;
    
    if ([[items objectForKey:@"errorCode"] isEqualToString:@""])
    {
        [self parseOrderList:items];
        
    }else{
        self.errorMsg = @"mobilePayOrderListFaild";
        
        [self didGetMobilePayOrderListHttpRequestFinished:NO];
        
    }
    
    
}

@end
