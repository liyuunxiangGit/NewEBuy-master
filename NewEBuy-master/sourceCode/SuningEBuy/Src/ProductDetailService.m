//
//  ProductDetailService.m
//  SuningEBuy
//
//  Created by  on 12-9-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductDetailService.h"
#import "BrowsingHistoryDAO.h"
#import "RecommendDTO.h"

@interface ProductDetailService()

@property (nonatomic, strong) DataProductBasic *productBasicDTO;

- (void)parseProductDetail:(NSDictionary *)product;


- (void)getProductDetailFinish:(BOOL)isSuccess product:(DataProductBasic *)product;
- (void)addToFavoriteFinish:(BOOL)isSuccess errorCode:(NSString *)errorCode;

@end

/*********************************************************************/

@implementation ProductDetailService

@synthesize delegate = _delegate;

@synthesize productBasicDTO = _productBasicDTO;

- (void)dealloc {
    TT_RELEASE_SAFELY(_productBasicDTO);
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(getProductDetailHttpMsg);
    HTTPMSG_RELEASE_SAFELY(addToFavoriteHttpMsg);
    HTTPMSG_RELEASE_SAFELY(getProductRecListHttpMsg);
    HTTPMSG_RELEASE_SAFELY(getProductBigSaleHttpMsg);
    HTTPMSG_RELEASE_SAFELY(getProductAppointmentHttpMsg);
    HTTPMSG_RELEASE_SAFELY(getProductSpotSupportHttpMsg);
    HTTPMSG_RELEASE_SAFELY(ScScodeActionHttpMsg);
    HTTPMSG_RELEASE_SAFELY(AppointmentActionHttpMsg);
}

#pragma mark -
#pragma mark service life cycle

- (void)beginGetProductDetailInfo:(DataProductBasic *)basicDto
{
    self.isRequestError = NO;
    
    
    self.productBasicDTO = basicDto;
    
    DLog(@"123456789");
    
/*    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    
    [postDataDic setObject:(basicDto.productCode == nil ? @"" : basicDto.productCode) forKey:kHttpResponseProductCode];
    
    [postDataDic setObject:(basicDto.productId == nil ? @"" : basicDto.productId) forKey:kHttpResponseProductId];
    
    [postDataDic setObject:(basicDto.cityCode == nil ? [Config currentConfig].defaultCity : basicDto.cityCode) forKey:kHttpResponseCityCode];
    
    if (!IsStrEmpty(basicDto.xsection)||!IsStrEmpty([Config currentConfig].defaultSection)) {
        [postDataDic setObject:(basicDto.xsection == nil ? [Config currentConfig].defaultSection : basicDto.xsection) forKey:kHttpResponseSectionCode];
    }
    [postDataDic setObject:@"1" forKey:@"platform"];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
//    [postDataDic setObject:@"1" forKey:@"platform"];
//    [postDataDic setObject:@"1" forKey:@"onsale"];
    
    //xmy 2013-10-16
    if (basicDto.shopCode)
    {
        [postDataDic setObject:basicDto.shopCode forKey:@"shopCode"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNiPhoneAppShopProductDisplay"];

    
//    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, kHttpRequestProductDetail];*/
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *productId = basicDto.productId == nil ? @"" : basicDto.productId;
    NSString *partNumber = basicDto.productCode == nil ? @"" : basicDto.productCode;
    NSString *rushChanType = @"2";
    NSString  *cityCode = IsStrEmpty(basicDto.cityCode) ? [Config currentConfig].defaultCity : basicDto.cityCode;
    NSString *xsection = nil;
    
    if (!IsStrEmpty(basicDto.xsection)||!IsStrEmpty([Config currentConfig].defaultSection)) {
        
        xsection = basicDto.xsection == nil ? [Config currentConfig].defaultSection : basicDto.xsection;
    }
    //    http://b2cpre.cnsuning.com/webapp/wcs/stores/servlet/snappprd_10052_383692__9173_11366_1_.html
    
//    指定商家链接地址
//http://b2cpre.cnsuning.com/emall/snappsprd_{storeId}_{productId}_{isbn}_{cityCode}_{xsection}_{platform}_{shopCode}_.html
    
//    指定商家链接地址
//http://b2cpre.cnsuning.com/emall/snappsprd_{storeId}_{productId}_{isbn}_{cityCode}_{xsection}_{platform}_{shopCode}_.html
    
    NSString *url = nil;
    
    NSString *shopCode = nil;
    
    if (basicDto.shopCode)
    {//指定商家链接地址
        shopCode = basicDto.shopCode;
        
        url = [NSString stringWithFormat:
               @"%@/snrbsprd_%@_%@_%@_%@_%@_%@_%@_%@_%@_.html",kHostAddressForHtml,
               @"10052",
               productId?productId:@"",
               @"",
               cityCode?cityCode:@"",
               xsection?xsection:@"",
               @"1",
               shopCode?shopCode:@"",
               partNumber?partNumber:@"",
               rushChanType?rushChanType:@""];
        
        
    }
    else
    {//最优商家链接地址
        url = [NSString stringWithFormat:
               @"%@/snrbprd_%@_%@_%@_%@_%@_%@_%@_%@_.html",
               kHostAddressForHtml,
               @"10052",
               productId?productId:@"",
               @"",
               cityCode?cityCode:@"",
               xsection?xsection:@"",
               @"1",
               partNumber?partNumber:@"",
               rushChanType?rushChanType:@""];
        
    }

    
//    if (basicDto.shopCode)
//    {//指定商家链接地址
//        shopCode = basicDto.shopCode;
//        
//        url = [NSString stringWithFormat:
//               @"%@/snappsprd_%@_%@_%@_%@_%@_%@_%@_.html",kHostAddressForHtml,
//               @"10052",
//               productId?productId:@"",
//               @"",
//               cityCode?cityCode:@"",
//               xsection?xsection:@"",
//               @"1",
//               shopCode?shopCode:@""];
//        
//        
//    }
//    else
//    {//最优商家链接地址
//        url = [NSString stringWithFormat:
//               @"%@/snappprd_%@_%@_%@_%@_%@_%@_.html",
//               kHostAddressForHtml,
//               @"10052",
//               productId?productId:@"",
//               @"",
//               cityCode?cityCode:@"",
//               xsection?xsection:@"",
//               @"1"];
//        
//    }

    HTTPMSG_RELEASE_SAFELY(getProductDetailHttpMsg);
    
    getProductDetailHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                         requestUrl:url
                                                        postDataDic:postDataDic
                                                            cmdCode:CC_ProductDetail];
    getProductDetailHttpMsg.requestMethod = RequestMethodGet;
    getProductDetailHttpMsg.canMultipleConcurrent = YES;
    [self.httpMsgCtrl sendHttpMsg:getProductDetailHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
    
}

