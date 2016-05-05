//
//  ShopSnxpressService.m
//  SuningEBuy
//
//  Created by xmy on 26/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopSnxpressService.h"
#import "ServiceDetailDTO.h"
#import "HttpConstant.h"

@implementation ShopSnxpressService

- (void)httpMsgRelease{
    
    HTTPMSG_RELEASE_SAFELY(_ShopSnxpressMsg);
    
}
- (void)sendShopSnxpressRequest:(NSString*)saleNum WithCatalogId:(NSString*)catalogId
{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[@"SNMobileLogisticsInfoView" passport]];

    //门店订单物流查询
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc]init];
    
    [postDataDic setObject:@"10052" forKey:@"storeId"];
    [postDataDic setObject:@"10051" forKey:@"catalogId"];
    [postDataDic setObject:saleNum?saleNum:@"" forKey:@"saleNum"];
//    [postDataDic setObject:@"0550377829" forKey:@"saleNum"];

    
    HTTPMSG_RELEASE_SAFELY(_ShopSnxpressMsg);
    
    _ShopSnxpressMsg = [[HttpMessage alloc]initWithDelegate:self
                                                  requestUrl:url
                                                 postDataDic:postDataDic
                                                     cmdCode:CC_ShopSnxpress];
    
    _ShopSnxpressMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:_ShopSnxpressMsg];
}

#pragma mark -
#pragma mark http message delegate
#pragma mark -
#pragma mark  HTTPRequest


- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self getShopSnxpressData:NO];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    
    DLog(@"SNxpress is : %@",items);
    
    if (!items)
    {
        
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self getShopSnxpressData:NO];
        
        
    }
    else
    {
        if ([[items objectForKey:@"errorCode"] isEqualToString:@"5015"])
        {
            self.errorMsg = @"5015";
        }
        
        [self parserResponseMessage:items];
        
        
    }
}

- (void)parserResponseMessage:(NSDictionary *)item
{
	Background_Begin
    
    //送货详情
    NSArray *detArray = [item objectForKey:@"distributionServiceDetailInfoList"];
    
    if (!IsArrEmpty(detArray))
    {
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:[detArray count]];
        for (NSDictionary *dedic in detArray)
        {
            ServiceDetailDTO *detDTO = [[ServiceDetailDTO alloc] init];
            [detDTO encodeFromDictionary:dedic withType:ServiceDetailDeliveryInfo];
            if ([detDTO.deliveryItemList count] > 0) {
                [tempArr addObject:detDTO];
            }
            TT_RELEASE_SAFELY(detDTO);
        }
        self.deliveryInforArray = tempArr;
    }
    else
    {
        self.deliveryInforArray = nil;
    }
    
    //安装详情
    NSArray *installList = [item objectForKey:@"distributionServiceInstallInfoList"];
    if (!IsArrEmpty(installList)) {
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:[installList count]];
        for (NSDictionary *insDit in installList)
        {
            ServiceDetailDTO *installDTO = [[ServiceDetailDTO alloc]init];
            [installDTO encodeFromDictionary:insDit withType:ServiceDetailInstallInfo];
            [tempArr addObject:installDTO];
        }
        self.installInforArray = tempArr;
    }else{
        self.installInforArray = nil;
    }
    
    Foreground_Begin
    [self getShopSnxpressData:YES];
    Foreground_End
    
	Background_End
}
//- (void)receiveDidFailed:(HttpMessage *)receiveMsg
//{
//    [super receiveDidFailed:receiveMsg];
//    
//    [self getShopSnxpressData:NO];
//}
//
//- (void)receiveDidFinished:(HttpMessage *)receiveMsg
//{
//    NSDictionary *items = receiveMsg.jasonItems;
//    //    NSString *errorCode = receiveMsg.errorCode;
//    
//    NSLog(@"_ShopOrderListMsg1111********* %@",items);
//    
//    if (!items) {
//        self.errorMsg = kHttpResponseJSONValueFailError;
//        [self getShopSnxpressData:NO];
//        
//    }
//    
//    else
//    {
//        
//        NSMutableArray *arr = [[NSMutableArray alloc] init];
//        
//        
//        [self getShopSnxpressData:YES];
//    }
//}

- (void)getShopSnxpressData:(BOOL)isSuccess
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(getShopSnxpress:errorMsg:)])
    {        
        [_delegate getShopSnxpress:isSuccess errorMsg:self.errorMsg];
        
    }
    
}


@end
