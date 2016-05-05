//
//  ServiceTrackListService.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ServiceTrackListService.h"


@interface ServiceTrackListService ()

- (void)sendServiceTrackListHttpRequest:(NSDictionary *)parametersDic;

- (void)getServiceTrackListDidFinish:(BOOL)isSuccess;

@end


@implementation ServiceTrackListService

@synthesize isLastPage = _isLastPage;

@synthesize totalPage = _totalPage;

@synthesize currentPage = _currentPage;

@synthesize queryResultArray = _queryResultArray;

@synthesize delegate = _delegate;


- (void)dealloc
{
    TT_RELEASE_SAFELY(_queryResultArray);
    
    HTTPMSG_RELEASE_SAFELY(serviceTrackListHttpMsg);
    
}

- (void)beginGetServiceTrackList:(NSDictionary *)parametersArray
{
    [self sendServiceTrackListHttpRequest:parametersArray];
}

#pragma mark - 
#pragma mark LibraryAdModel3 HTTPRequest

- (void)sendServiceTrackListHttpRequest:(NSDictionary *)parametersDic
{
//    isServiceTrackListLoading = YES;
//    
//    NSDictionary *postParametersDic = [parametersDic retain];
//    
//    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
//    
//    [postDataDic setValue:@"0" forKey:KHttpRequestSearchCriteria];
//    
//    [postDataDic setValue:[postParametersDic objectForKey:kMemberCardID] forKey:KHttpRequestSearchKeyWord];
//    
//    [postDataDic setValue:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
//    
//    [postDataDic setValue:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
//    
//    [postDataDic setValue:[postParametersDic objectForKey:kCurrentPage] forKey:@"pageNumber"];
//    
//    TT_RELEASE_SAFELY(postParametersDic);
//    
//    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,KHttpRequestURL];
//    
//    HTTPMSG_RELEASE_SAFELY(serviceTrackListHttpMsg);
//    
//    serviceTrackListHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ServiceTrackList];
//    
//    [self.httpMsgCtrl sendHttpMsg:serviceTrackListHttpMsg];
//    
//    TT_RELEASE_SAFELY(postDataDic);
    
    
    isServiceTrackListLoading = YES;
    
    NSDictionary *postParametersDic = parametersDic;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
//    [postDataDic setValue:@"0" forKey:KHttpRequestSearchCriteria];
    
    [postDataDic setValue:@"threeMonth" forKey:kHttpLogisticsSelectTime];
    
    [postDataDic setValue:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setValue:@"logistics" forKey:kHttpLogisticeStatus];
    
    [postDataDic setValue:[parametersDic objectForKey:@"currentPage"] forKey:kHttpLogisticePage];
    
    [postDataDic setValue:@"10" forKey:kHttpLogisticePageSize];
    
    TT_RELEASE_SAFELY(postParametersDic);
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[kHttpRequestLogistics passport]];
    
    HTTPMSG_RELEASE_SAFELY(serviceTrackListHttpMsg);
    
    serviceTrackListHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ServiceTrackList];
    serviceTrackListHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:serviceTrackListHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);

}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    isServiceTrackListLoading = NO;
    
    switch (receiveMsg.cmdCode) {
        case CC_ServiceTrackList:
        {
            //self.errorMsg = kLoginStatusMessageServerFailed;
            [self getServiceTrackListDidFinish:NO];
        }
            break;
            
        default:
            break;
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{ 
    isServiceTrackListLoading = NO;
    
    NSDictionary *items = receiveMsg.jasonItems;
        
    switch (receiveMsg.cmdCode) {
        case CC_ServiceTrackList:
        {
            if (!items)
            {
                self.errorMsg = kLoginStatusMessageServerFailed;
                
                [self getServiceTrackListDidFinish:NO];
            }
            else
            {
                NSString *totalPageString = [items objectForKey:@"numberOfPages"];
                
                if (NotNilAndNull(totalPageString) || ![totalPageString isEqualToString:@""]) 
                {
                    self.totalPage = [totalPageString intValue];
                }else{
                    self.totalPage = 1;
                }
                
                NSString *currentPageString = [items objectForKey:@"pageNumber"];
                
                if (NotNilAndNull(currentPageString) || ![currentPageString isEqualToString:@""]) {
                    
                    self.currentPage = [currentPageString intValue];
                    
                }else{
                    
                    self.currentPage = 1;
                }
                
                if (self.currentPage < self.totalPage)
                {
                    self.isLastPage = NO;
                    
                    self.currentPage++;
                    
                }else{
                    
                    self.isLastPage = YES;
                }
                
                NSArray *array = [items objectForKey:@"ordersData"];
                
                NSMutableArray *queryArray = [[NSMutableArray alloc] init];
                
                for (NSDictionary *dict in array) 
                {
                    LogisticsQueryDTO *serviceDto = [[LogisticsQueryDTO alloc] init];
                    
                    [serviceDto encodeFromDictionary:dict];
                    
                    [queryArray addObject:serviceDto];
                    
                    TT_RELEASE_SAFELY(serviceDto);
                }
                
                self.queryResultArray = queryArray;
                
                TT_RELEASE_SAFELY(queryArray);
                
                [self getServiceTrackListDidFinish:YES];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)getServiceTrackListDidFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getServiceTrackListCompleteWithService:Result:errorMsg:)]) {
        [_delegate getServiceTrackListCompleteWithService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}


@end