- (void)beginGetProductDetailInfoWithIsbn:(NSString *)isbn
{
    self.isRequestError = NO;
    
/*    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:6];
    
    [postDataDic setObject:@"" forKey:kHttpResponseProductCode];
    
    [postDataDic setObject:@"" forKey:kHttpResponseProductId];
    
    [postDataDic setObject:IsStrEmpty([Config currentConfig].defaultSection)?@"":[Config currentConfig].defaultSection forKey:kHttpResponseSectionCode];

    [postDataDic setObject:@"1" forKey:@"platform"];

    [postDataDic setObject:isbn?isbn:@"" forKey:@"isbn"];
    
    [postDataDic setValue:[Config currentConfig].defaultCity forKey:kHttpResponseCityCode];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, kHttpRequestProductDetail];
    */
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSString *productId = @"";
    
    NSString  *cityCode = [Config currentConfig].defaultCity;
    
    NSString *xsection = IsStrEmpty([Config currentConfig].defaultSection)?@"":[Config currentConfig].defaultSection;
    
    NSString *isBn = isbn?isbn:@"";
    
    NSString *url =  nil;
    NSString *shopCode = @"";

    url = [NSString stringWithFormat:
           @"%@/snappsprd_%@_%@_%@_%@_%@_%@_%@_.html",kHostAddressForHtml,
           @"10052",
           productId?productId:@"",
           isBn?isBn:@"",
           cityCode?cityCode:@"",
           xsection?xsection:@"",
           @"1",
           shopCode?shopCode:@""];

    HTTPMSG_RELEASE_SAFELY(getProductDetailHttpMsg);
    
    getProductDetailHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                         requestUrl:url
                                                        postDataDic:postDataDic
                                                            cmdCode:CC_ProductDetail];
    getProductDetailHttpMsg.canMultipleConcurrent = YES;
    getProductDetailHttpMsg.requestMethod = RequestMethodGet;

    [self.httpMsgCtrl sendHttpMsg:getProductDetailHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginAddToFavorite:(DataProductBasic *)basicDto
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:6];
    
    [postDataDic setObject:(basicDto.productCode == nil ? @"" : basicDto.productCode) forKey:kHttpResponseProductCode];
    
    [postDataDic setObject:(basicDto.productId == nil ? @"" : basicDto.productId) forKey:kHttpResponseProductId];
    
    [postDataDic setObject:(basicDto.cityCode == nil ? [Config currentConfig].defaultCity : basicDto.cityCode) forKey:kHttpResponseCityCode];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:IsStrEmpty(basicDto.shopCode)?@"":basicDto.shopCode forKey:@"vendorCode"];
    
    [postDataDic setObject:@"MobileClient" forKey:@"channel"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, kHttpRequestFavorite];
    
    HTTPMSG_RELEASE_SAFELY(addToFavoriteHttpMsg);
    
    addToFavoriteHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic 
                                                         cmdCode:CC_AddToFavorite];
    
    [self.httpMsgCtrl sendHttpMsg:addToFavoriteHttpMsg];
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginGetProductRecommendList:(DataProductBasic *)basicDto
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    
    [postDataDic setObject:(basicDto.productCode == nil ? @"" : basicDto.productCode) forKey:@"parameter"];
    
    [postDataDic setObject:@"10-17" forKey:@"sceneIds"];
    
    [postDataDic setObject:(basicDto.cityCode == nil ? [Config currentConfig].defaultCity : basicDto.cityCode) forKey:@"cityId"];
    
    [postDataDic setObject:@"6" forKey:@"count"];
    
