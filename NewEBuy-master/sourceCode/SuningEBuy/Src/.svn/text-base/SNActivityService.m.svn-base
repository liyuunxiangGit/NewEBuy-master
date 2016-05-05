//
//  SNActivityService.m
//  SuningEBuy
//
//  Created by 家兴 王 on 12-10-22.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SNActivityService.h"

#define kHttpRequestActivityId            @"activityId"
#define kHttpRequestPageNumId             @"pageNumber"
#define khttprequestPageSizeValue         @"12" //@"8"
#define khttprequestPageSizeId            @"pageSize"

@interface SNActivityService()

- (void)getActivityProductDetailFinish:(BOOL)isSuccess
                              errorMsg:(NSString *)errorMsg
                      SNActivityDetail:(SNActivityDTO *)dto
                SNActivityProductArray:(NSArray *)array
                               pageNum:(NSInteger)pageNum
                             pageCount:(NSInteger)pageCount
                               actRule:(NSString *)actRule;

- (void)parseActivityProductDetailData:(NSDictionary *)items;


@end

@implementation SNActivityService

@synthesize delegate = _delegate;

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(hotSaleHttpMsg);
}

-(void)beginGetActivityProdcuctDetailList:(NSString *)activityId currentPage:(NSInteger)currentPage
{
//    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:4];
//    
//    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
//    [postDataDic setObject:activityId?activityId:@"" forKey:kHttpRequestActivityId];
//    
//    [postDataDic setObject:[NSString stringWithFormat:@"%d",currentPage] forKey:kHttpRequestPageNumId];
//    
//    [postDataDic setObject:khttprequestPageSizeValue forKey:khttprequestPageSizeId];
//    
//    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,@"SNMobilePromPrdListView"];
    
    
//    伪静态请求链接：
//http://b2cpre.cnsuning.com/emall/snmtPromPrd_{storeId}_{activityId}_{pageNumber}_{pageSize}_.html
//    伪静态请求样例：
//http://b2cpre.cnsuning.com/emall/snmtPromPrd_10052_24501_1_20_.html
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];

    NSString *pageNumberStr = [NSString stringWithFormat:@"%d",currentPage];
    
    NSString *currentCity = [[Config currentConfig] defaultCity];

    NSString *url = nil;
   
//    url = [NSString stringWithFormat:@"%@/snmtPromPrd_%@_%@_%@_%@_.html",
//           @"http://10.21.146.81/webapp/wcs/stores/servlet",
//           @"10052",
//           activityId?activityId:@"",
//           pageNumberStr?pageNumberStr:@"",
//           khttprequestPageSizeValue];
    

    url = [NSString stringWithFormat:@"%@/snmtPromPrd_%@_%@_%@_%@_%@_%@_.html",
           kHostAddressForHtml,
           @"10052",
           activityId?activityId:@"",
           pageNumberStr?pageNumberStr:@"",
           khttprequestPageSizeValue,
           currentCity?currentCity:@"",
           @"1"];
    
	HTTPMSG_RELEASE_SAFELY(hotSaleHttpMsg);
    
    
    
    hotSaleHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                requestUrl:url
                                               postDataDic:postDataDic
                                                   cmdCode:CC_ActivityProduct];
    
    hotSaleHttpMsg.requestMethod = RequestMethodGet;

    
    [self.httpMsgCtrl sendHttpMsg:hotSaleHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
    
}

#pragma mark -
#pragma mark http message delegate
- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_ActivityProduct)
    {
        [self getActivityProductDetailFinish:NO errorMsg:self.errorMsg SNActivityDetail:nil SNActivityProductArray:nil pageNum:0 pageCount:0 actRule:nil];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    //接口没有errorCode， 故不做errorCode判断
    if (receiveMsg.cmdCode == CC_ActivityProduct) {
        
        if (!items) {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self getActivityProductDetailFinish:NO errorMsg:self.errorMsg SNActivityDetail:nil SNActivityProductArray:nil pageNum:0 pageCount:0 actRule:nil];
        }else{
            [self parseActivityProductDetailData:items];
        }
        
    }
}

#pragma mark -
#pragma mark final and parse data
-(void)getActivityProductDetailFinish:(BOOL)isSuccess errorMsg:(NSString *)errorMsg SNActivityDetail:(SNActivityDTO *)dto SNActivityProductArray:(NSArray *)array pageNum:(NSInteger)pageNum pageCount:(NSInteger)pageCount actRule:(NSString *)actRule
{
    if(_delegate &&[_delegate respondsToSelector:@selector(getActivityProductListCompletionWithResult:errorMsg:SNActivityDetail:SNActivityProductArray:pageNum:pageCount:actRule:)]){
        [_delegate getActivityProductListCompletionWithResult:isSuccess errorMsg:self.errorMsg SNActivityDetail:dto SNActivityProductArray:array pageNum:pageNum pageCount:pageCount actRule:actRule];
    }
}

- (void)parseActivityProductDetailData:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            SNActivityDTO *dto = [[SNActivityDTO alloc] init];
            
            [dto encodeFromDictionary:items];
            
            //            self.errorMsg=[items objectForKey:@"errorMsg"];
            NSArray * _array=[items objectForKey:@"productList"];
            
            NSInteger _pageNum=[[items objectForKey:@"pageNumber"] intValue];
            NSInteger _pageCount=[[items objectForKey:@"pagesCount"] intValue];
            NSString  *_actRule = [items objectForKey:@"actRule"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getActivityProductDetailFinish:YES errorMsg:self.errorMsg SNActivityDetail:dto SNActivityProductArray:_array pageNum:_pageNum pageCount:_pageCount actRule:_actRule];
            });
            
        }
    });
    
}
@end
