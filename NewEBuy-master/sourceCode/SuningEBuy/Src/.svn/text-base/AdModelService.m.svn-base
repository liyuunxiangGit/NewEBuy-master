//
//  AdModelService.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AdModelService.h"

#import "InnerAdHTTPDataSource.h"

@interface AdModelService()

- (void)getAdModelOk:(BOOL)isSuccess;

@end


@implementation AdModelService


@synthesize delegate = _delegate;
@synthesize dto = _dto;


- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(adModelASIHttpRequest);
}

- (HomeTopScrollAdDTO *)dto{
    if (!_dto) {
        _dto = [[HomeTopScrollAdDTO alloc] init];
    }
    return _dto;
}

#pragma mark -
#pragma mark http request

- (void)requestModelListWithAdId:(NSString *)adID
{
    NSString *currentCity = [[Config currentConfig] defaultCity];
    
//    NSDictionary *postDic = [[NSDictionary alloc] initWithObjectsAndKeys:kHttpRequestHomeStoreValue,kHttpRequestHomeStoreKey,currentCity,kHttpRequestInnerCityIdkey,adID,kHttpRequestInnerAdIdkey, nil];
//    
//    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,kHttpRequestInnerAdView];
    
//    伪静态请求样例：
//http://b2cpre.cnsuning.com/emall/snmtAdInn_{storeId}_{adId}_{cityId}_.html
//http://b2cpre.cnsuning.com/emall/snmtAdInn_10052_124_9173_.html
//http://b2cpre.cnsuning.com/emall/snmtAdInn_{storeId}_{adId}_{cityId}_{supportCShop}_.html
    NSDictionary *postDic = [[NSDictionary alloc] init];
    
    NSString *url = nil;

    url = [NSString stringWithFormat:
           @"%@/snmtAdInn_%@_%@_%@_%@_.html",kHostAddressForHtml,
           @"10052",
           adID?adID:@"",
           currentCity?currentCity:@"",
           @"1"];

    
    HTTPMSG_RELEASE_SAFELY(adModelASIHttpRequest);
    adModelASIHttpRequest = [[HttpMessage alloc] initWithDelegate:self
                                                       requestUrl:url
                                                      postDataDic:postDic
                                                          cmdCode:CC_Model1];
    adModelASIHttpRequest.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:adModelASIHttpRequest];
    
    TT_RELEASE_SAFELY(postDic);
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self getAdModelOk:NO];
}


- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{  
    NSDictionary *items = receiveMsg.jasonItems;
    
    if (!items)
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self getAdModelOk:NO];
    }
    else
    {
        [self parseAdList:items];
        
    }
}

- (void)parseAdList:(NSDictionary*)items
{
    Background_Begin
    
    self.innerProductList = [InnerAdHTTPDataSource parseInnerProductList:items];
    
    self.innerAdvertiseList = [InnerAdHTTPDataSource parseInnerAdList:items];
    
    self.innerProductBaseList = [InnerAdHTTPDataSource parseInnerProductBaseList:items];
    
//    self.innerFloorList = [InnerAdHTTPDataSource parseInnerFloorList:items];

    NSDictionary *dic = [items objectForKey:@"advInfo"];
    [self.dto encodeFromDictionary:dic];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:self.dto];
    [Config currentConfig].advInfoList = array;
    
    Foreground_Begin
    [self getAdModelOk:YES];
    Foreground_End
    
    Background_End
}

- (void)getAdModelOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(service:getAdModelListComplete:)])
    {
        [_delegate service:self getAdModelListComplete:isSuccess];
    }
}

@end