//    [postDataDic setObject:[UserCenter defaultCenter].userInfoDTO.memberCardNo?[UserCenter defaultCenter].userInfoDTO.memberCardNo:@"" forKey:@"u"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kProductDetailRecommendHttp, @"scenesBiz.jsonp"];
    
    HTTPMSG_RELEASE_SAFELY(getProductRecListHttpMsg);
    
    getProductRecListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_RecommendListProduct];
    
    [self.httpMsgCtrl sendHttpMsg:getProductRecListHttpMsg];
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginGetProductBigSaleInfo:(DataProductBasic *)basicDto
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    NSString *productCode = basicDto.productCode == nil ? @"" : basicDto.productCode;
    if (productCode.length == 18) {
        productCode = [productCode substringFromIndex:9];
    }
    NSString *partNumber = productCode;
    NSString *vendorCode = basicDto.shopCode == nil ? @"" : basicDto.shopCode;
    NSString *cityId = basicDto.cityCode;
    
    [postDataDic setObject:cityId forKey:@"cityId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_%@_%@.html", KNewHomeAPIURL, @"sale/djhAct",partNumber,vendorCode,@"MOBILE"];
    
    HTTPMSG_RELEASE_SAFELY(getProductBigSaleHttpMsg);
    
    getProductBigSaleHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                          requestUrl:url
                                                         postDataDic:postDataDic
                                                             cmdCode:CC_BigSaleProduct];
    
    [self.httpMsgCtrl sendHttpMsg:getProductBigSaleHttpMsg];
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginGetProductAppointmentInfo:(DataProductBasic *)basicDto
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    NSString *productCode = basicDto.productCode == nil ? @"" : basicDto.productCode;
    if (productCode.length == 9) {
        productCode = [NSString stringWithFormat:@"000000000%@",productCode];
    }
    NSString *partNumber = productCode;
    
    NSString *vendorCode = basicDto.shopCode == nil ? @"" : basicDto.shopCode;
    if (vendorCode.length == 8) {
        vendorCode = [NSString stringWithFormat:@"00%@",vendorCode];
    }else if ([vendorCode isEqualToString:@""])
    {
        vendorCode = @"0000000000";
    }
    
    [postDataDic setObject:partNumber forKey:@"partNumber"];
    [postDataDic setObject:vendorCode forKey:@"vendorId"];
    
    NSString *url;
#ifdef kReleaseH
    url = [NSString stringWithFormat:@"%@/%@", kEbuyWapHostURL, @"appointment/queryAppointActivity.html"];
    
#else
    url = [NSString stringWithFormat:@"%@/%@", kEbuyWapHostURL, @"mts-web/appointment/queryAppointActivity.html"];
    
