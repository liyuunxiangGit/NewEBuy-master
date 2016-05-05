//
//  EightBannerADService.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "EightBannerADService.h"
#import "HomeTopScrollAdDTO.h"

#import "EightBannerDataSource.h"

@implementation EightBannerADService

@synthesize delegate = _delegate;

@synthesize topBannerList = _topBannerList;
@synthesize searchTopAdList = _searchTopAdList;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_topBannerList);
    TT_RELEASE_SAFELY(_searchTopAdList);
}

- (id)init
{
    self = [super init];
    if (self) {
        _appType = BannerAppTypeSuningEBuy;
    }
    return self;
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(topBannerASIHTTPRequest);
//    HTTPMSG_RELEASE_SAFELY(topBannerAdInnerRequest);
}

#pragma mark -
#pragma mark http request

- (void)requestBannerListWithAdType:(EightBannerAdType)type
{
    self.isRequestFinished = NO;
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                        kHttpRequestHomeStoreValue,kHttpRequestHomeStoreKey,
                                        @"2",@"terminal",
                                        nil];
    [postDataDic setValue:__INT(type) forKey:@"type"];
    
    [postDataDic setValue:__INT(self.appType) forKey:@"appType"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,kHttpRequestAdvertiseEightView];
    
    HTTPMSG_RELEASE_SAFELY(topBannerASIHTTPRequest);
    topBannerASIHTTPRequest = [[HttpMessage alloc] initWithDelegate:self
                                                         requestUrl:url
                                                        postDataDic:postDataDic
                                                            cmdCode:CC_RequestEightBannerImages];
    if (eHomeEightBannerType == type)
    {
        topBannerASIHTTPRequest.timeout = 20;
    }
    topBannerASIHTTPRequest.requestMethod =RequestMethodGet;
    //topBannerASIHTTPRequest.canMultipleConcurrent = YES;
    [self.httpMsgCtrl sendHttpMsg:topBannerASIHTTPRequest];
 
    TT_RELEASE_SAFELY(postDataDic);
}

//- (void)requestBannerListWithAdId:(NSString *)adId
//{
//    self.isRequestFinished = NO;
//    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                        kHttpRequestHomeStoreValue,kHttpRequestHomeStoreKey,
//                                        nil];
//    
//    [postDataDic setValue:adId forKey:@"adId"];
//    
//    [postDataDic setValue:[[Config currentConfig] defaultCity] forKey:@"cityId"];
//    
//    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,kHttpRequestAdInnerContentView];
//    
//    HTTPMSG_RELEASE_SAFELY(topBannerAdInnerRequest);
//    topBannerAdInnerRequest = [[HttpMessage alloc] initWithDelegate:self
//                                                         requestUrl:url
//                                                        postDataDic:postDataDic
//                                                            cmdCode:CC_RequestEightBannerInner];
//    [self.httpMsgCtrl sendHttpMsg:topBannerAdInnerRequest];
//    
//    TT_RELEASE_SAFELY(postDataDic);
//}

#pragma mark -
#pragma mark final

- (void)getBannerOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(service:requestEightBannerComplete:)])
    {
        [_delegate service:self requestEightBannerComplete:isSuccess];
    }
}

//- (void)getBannerInnerOk:(BOOL)isSuccess
//{
//    if ([_delegate respondsToSelector:@selector(service:requestEightBannerInnerComplete:)])
//    {
//        [_delegate service:self requestEightBannerInnerComplete:isSuccess];
//    }
//}

#pragma mark -
#pragma mark http message response

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{    
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_RequestEightBannerImages) {
        [self getBannerOk:NO];
    }
    
//    if (receiveMsg.cmdCode == CC_RequestEightBannerInner) {
//        [self getBannerInnerOk:NO];
//    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    self.isRequestFinished = YES;
    
    NSDictionary *items = receiveMsg.jasonItems;
        
    NSString *isSuccess = [items objectForKey:@"isSuccess"];
    
    if (isSuccess && [isSuccess isEqualToString:@"1"])
    {
        if (receiveMsg.cmdCode == CC_RequestEightBannerImages) {
            self.topBannerList = [EightBannerDataSource parseHomeTopScrollList:items];
            [Config currentConfig].topAdList = self.topBannerList;
            
            //add by wangjiaxing 搜索页广告页
            self.searchTopAdList = [EightBannerDataSource parseSearchTopAd:items];
            [Config currentConfig].topSearchAdList = self.searchTopAdList;
            
            self.m2DaJuHuiList = [EightBannerDataSource parseM2TuangouQiangGouAd:items];
            [Config currentConfig].m2DaJuHuiList = self.m2DaJuHuiList;
            
            self.allAdList = [EightBannerDataSource parseAllAdList:items];
            [self getBannerOk:YES];
        }
        
//        if (receiveMsg.cmdCode == CC_RequestEightBannerInner) {
//            [self getBannerInnerOk:YES];
//        }
    
    }
    else
    {
        if (receiveMsg.cmdCode == CC_RequestEightBannerImages) {
            self.errorMsg = L(@"PVGetAdFail");
            [self getBannerOk:NO];
        }
        
//        if (receiveMsg.cmdCode == CC_RequestEightBannerInner) {
//            [self getBannerInnerOk:YES];
//        }
    }
}

@end
