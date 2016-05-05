//
//  NOrderListService.m
//  SuningEBuy
//
//  Created by david on 13-11-7.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NOrderListService.h"
#import "NewOrderListDTO.h"

@implementation NOrderListService

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(_orderListMsg);
    [super httpMsgRelease];
}

-(void)beginGetOrderListHttpRequest:(NSString*)userId
                        currentPage:(NSString*)currentPage
                        orderStatus:(NSString*)orderStatus
                         selectTime:(NSString*)time{
    self.orderList = nil;
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNMTNewGetSortOrderListView"];
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
	[postDataDic setObject:kHttpRequestHomeStoreValue
                    forKey:kHttpRequestHomeStoreKey];
	[postDataDic setObject:kHttpRequestHomeCatalogIdValue
                    forKey:kHttpRequestHomeCatalogIdKey];
	[postDataDic setObject:(userId == nil ? @"" : userId)
                    forKey:kHttpResponseUserId];
    [postDataDic setObject:time?time:@"all"
                    forKey:kHttpRequestMemberSelectTime];
	[postDataDic setObject:(orderStatus == nil ? @"" : orderStatus)
                    forKey:kHttpRequestMemberStatus];
	[postDataDic setObject:currentPage
                    forKey:kHttpRequestMemberPage];
    
    HTTPMSG_RELEASE_SAFELY(_orderListMsg);
    
    _orderListMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_OrderList];
    
    _orderListMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:_orderListMsg];
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    if (receiveMsg.isShouXian)
        return;
    [super receiveDidFailed:receiveMsg];
    [self parseFinished:NO];
    
}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    NSDictionary *items = [receiveMsg jasonItems];
    
    if (IsNilOrNull(items)) {
        //json解析失败
        
        if (receiveMsg.isShouXian)
            return;
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self parseFinished:NO];
        return;
    }
    //分页信息
    NSInteger totalPage = [[items objectForKey:@"numberOfPages"]integerValue];
    NSInteger currentPage = [[items objectForKey:@"pageNumber"]integerValue];
    
    
//    if (totalPage == currentPage) {
//        self.isLastPage = YES;
//    }else{
//        self.isLastPage = NO;
//    }
    if (totalPage > currentPage) {
        self.isLastPage = NO;
    }else{
        self.isLastPage = YES;
    }
    
//    self.currentPage = currentPage;
//    self.totalPage = totalPage;
    
    NSArray *orderList__ = [items objectForKey:@"orderList"];
    if (IsArrEmpty(orderList__)) {
        self.errorMsg = L(@"NoOrderYouHave");
        [self parseFinished:YES];
        return;
    }
    //解析订单列表
    [self parseOrderList:orderList__];
}

-(void)parseOrderList:(NSArray *)list{
        
    [self.orderList removeAllObjects];
    
    for (NSDictionary *dic in list) {
        
        NewOrderListDTO *dto = [[NewOrderListDTO alloc]init];
        [dto encodeFromDictionary:dic];
        [self.orderList addObject:dto];
    }
    
    [self parseFinished:YES];
  
}

-(void)parseFinished:(BOOL)isOk
{
    
    if ([self.delegate respondsToSelector:@selector(orderListService:isSuccess:)]) {
        
        [self.delegate orderListService:self isSuccess:isOk];
    }
}

-(NSMutableArray *)orderList{
    
    if (!_orderList) {
        _orderList = [[NSMutableArray alloc]init];
    }
    return _orderList;
}
@end