#endif
    
    HTTPMSG_RELEASE_SAFELY(getProductAppointmentHttpMsg);
    
    getProductAppointmentHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                          requestUrl:url
                                                         postDataDic:postDataDic
                                                             cmdCode:CC_AppointmentProduct];
    getProductAppointmentHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:getProductAppointmentHttpMsg];
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginAppointmentAction:(DataProductBasic *)basicDto
{
    self.productBasicDTO = basicDto;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    NSString *productCode = basicDto.productCode == nil ? @"" : basicDto.productCode;
    if (productCode.length == 9) {
        productCode = [NSString stringWithFormat:@"000000000%@",productCode];
    }
    NSString *partNumber = productCode;
    
    NSString *vendorCode = basicDto.shopCode == nil ? @"" : basicDto.shopCode;
    if (vendorCode.length == 8) {
        vendorCode = [NSString stringWithFormat:@"00%@",vendorCode];
    }
    else if ([vendorCode isEqualToString:@""])
    {
        vendorCode = @"0000000000";
    }
    
    [postDataDic setObject:partNumber forKey:@"partNumber"];
    [postDataDic setObject:vendorCode forKey:@"vendorId"];
    
    NSString *url;
#ifdef kReleaseH
    url = [NSString stringWithFormat:@"%@/%@", kEbuyWapHostURL, @"appointment/private/queryAppointProduct.html"];
#else
    url = [NSString stringWithFormat:@"%@/%@", kEbuyWapHostURL, @"mts-web/appointment/private/queryAppointProduct.html"];
#endif
    
    HTTPMSG_RELEASE_SAFELY(AppointmentActionHttpMsg);
    
    AppointmentActionHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                              requestUrl:url
                                                             postDataDic:postDataDic
                                                                 cmdCode:CC_AppointmentActoin];
    AppointmentActionHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:AppointmentActionHttpMsg];
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)beginScScodeProductBuyAction:(DataProductBasic *)basicDto
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    
    NSString *productCode = basicDto.productCode == nil ? @"" : basicDto.productCode;
    if (productCode.length == 9) {
        productCode = [NSString stringWithFormat:@"000000000%@",productCode];
    }
    NSString *partNumber = productCode;
    
    NSString *vendorCode = basicDto.shopCode == nil ? @"" : basicDto.shopCode;
    if (vendorCode.length == 8) {
        vendorCode = [NSString stringWithFormat:@"00%@",vendorCode];
    }
    else if ([vendorCode isEqualToString:@""])
    {
        vendorCode = @"0000000000";
    }
    
    NSString *actionId = basicDto.scScodeActivetyId == nil ? @"" : basicDto.scScodeActivetyId;
    
//    [postDataDic setObject:partNumber forKey:@"partNumber"];
//    [postDataDic setObject:vendorCode forKey:@"vendorId"];
//    [postDataDic setObject:actionId forKey:@"actionId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@_%@_%@.html", kEbuyWapHostURL, @"appointment/private/authSCode",actionId,vendorCode,partNumber];
    
    HTTPMSG_RELEASE_SAFELY(ScScodeActionHttpMsg);
    
    ScScodeActionHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                          requestUrl:url
                                                         postDataDic:postDataDic
                                                             cmdCode:CC_ScScodeAcion];
    ScScodeActionHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:ScScodeActionHttpMsg];
    TT_RELEASE_SAFELY(postDataDic);

}

- (void)beginGetProductIsSpotSupported:(DataProductBasic *)basicDto
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSString *partNumber = basicDto.productCode == nil ? @"" : basicDto.productCode;
    if (partNumber.length == 9) {
        partNumber = [NSString stringWithFormat:@"000000000%@",partNumber];
    }
    
    NSString  *cityCode = IsStrEmpty(basicDto.cityCode) ? [Config currentConfig].defaultCity : basicDto.cityCode;
    
    NSString *vendorCode = basicDto.shopCode == nil ? @"" : basicDto.shopCode;
    if (vendorCode.length == 8) {
        vendorCode = [NSString stringWithFormat:@"00%@",vendorCode];
    }
    else if ([vendorCode isEqualToString:@""])
    {
        vendorCode = @"0000000000";
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@_%@_%@_%@_%@_%@_%@_.html", kHostAddressForHtml, @"snmtmdjt",@"10052",@"10051",
                     partNumber?partNumber:@"",
                     cityCode?cityCode:@"",
                     vendorCode?vendorCode:@"",
                     @""];
    
    HTTPMSG_RELEASE_SAFELY(getProductSpotSupportHttpMsg);
    
    getProductSpotSupportHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_SpotSupport];
    getProductSpotSupportHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:getProductSpotSupportHttpMsg];
    TT_RELEASE_SAFELY(postDataDic);
}

