//
//  ServiceDetailService.m
//  SuningEBuy
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ServiceDetailService.h"
#import "ServiceDetailDTO.h"
#import "ServiceDetailInfoDTO.h"
#import "NewSnxpressDTO.h"

@interface ServiceDetailService()

@property(nonatomic,strong) NSString *orderId;
@property(nonatomic,strong) NSString *cShopCode;
@property(nonatomic,strong) NSString *saleNum;

@end

@implementation ServiceDetailService

@synthesize delegate = _delegate;

@synthesize deliveryInforArray = _deliveryInforArray;

@synthesize installInforArray = _installInforArray;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_deliveryInforArray);
    TT_RELEASE_SAFELY(_installInforArray);
    
    HTTPMSG_RELEASE_SAFELY(serviceDetailHttpMsg);
    
}

- (void)beginGetServiceDetailWithSaleNum:(NSString *)saleNum
{
    self.saleNum = saleNum;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [dic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    [dic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [dic setObject:saleNum?saleNum:@"" forKey:KHttpRequestSaleNum];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[KHttpRequestDetailURL passport]];
    
    HTTPMSG_RELEASE_SAFELY(serviceDetailHttpMsg);
    
    serviceDetailHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:dic
                                                         cmdCode:CC_ServiceDetail];
    serviceDetailHttpMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:serviceDetailHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
    
}

- (void)beginGetShopOrderServiceDetailWithOrderId:(NSString *)orderId
                             OrderItemId: (NSString *)orderItemId
{
    
    self.orderId = orderId;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
    [dic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    [dic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [dic setObject:orderId?orderId:@"" forKey:@"omsOrderId"];
    [dic setObject:orderItemId?orderItemId:@"" forKey:@"omsOrderItemId"];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[KHttpRequestDetailURL passport]];
    
    HTTPMSG_RELEASE_SAFELY(serviceDetailHttpMsg);
    
    serviceDetailHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:dic
                                                         cmdCode:CC_ServiceDetail];
    serviceDetailHttpMsg.requestMethod =RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:serviceDetailHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
    
}


- (void)beginGetServiceDetailWithOrderId:(NSString *)orderId
                             OrderItemId: (NSString *)orderItemId{
    
    self.orderId = orderId;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
    [dic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    [dic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [dic setObject:orderId?orderId:@"" forKey:kResponseMemberOrderId];
    [dic setObject:orderItemId?orderItemId:@"" forKey:KHttpRequestOrderItemId];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[KHttpRequestDetailURL passport]];
    
    HTTPMSG_RELEASE_SAFELY(serviceDetailHttpMsg);
    
    serviceDetailHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:dic
                                                         cmdCode:CC_ServiceDetail];
    serviceDetailHttpMsg.requestMethod =RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:serviceDetailHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
    
    
}

- (void)beginGetCShopServiceDetail:(NSString *)orderId
                         cShopCode: (NSString *)cShopCode{
    
    self.cShopCode = cShopCode;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:4];
    [dic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    [dic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [dic setObject:orderId?orderId:@"" forKey:kResponseMemberOrderId];
    [dic setObject:cShopCode?cShopCode:@"" forKey:@"cshopVendorCode"];
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,@"SNIPhoneCShopOrdersLogisticsInfoView"];
    
    HTTPMSG_RELEASE_SAFELY(serviceDetailHttpMsg);
    
    serviceDetailHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:dic
                                                         cmdCode:CC_ServiceDetail];
    serviceDetailHttpMsg.requestMethod  = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:serviceDetailHttpMsg];
    
    TT_RELEASE_SAFELY(dic);
}


#pragma mark -
#pragma mark  HTTPRequest

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self getServiceDetailDidFinish:NO];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    //去除接口返回的换行符
//    NSString *responseStr = [receiveMsg.responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSDictionary *items = receiveMsg.jasonItems;
    
    if (!items)
    {
        self.errorMsg = kHttpResponseJSONValueFailError;
        
        [self getServiceDetailDidFinish:NO];
        
    }else{
        
        if ([[items objectForKey:@"errorCode"] isEqualToString:@"5015"])
        {
            self.errorMsg = @"5015";
            
            [self getServiceDetailDidFinish:NO];
            
        }else{
            
            if (NotNilAndNull(self.cShopCode)) {
                
                [self parseCShopResponseMessage:items];
                
            }else{
                
                [self parserNormalResponseMessage:items];
            }
        }
    }
}

//C店的物流详情接口

-(void)parseCShopResponseMessage:(NSDictionary *)item{
    
    
    //物流信息
    NSArray *detArray = [item objectForKey:@"distributionServiceDetailInfoList"];
    
    if (!IsArrEmpty(detArray)) {
        
        for (NSDictionary *tmpDic in detArray) {
            
            NewSnxpressDTO *dto = [[NewSnxpressDTO alloc]init];
            [dto encodeFromDictionary:tmpDic];
            
            if(!IsStrEmpty(dto.packageNum))
            {
                [self.deliveryInforArray addObject:dto];

            }
            else
            {

            }
            
        }
    }
    
    [self getServiceDetailDidFinish:YES];
   
}

//非C店的物流详情接口
- (void)parserNormalResponseMessage:(NSDictionary *)item
{
    
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
        TT_RELEASE_SAFELY(tempArr);
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
            TT_RELEASE_SAFELY(installDTO);
        }
        self.installInforArray = tempArr;
    }else{
        self.installInforArray = nil;
    }
    
    [self getServiceDetailDidFinish:YES];
   
}

- (void)getServiceDetailDidFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getServiceDetailCompleteWithService:Result:errorMsg:)])
    {
        [_delegate getServiceDetailCompleteWithService:self Result:isSuccess errorMsg:self.errorMsg];
    }
}


-(NSMutableArray *)deliveryInforArray{
    
    if (!_deliveryInforArray) {
        _deliveryInforArray = [[NSMutableArray alloc]init];
    }
    return _deliveryInforArray;
}

-(NSMutableArray *)installInforArray{
    
    if (!_installInforArray) {
        _installInforArray = [[NSMutableArray alloc]init];
    }
    return _installInforArray;
}


@end