#pragma mark -
#pragma mark final method

- (void)getProductDetailFinish:(BOOL)isSuccess product:(DataProductBasic *)product
{
    if (_delegate && [_delegate respondsToSelector:@selector(getProductDetailCompletionWithResult:errorMsg:productDetail:)]) {
        [_delegate getProductDetailCompletionWithResult:isSuccess errorMsg:self.errorMsg productDetail:product];
    }
}

- (void)addToFavoriteFinish:(BOOL)isSuccess errorCode:(NSString *)errorCode
{
    if (_delegate && [_delegate respondsToSelector:@selector(addToFavoriteCompletionWithResult:errorMsg:errorCode:)]) {
        [_delegate addToFavoriteCompletionWithResult:isSuccess errorMsg:self.errorMsg errorCode:errorCode];
    }
}

- (void)getBigSaleDetailFinish:(BOOL)isSuccess bigSale:(BigSaleDTO *)dto
{
    if (_delegate && [_delegate respondsToSelector:@selector(getBigSaleProductCompletionWithResult:service:errorMsg:bigSaleDetail:)]) {
        [_delegate getBigSaleProductCompletionWithResult:isSuccess service:self errorMsg:self.errorMsg bigSaleDetail:dto];
    }
}

- (void)getAppointmentDetailFinished:(BOOL)isSuccess appointment:(AppointmentDTO *)dto
{
    if (_delegate && [_delegate respondsToSelector:@selector(getAppointmentProductCompletionWithResult:service:errorMsg:appointmentDetail:)]) {
        [_delegate getAppointmentProductCompletionWithResult:isSuccess service:self errorMsg:self.errorMsg appointmentDetail:dto];
    }
}

- (void)appointmentActionFinish:(BOOL)isSuccess hasAppointment:(NSString *)isAppointment
{
    if (_delegate && [_delegate respondsToSelector:@selector(appointmentActionCompletionWithResult:errorMsg:)]) {
        [_delegate appointmentActionCompletionWithResult:isSuccess errorMsg:self.errorMsg];
    }
}

- (void)scScodeActionFinish:(BOOL)isSuccess withRedirectStatus:(NSString *)redirectStatus
{
    if (_delegate && [_delegate respondsToSelector:@selector(scScodeActionCompletionWithResult:redirectStatus:errorMsg:)]) {
        [_delegate scScodeActionCompletionWithResult:isSuccess redirectStatus:redirectStatus errorMsg:self.errorMsg];
    }
}

- (void)getSpotSupportFinish:(BOOL)isSuccess{
    if (_delegate && [_delegate respondsToSelector:@selector(getIsSpotSupportedWithResult:)]) {
        [_delegate getIsSpotSupportedWithResult:isSuccess];
    }
}

#pragma mark -
#pragma mark service back delegate

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_ProductDetail) {
        if (KPerformance)
        {
            PerformanceStatisticsHttp* temp = [[PerformanceStatisticsHttp alloc] init];
            temp.startTime = [NSDate date];
            temp.functionId = @"3";
            temp.interfaceId = @"302";
            temp.errorType = @"02";
            temp.errorCode = [NSString stringWithFormat:@"%@",receiveMsg.errorCode];
            [[PerformanceStatistics sharePerformanceStatistics]sendCustomNetData:temp];
        }
        self.isRequestError = YES;
        [self getProductDetailFinish:NO product:nil];
    }
    else if (receiveMsg.cmdCode == CC_RecommendListProduct)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(getRecommendListCompletionWithResult:errorCode:list:)]) {
            [_delegate getRecommendListCompletionWithResult:NO
                                                  errorCode:self.errorMsg
                                                       list:nil];
        }
    }
    else if (receiveMsg.cmdCode == CC_BigSaleProduct)
    {
        [self getBigSaleDetailFinish:NO bigSale:nil];
    }
    else if (receiveMsg.cmdCode == CC_AppointmentProduct)
    {
        [self getAppointmentDetailFinished:NO appointment:nil];
    }
    else if (receiveMsg.cmdCode == CC_AppointmentActoin)
    {
        [self appointmentActionFinish:NO hasAppointment:nil];
    }
    else if (receiveMsg.cmdCode == CC_ScScodeAcion)
    {
        [self scScodeActionFinish:NO withRedirectStatus:nil];
    }
    else if (receiveMsg.cmdCode == CC_AddToFavorite)
    {
        [self addToFavoriteFinish:NO errorCode:nil];
    }
    else if (receiveMsg.cmdCode == CC_SpotSupport)
    {
        [self getSpotSupportFinish:NO];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_ProductDetail) {
        //商品详情
        if (receiveMsg.jasonItems == nil)
        {
            self.errorMsg = L(@"SorryProductPauseSaleOrNetException");
            [self getProductDetailFinish:NO product:nil];
        }
        
        else if ([receiveMsg.errorCode isEqualToString:@"404"])
        {
            self.errorMsg = L(@"Product_Off_Shelf_Error");
            [self getProductDetailFinish:NO product:nil];
        }
        else if ([receiveMsg.errorCode isEqualToString:@""] || [receiveMsg.errorCode isEqualToString:@"isBundle"])
        {
            [self parseProductDetail:receiveMsg.jasonItems];
        }
        else
        {
            self.errorMsg = L(@"SorryProductPauseSaleBuyOtherSameKindGood");
            [self getProductDetailFinish:NO product:nil];
        }
    }
    else if (receiveMsg.cmdCode == CC_RecommendListProduct)
    {
        //推荐商品
        NSDictionary *dic = [receiveMsg jasonItems];
        
        if (dic == nil)
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            
            if (_delegate && [_delegate respondsToSelector:@selector(getRecommendListCompletionWithResult:errorCode:list:)]) {
                [_delegate getRecommendListCompletionWithResult:NO errorCode:self.errorMsg list:nil];
            }
        }
        
        NSArray *sugGoods = [dic objectForKey:@"sugGoods"];
        
        NSDictionary *listDic = [sugGoods objectAtIndex:0];
        
        NSString *returnCode = [listDic objectForKey:@"resCode"];
        
        if ([returnCode isEqualToString:@"01"])
        {
            [self parseRecommendList:listDic];
        }
        else
        {
            self.errorMsg = L(@"NWServeBusyTryLater");
            
            if (_delegate && [_delegate respondsToSelector:@selector(getRecommendListCompletionWithResult:errorCode:list:)]) {
                [_delegate getRecommendListCompletionWithResult:NO errorCode:self.errorMsg list:nil];
            }
        }
        
    }
    else if (receiveMsg.cmdCode == CC_BigSaleProduct)
    {
        if (receiveMsg.jasonItems == nil)
        {
            self.errorMsg = L(@"NWSorryNWException");
            [self getBigSaleDetailFinish:NO bigSale:nil];
        }
        NSDictionary *dic = [receiveMsg jasonItems];
        NSString *isSuccess = [dic objectForKey:@"isSuccess"];
        if ([isSuccess isEqualToString:@"0"]) {
            NSString *isDjhActive = [dic objectForKey:@"isDjhActive"];
            NSString *djhActiveStatusStr = [dic objectForKey:@"djhActiveStatus"];
            if ([isDjhActive isEqualToString:@"1"]) {
                self.djhActiveStatusStr = djhActiveStatusStr;
                NSDictionary *subDic = [dic objectForKey:@"gPActivityInfo"];
                BigSaleDTO *dto = [[BigSaleDTO alloc] init];
                [dto encodeFromDictionary:subDic];
                [dto setBigSaleStatus:djhActiveStatusStr];
                [self getBigSaleDetailFinish:YES bigSale:dto];
            }
            else
            {
                [self getBigSaleDetailFinish:NO bigSale:nil];
            }
        }else
        {
            [self getBigSaleDetailFinish:NO bigSale:nil];
        }
    }
    else if (receiveMsg.cmdCode == CC_AppointmentProduct)
    {
        if (receiveMsg.jasonItems == nil)
        {
            self.errorMsg = L(@"NWSorryNWException");
            [self getAppointmentDetailFinished:NO appointment:nil];
        }
        NSDictionary *dic = [receiveMsg jasonItems];
        NSString *isSuccess = [dic objectForKey:@"code"];
        NSDictionary *subDic = [dic objectForKey:@"data"];
//        isSuccess = @"2";
        if ([isSuccess isEqualToString:@"1"]) {
            [self parseAppointDetailInfo:subDic];
        }
        else if ([isSuccess isEqualToString:@"2"])
        {
            [self parseScProductDetailInfo:subDic];
        }
        else
        {
            [self getAppointmentDetailFinished:NO appointment:nil];
        }
    }
    else if (receiveMsg.cmdCode == CC_AppointmentActoin)
    {
        if (receiveMsg.jasonItems == nil)
        {
            self.errorMsg = L(@"NWSorryNWException");
            [self appointmentActionFinish:NO hasAppointment:nil];
        }
        NSDictionary *dic = [receiveMsg jasonItems];
        NSString *isSuccess = [dic objectForKey:@"code"];
        if ([isSuccess isEqualToString:@"1"]) {
            NSArray *dataArr = [dic objectForKey:@"data"];
            //接口返回商品簇内所有商品，对比商品编码是否一致再判断是否已预约
            if (dataArr.count > 0) {
                for (NSDictionary *subDic in dataArr) {
                    NSString *partNumber = [subDic objectForKey:@"partNumber"];
                    if ([partNumber isEqualToString:self.productBasicDTO.productCode]) {
                        NSString *isAppointed = [subDic objectForKey:@"isAppointed"];
                        if ([isAppointed isEqualToString:@"1"]) {
                            [self appointmentActionFinish:YES hasAppointment:isAppointed];
                        }
                        else
                        {
                            self.errorMsg = L(@"SorryYouNotMakeAnAppointmentCantSnapUp");
                            [self appointmentActionFinish:NO hasAppointment:nil];
                        }
                    }
                }
            }
            else
            {
                [self appointmentActionFinish:NO hasAppointment:nil];
            }
            
        }else
        {
            [self appointmentActionFinish:NO hasAppointment:nil];
        }
    }
    else if (receiveMsg.cmdCode == CC_ScScodeAcion)
    {
        if (receiveMsg.jasonItems == nil)
        {
            self.errorMsg = L(@"NWSorryNWException");
            [self scScodeActionFinish:NO withRedirectStatus:nil];
        }
        NSDictionary *dic = [receiveMsg jasonItems];
        NSString *isSuccess = [dic objectForKey:@"code"];
        if ([isSuccess isEqualToString:@"1"]) {
            NSDictionary *subDic = [dic objectForKey:@"data"];
            NSString *redirectStatus = [subDic objectForKey:@"redirectStatus"];
            [self scScodeActionFinish:YES withRedirectStatus:redirectStatus];
        }else
        {
            [self scScodeActionFinish:NO withRedirectStatus:nil];
        }
    }
    else  if (receiveMsg.cmdCode == CC_AddToFavorite)
    {
        //添加收藏
        NSDictionary *items = receiveMsg.jasonItems;
        if (items == nil) {
            self.errorMsg = kHttpResponseJSONValueFailError;    //json解析失败
            [self addToFavoriteFinish:NO errorCode:nil];
        }else if([[items objectForKey:kHttpResponseErrorCode] isEqualToString:@"S"]){
            self.errorMsg = L(@"Success");// @"加入收藏成功!";
            [self addToFavoriteFinish:YES errorCode:@"S"];
        }else if ([[items objectForKey:kHttpResponseErrorCode] isEqualToString:@"D"]) {
            self.errorMsg = L(@"Check");//@"已经收藏此商品!";
            [self addToFavoriteFinish:NO errorCode:@"D"];
        }else if ([[items objectForKey:@"userId"] floatValue] < 0){
            self.errorMsg = L(@"Login_Session_Failure");
            [self addToFavoriteFinish:NO errorCode:nil];
        }
        else {
            self.errorMsg = L(@"Add_Favorite_Fail");//@"加入收藏失败";
            [self addToFavoriteFinish:NO errorCode:nil];
        }
    }
    else if (receiveMsg.cmdCode == CC_SpotSupport)
    {
        if (receiveMsg.jasonItems == nil)
        {
            self.errorMsg = L(@"NWSorryNWException");
            [self getSpotSupportFinish:NO];
        }
        NSDictionary *dic = [receiveMsg jasonItems];
        NSString *isSuccess = [dic objectForKey:@"isSuccess"];
        if ([isSuccess isEqualToString:@"1"]) {
            [self getSpotSupportFinish:YES];
        }else
        {
            [self getSpotSupportFinish:NO];
        }
    }
}

- (void)parseProductDetail:(NSDictionary *)items
{
    Background_Begin
    DataProductBasic *dto = [[DataProductBasic alloc] init];
    
    [dto encodeFromDictionary:items];
    
    //添加详情没有的字段
    dto.evaluation = self.productBasicDTO.evaluation;
    
    if (dto.isCShop) {
        NSString *marketPrice = [NSString stringWithFormat:@"%@",dto.marketPrice];
        if (IsStrEmpty(marketPrice)||[marketPrice isEqualToString:@"0"]) {
            dto.price = dto.suningPrice;
        }
        else
        {
            dto.price = dto.marketPrice;
        }
        
    }
    else
    {
        dto.price = dto.suningPrice;
    }
    
    /*
     废弃
     //将isAbook的值反传给basic
     if(self.productDetailDTO.isABook)
     {
     self.productBasicDTO.isABook = YES;
     
     }else{
     
     self.productBasicDTO.isABook = NO;
     }
     */
    
    NSString *cityCodea = dto.cityCode;
    dto.cityCode = @"";
    //图书商品设置图片数量1
    if (dto.isABook && !dto.imageNum)
    {
        dto.imageNum = @"1";
    }
    
    //将浏览记录写入数据库
    BrowsingHistoryDAO *dao = [[BrowsingHistoryDAO alloc] init];
    
    [dao writeProductToDB:dto];
    
    
    Foreground_Begin
    
    dto.cityCode = cityCodea;
    
    [self getProductDetailFinish:YES product:dto];
//    if (!dto.isCShop && !dto.isPublished) {
//        
//        self.errorMsg = L(@"Product_Off_Shelf_Error");
//        [self getProductDetailFinish:NO product:nil];
//        
//    }else{
//        [self getProductDetailFinish:YES product:dto];
//    }
    
    Foreground_End
    
    Background_End
}

-(void)parseRecommendList:(NSDictionary *)dic
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool
        {
            NSMutableArray *logisticsProductArray = [[NSMutableArray alloc] init];
            
            NSArray *array = [dic objectForKey:@"skus"];
            
            for(NSDictionary *dtoDic in array)
            {
                RecommendListDTO *logDto = [[RecommendListDTO alloc] init];
                
                [logDto encodeFromDictionary:dtoDic];
                
                [logisticsProductArray addObject:logDto];
                
                TT_RELEASE_SAFELY(logDto);
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_delegate && [_delegate respondsToSelector:@selector(getRecommendListCompletionWithResult:errorCode:list:)])
                {
                    [_delegate getRecommendListCompletionWithResult:YES
                                                          errorCode:nil
                                                               list:logisticsProductArray];
                }
            });
        }
    });
}

- (void)parseAppointDetailInfo:(NSDictionary *)dic
{
    NSString *status = NotNilAndNull([dic objectForKey:@"status"])?[dic objectForKey:@"status"]:@"";
    NSString *scActionType = NotNilAndNull([dic objectForKey:@"scActionType"])?[dic objectForKey:@"scActionType"]:@"";
    BOOL isScProduct = NO;
//    scActionType = @"3";
    if ([scActionType isEqualToString:@"3"] || [scActionType isEqualToString:@"4"]) {
        isScProduct = YES;
    }
    self.isScProduct = isScProduct;
    AppointmentDTO *dto = [[AppointmentDTO alloc] init];
    [dto encodeFromDictionary:dic];
    if ([status isEqualToString:@"1000"] || [status isEqualToString:@"1006"]) //活动未开始或活动已结束
    {
        [self getAppointmentDetailFinished:NO appointment:dto];
    }else
    {
        [self getAppointmentDetailFinished:YES appointment:dto];
    }
}

- (void)parseScProductDetailInfo:(NSDictionary *)dic
{
    BOOL isScProduct = NO;
    NSString *scActionType = NotNilAndNull([dic objectForKey:@"scActionType"])?[dic objectForKey:@"scActionType"]:@"";
//    scActionType = @"3";
    if ([scActionType isEqualToString:@"3"] || [scActionType isEqualToString:@"4"]) {
        isScProduct = YES;
    }
    self.isScProduct = isScProduct;
    AppointmentDTO *dto = [[AppointmentDTO alloc] init];
    [dto encodeFromDictionary:dic];
    [self getAppointmentDetailFinished:NO appointment:dto];
}

@end
