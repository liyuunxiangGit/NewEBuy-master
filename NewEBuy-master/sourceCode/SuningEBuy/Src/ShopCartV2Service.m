//
//  ShopCartV2Service.m
//  SuningEBuy
//
//  Created by  liukun on 13-5-6.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopCartV2Service.h"
#import "SNCache.h"
#import "ShopCartLogic.h"

@interface ShopCartV2Service()

@property (nonatomic, strong) NSDictionary *cartListCheckStateDic;

@end

/*********************************************************************/

@implementation ShopCartV2Service


- (void)dealloc
{
    
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(syncShopCartHttpMsg);
    HTTPMSG_RELEASE_SAFELY(orderCheckHttpMsg);
    HTTPMSG_RELEASE_SAFELY(buyNowOrderHttpMsg);
}

#pragma mark -
#pragma mark utils

- (NSString *)postPackageItems:(NSArray *)shopList
{
    NSMutableArray *itemList = [NSMutableArray array];
    for (ShopCartShopDTO *shop in shopList)
    {
        NSAssert([shop isKindOfClass:[ShopCartShopDTO class]], @"ShopCartShopDTO type error");
        [itemList addObjectsFromArray:shop.itemList];
    }
    
    NSMutableArray *postArr = [NSMutableArray arrayWithCapacity:[itemList count]];
    
    NSMutableDictionary *checkStateDic = [NSMutableDictionary dictionary];
    for (ShopCartV2DTO *item in itemList)
    {
        NSAssert([item isKindOfClass:[ShopCartV2DTO class]], @"ShopCartV2DTO type error");
        NSMutableDictionary *postDic = [[NSMutableDictionary alloc] init];
        [postDic setValue:item.orderItemId?item.orderItemId:@"" forKey:@"itemId"];
        [postDic setValue:item.quantity forKey:@"quantity"];
        [postDic setValue:item.catentryId forKey:@"productId"];
        [postDic setValue:item.cityCode forKey:@"cityId"];
        [postDic setValue:item.saleOrg forKey:@"saleOrg"];
        //是否C店
        [postDic setValue:item.supplierCode forKey:@"supplierCode"];

        //是否是抢购或单价团
        if (item.special > ShopCartSpecialNone)
        {
            [postDic setValue:STR_FROM_INT(item.special) forKey:@"special"];
        }
        else
        {
            [postDic setObject:@"" forKey:@"special"];
        }

        //勾选
        [postDic setValue:STR_FROM_INT(item.isChecked) forKey:@"flag"];
        
        if (![checkStateDic[item.catentryId] boolValue])
        {
            [checkStateDic setObject:@(item.isChecked) forKey:item.catentryId];
        }
        
        if (!IsStrEmpty(item.juhuiActiveId)) {
            [postDic setObject:item.juhuiActiveId forKey:@"actId"];
        }
        
        //套餐类型
        switch (item.packageType) {
            case PackageTypeNormal:
            {
                //正常商品
                break;
            }
            case PackageTypeAccessory:
            {
                //配件套餐
                NSArray *accessList = item.accessoryPackageList;
                if ([accessList count] > 0)
                {
                    NSMutableArray *postAccessArr  = [NSMutableArray arrayWithCapacity:[accessList count]];
                    for (ShopCartV2DTO *dto in accessList)
                    {
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:dto.orderItemId?dto.orderItemId:@"" forKey:@"itemId"];
                        [dic setValue:dto.catentryId forKey:@"productId"];
                        [dic setValue:dto.quantity forKey:@"quantity"];
                        [dic setValue:dto.cityCode forKey:@"cityId"];
                        [dic setValue:dto.saleOrg forKey:@"saleOrg"];
                        [dic setValue:dto.massocceceId forKey:@"massocceceId"];
                        [dic setValue:dto.supplierCode forKey:@"supplierCode"];
                        [postAccessArr addObject:dic];
                        TT_RELEASE_SAFELY(dic);
                    }
                    [postDic setObject:postAccessArr forKey:@"accessoryList"];
                }
                break;
            }
            case PackageTypeSmall:
            {
                //小套餐
                NSArray *smallPackageList = item.smallPackageList;
                if ([smallPackageList count] > 0)
                {
                    NSUInteger count = [smallPackageList count];
                    NSMutableArray *postSmallArr = [NSMutableArray arrayWithCapacity:count];
                    
                    for (ShopCartV2DTO *dto in smallPackageList)
                    {
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:dto.orderItemId?dto.orderItemId:@"" forKey:@"itemId"];
                        [dic setValue:dto.catentryId forKey:@"productId"];
                        [dic setValue:dto.quantity forKey:@"quantity"];
                        [dic setValue:dto.cityCode forKey:@"cityId"];
                        [dic setValue:dto.saleOrg forKey:@"saleOrg"];
                        [dic setValue:dto.supplierCode forKey:@"supplierCode"];
                        [postSmallArr addObject:dic];
                        TT_RELEASE_SAFELY(dic);
                    }
                    [postDic setObject:postSmallArr forKey:@"smallPackageList"];
                }
                break;
            }
            case PackageTypeXn:
            {
                //x元n件，暂时客户端没有
                NSArray *sunPackageList = item.xnPackageList;
                if ([sunPackageList count] > 0)
                {
                    NSUInteger count = [sunPackageList count];
                    NSMutableArray *postSunArr = [NSMutableArray arrayWithCapacity:count];
                    
                    for (ShopCartV2DTO *dto in sunPackageList)
                    {
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setValue:dto.orderItemId?dto.orderItemId:@"" forKey:@"itemId"];
                        [dic setValue:dto.partNumber forKey:@"productId"];
                        [dic setValue:dto.quantity forKey:@"quantity"];
                        [dic setValue:dto.cityCode forKey:@"cityId"];
                        [dic setValue:dto.saleOrg forKey:@"saleOrg"];
                        [dic setValue:dto.supplierCode forKey:@"supplierCode"];
                        [postSunArr addObject:dic];
                        TT_RELEASE_SAFELY(dic);
                    }
                    [postDic setObject:postSunArr forKey:@"xnPackageList"];
                }
                break;
            }
            default:
                break;
        }
        
        [postArr addObject:postDic];
        TT_RELEASE_SAFELY(postDic);
    }
    
    NSDictionary *postDataDic = [NSDictionary dictionaryWithObject:postArr forKey:@"items"];
    self.cartListCheckStateDic = checkStateDic;
    
    return [postDataDic JSONRepresentation];
}

#pragma mark -
#pragma mark service life

- (void)requestSyncShopCart:(NSArray *)cartList isMerge:(BOOL)isMerge
{            
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    //是否合并
    [postDataDic setObject:STR_FROM_INT(isMerge) forKey:@"isMerge"];
    
    NSString *itemJasonStr = [self postPackageItems:cartList];
    [postDataDic setObject:itemJasonStr forKey:@"cartInfo"];
    
    // 支持勾选
    [postDataDic setObject:@"1" forKey:@"supportCheck"];
    //支持套餐
    [postDataDic setObject:@"1" forKey:@"supportPackage"];
    //不支持阳光包
    [postDataDic setObject:@"0" forKey:@"supportSunPack"];
    //支持C店
    [postDataDic setObject:@"1" forKey:@"supportCShop"];
    //支持C店勾选
    [postDataDic setObject:@"1" forKey:@"supportCShopCheck"];
    
    //engine
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNMobileShoppingCartQuery"];
    
    HTTPMSG_RELEASE_SAFELY(syncShopCartHttpMsg);
    syncShopCartHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:postDataDic
                                                        cmdCode:CC_SyncShopCart];
    [self.httpMsgCtrl sendHttpMsg:syncShopCartHttpMsg];
    TT_RELEASE_SAFELY(postDataDic);
}


//老的调用方法，已遗弃
- (BOOL)checkProductCanAddToShopCartSync:(DataProductBasic *)product
                                quantity:(int)quantity
                                   error:(NSString **)errorMsg
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    //普通商品数据请求
    //数量为1
    if (product.quantity < 1) {
        product.quantity = 1;
    }
    
    [postDataDic setValue:product.productId forKey:@"catEntryId_1"];
    [postDataDic setValue:__INT(product.quantity) forKey:@"quantity"];
    
    //抢购
    if (product.quickbuyId.trim.length > 0)
    {
        [postDataDic setValue:self.user.userId forKey:@"rushMemberId"];
        [postDataDic setValue:product.quickbuyId forKey:@"rushActId"];
        [postDataDic setValue:product.cityCode forKey:@"rushCityId"];
        [postDataDic setValue:@"rush" forKey:@"promotionType"];
        [postDataDic setValue:product.rushProcessId?product.rushProcessId:@"" forKey:@"procId"];
    }
    
    //单价团
    if (product.danjiaGroupId.trim.length > 0)
    {
        [postDataDic setValue:@"simpleGroup" forKey:@"promotionType"];
    }
    
    //小套餐
    if (product.packageType == PackageTypeSmall)
    {
        [postDataDic setValue:@"1" forKey:@"isKitWare"];
        [postDataDic setValue:product.productCode forKey:@"configurationId_1"];
    }
    //配件套餐
    else if (product.packageType == PackageTypeAccessory)
    {
        NSArray *accessoryList = product.allAccessoryProductList;
        if ([accessoryList count] > 0)
        {
            int i = 1;
            NSString *key = nil;
            for (DataProductBasic *dto in accessoryList)
            {
                //被选中
                if (dto.isAccessorySelect) {
                    key = [NSString stringWithFormat:@"massocceceId_%d", i];
                    [postDataDic setValue:dto.masocceceId forKey:key];
                    i++;
                }
            }
        }
    }
    //暂不支持x元n件
    else if (product.packageType == PackageTypeXn)
    {
        
    }
    
    //C店商品
    if (product.isCShop)
    {
        [postDataDic setObject:product.shopCode forKey:@"supplierCode"];
    }
    else
    {
        //苏宁自营商品传空
        [postDataDic setObject:@"" forKey:@"supplierCode"];
    }
    
    //engine
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNMobileAddShoppingCart"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    NSArray *allKeys = [postDataDic allKeys];
    for(NSString *key in allKeys)
    {
        [request setPostValue:[postDataDic objectForKey:key] forKey:key];
    }
    NSString *cityId =
    [Config currentConfig].defaultCity?[Config currentConfig].defaultCity:@"9173";
    NSDictionary *cookieProperty = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    suningCookieDomain, NSHTTPCookieDomain,
                                    suningCookieDomain, NSHTTPCookieOriginURL,
                                    @"/", NSHTTPCookiePath,
                                    @"cityId", NSHTTPCookieName,
                                    cityId, NSHTTPCookieValue, nil];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperty];
    
    [[request requestCookies] addObject:cookie];

	[request setDefaultResponseEncoding:NSUTF8StringEncoding];
    [request setTimeOutSeconds:HTTP_TIMEOUT];
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif
	[request startSynchronous];
    
    DLog(@"\n=============================================================================================begin\n----requestUrl = %@ \n----UrlParaDic =  %@\n----Response: (status %d) (JSON ) = \n%@\n=============================================================================================end\n",url, postDataDic, request.responseStatusCode, [request.responseString formatJSON]);
    
    TT_RELEASE_SAFELY(postDataDic);
    
    if (request.responseStatusCode == 200)
    {
        NSDictionary *items = request.jasonItems;
        if (!items)
        {
            *errorMsg = kHttpResponseJSONValueFailError;
            return NO;
        }
        else
        {
            NSString *isSuccess = EncodeStringFromDic(items, @"isSuccess");
            if ([isSuccess isEqualToString:@"1"])
            {
                return YES;
            }
            else
            {
                NSString *error = EncodeStringFromDic(items, @"errorMessage");
                if ([error hasPrefix:@"CMN"]) {
                    error = L(@"ShopCart_Add_Error_CheckFail");
                }
                if (error.trim.length == 0) {
                    error = L(@"ShopCart_Add_Error_CheckFail");
                }
                *errorMsg = error;
                return NO;
            }
        }
    }
    else
    {
        *errorMsg = [self errorMsgOfASIErrorCode:request.error.code];
        return NO;
    }
}

//Kristopher
- (void)requestBuyNowOrder:(NSArray *)cartList{
    {
        NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
        
        [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
        
        [postDataDic setObject:@"1" forKey:@"submit_method"];
        
        [postDataDic setObject:@"2" forKey:@"channel"];
        
        [postDataDic setObject:[ShopCartLogic submitType:cartList] forKey:@"cshopFlag"];
        
        NSString *itemJasonStr = [self postPackageItems:cartList];
        
        [postDataDic setObject:itemJasonStr forKey:@"cartInfo"];
        
        NSString *url = [NSString stringWithFormat:@"%@/%@",
                         kHostAddressForHttp, @"SNMTCartQuick"];
        
        HTTPMSG_RELEASE_SAFELY(buyNowOrderHttpMsg);
        
        buyNowOrderHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                       requestUrl:url
                                                      postDataDic:postDataDic
                                                          cmdCode:CC_BuyNowOrder];
        
        [self.httpMsgCtrl sendHttpMsg:buyNowOrderHttpMsg];
        
        TT_RELEASE_SAFELY(postDataDic);
    }
}

- (void)requestOrderCheckOut:(NSArray *)cartList
{    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    NSString *itemJasonStr = [self postPackageItems:cartList];
    [postDataDic setObject:itemJasonStr forKey:@"cartInfo"];
    
    [postDataDic setObject:@"1" forKey:@"submit_method"];
    
//    //支持C店
//    if ([ShopCartLogic isCShopOrder:cartList]) {
//        [postDataDic setObject:@"1" forKey:@"cshopFlag"];
//    }else{
//        [postDataDic setObject:@"0" forKey:@"cshopFlag"];
//    }
    [postDataDic setObject:[ShopCartLogic submitType:cartList] forKey:@"cshopFlag"];
    
    [postDataDic setObject:itemJasonStr forKey:@"cartInfo"];
        
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kHostAddressForHttp, [@"SNMobileAddShoppingCart" passport]];
    
    HTTPMSG_RELEASE_SAFELY(orderCheckHttpMsg);
    
    orderCheckHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                   requestUrl:url
                                                  postDataDic:postDataDic
                                                      cmdCode:CC_OrderCheckOut];
    
    [self.httpMsgCtrl sendHttpMsg:orderCheckHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

- (void)requestOrderCheckOutV3:(NSArray *)cartList
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    [postDataDic setObject:@"1" forKey:@"submit_method"];
    [postDataDic setObject:@"2" forKey:@"channel"];
    [postDataDic setObject:@"" forKey:@"cshopFlag"];
    [self postPackageItems:cartList];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kHostAddressForHttp, @"SNMTCartSettle"];
    
    HTTPMSG_RELEASE_SAFELY(orderCheckHttpMsg);
    
    orderCheckHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                   requestUrl:url
                                                  postDataDic:postDataDic
                                                      cmdCode:CC_OrderCheckOut];
    
    [self.httpMsgCtrl sendHttpMsg:orderCheckHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}

#pragma mark -
#pragma mark final

- (void)syncShopCartOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(service:syncShopCartComplete:)]) {
        [_delegate service:self syncShopCartComplete:isSuccess];
    }
}

- (void)orderCheckOutOk:(BOOL)isSuccess
{
    if ([_delegate respondsToSelector:@selector(service:orderCheckOutComplete:)]) {
        [_delegate service:self orderCheckOutComplete:isSuccess];
    }
}

#pragma mark -
#pragma mark http Message response

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_SyncShopCart)
    {
        [self syncShopCartOk:NO];
    }
    else if (receiveMsg.cmdCode == CC_OrderCheckOut||receiveMsg.cmdCode == CC_BuyNowOrder)
    {
        [self orderCheckOutOk:NO];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    if (receiveMsg.cmdCode == CC_SyncShopCart)
    {
        if (!items)
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self syncShopCartOk:NO];
        }
        else
        {
            NSString *isSuccess = EncodeStringFromDic(items, @"isSuccess");
            if ([isSuccess isEqualToString:@"1"])
            {
                [self parseShoppingCartList:items];
            }
            else
            {
                self.errorMsg = L(@"ShopCart_Sync_Fail");
                [self syncShopCartOk:NO];
            }

        }
    }
    else if (receiveMsg.cmdCode == CC_OrderCheckOut||receiveMsg.cmdCode == CC_BuyNowOrder)
    {
        if (!items)
        {
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self orderCheckOutOk:NO];
        }
        else
        {
            NSString *isSuccess = EncodeStringFromDic(items, @"isSuccess");
            NSString *powerFlag = EncodeStringFromDic(items, @"powerFlag");
            self.powerFlag = powerFlag;
            if ([isSuccess isEqualToString:@"1"])
            {
                [self parseOrderCheckOutSuccessInfo:items];
                [self orderCheckOutOk:YES];
            }
            else
            {
                [self parseOrderCheckOutErrorInfo:items];
                [self orderCheckOutOk:NO];
            }
        }
    }
}

#pragma mark -
#pragma mark parse data

- (void)parseShoppingCartList:(NSDictionary *)items
{
    self.productAllPrice = EncodeNumberFromDic(items, @"productAllPrice");
    self.userPayAllPrice = EncodeNumberFromDic(items, @"userPayAllPrice");
    self.sunpgkPrice = EncodeNumberFromDic(items, @"sunpgkPrice");
    self.totalDiscount = EncodeNumberFromDic(items, @"totalDiscount");
    self.promotionDesc = EncodeStringFromDic(items, @"promotionDesc");

    NSString *inSameCity = EncodeStringFromDic(items, @"inSameCity");
    self.inSameCity = [inSameCity isEqualToString:@"true"]?YES:NO;
    
    //购物车列表
    NSMutableArray *resultList = [NSMutableArray array];

    //苏宁自营
    NSMutableArray *suningItemList = (NSMutableArray *)EncodeArrayFromDicUsingParseBlock(items, @"itemList", ^id(NSDictionary *innerDic) {
        
        ShopCartV2DTO *dto = [[ShopCartV2DTO alloc] init];
        [dto encodeFromDictionary:innerDic];
        return dto;
    });
    if (suningItemList.count)
    {
        ShopCartShopDTO *suningShop = [[ShopCartShopDTO alloc] init];
        suningShop.shopName = L(@"MyEBuy_SuningSelf");
        suningShop.itemList = suningItemList;
        [resultList addObject:suningShop];
    }
    
    //C店
    NSArray *cShopList = EncodeArrayFromDicUsingParseBlock(items, @"cShopList", ^id(NSDictionary *innerDic) {
        
        ShopCartShopDTO *dto = [[ShopCartShopDTO alloc] init];
        [dto encodeFromDictionary:innerDic];
        return dto;
    });
    [resultList addObjectsFromArray:cShopList];
    
    self.shopCartItemList = resultList;
    
    [self syncShopCartOk:YES];
}

- (void)parseOrderCheckOutSuccessInfo:(NSDictionary *)items
{
    self.powerFlag = EncodeStringFromDic(items, @"powerFlag");
    
    //购物车列表
    NSMutableArray *resultList = [NSMutableArray array];
    
    //苏宁自营
    NSMutableArray *suningItemList = (NSMutableArray *)EncodeArrayFromDicUsingParseBlock(items, @"itemList", ^id(NSDictionary *innerDic) {
        
        ShopCartV2DTO *dto = [[ShopCartV2DTO alloc] init];
        [dto encodeFromDictionary:innerDic];
        return dto;
    });
    if (suningItemList.count)
    {
        ShopCartShopDTO *suningShop = [[ShopCartShopDTO alloc] init];
        suningShop.shopName = L(@"MyEBuy_SuningSelf");
        suningShop.shipPrice = EncodeNumberFromDic(items, @"snShipCharge");
        suningShop.itemList = suningItemList;
        [resultList addObject:suningShop];
    }
    
    //C店
    NSArray *cShopList = EncodeArrayFromDicUsingParseBlock(items, @"cShopList", ^id(NSDictionary *innerDic) {
        
        ShopCartShopDTO *dto = [[ShopCartShopDTO alloc] init];
        [dto encodeFromDictionary:innerDic];
        return dto;
    });
    self.isallCorder = NO;
    if ([cShopList count])
    {
        self.isallCorder = YES;
        [resultList addObjectsFromArray:cShopList];
        self.isCOrder = YES;
        if (suningItemList.count) {
            self.isallCorder = NO;
        }
       
    }
    
    self.shopCartItemList = resultList;
    
    self.productAllPrice = EncodeNumberFromDic(items, @"productAllPrice");
    self.userPayAllPrice = EncodeNumberFromDic(items, @"userPayAllPrice");
    self.sunpgkPrice = EncodeNumberFromDic(items, @"sunpgkPrice");
    self.totalShipPrice = EncodeNumberFromDic(items, @"totalShipPrice");
    self.totalDiscount = EncodeNumberFromDic(items, @"totalDiscount");
    
    NSString *canUseEleInvoice = EncodeStringFromDic(items, @"canUseEleInvoice");
    self.canUseEleInvoice = [canUseEleInvoice isEqualToString:@"1"]?YES:NO;
    NSString *isEleInvoiceIsDefault = EncodeStringFromDic(items, @"eleInvoiceIsDefault");
    self.eleInvoiceIsDefault = [isEleInvoiceIsDefault isEqualToString:@"1"]?YES:NO;
}

- (void)parseOrderCheckOutErrorInfo:(NSDictionary *)items
{
    NSArray *exceptionList = EncodeArrayFromDic(items, @"exceptionList");
    
    if ([exceptionList count] > 0)
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[exceptionList count]];
        for (NSDictionary *dic in exceptionList)
        {
            ShopCartV2DTO *dto = [[ShopCartV2DTO alloc] init];
            [dto encodeFromDictionary:dic];
            [array addObject:dto];
        }
        self.exceptionList = array;
    }
    
    self.cShopExceptionList = EncodeArrayFromDicUsingParseBlock(items, @"cShopExceptionList", ^id(NSDictionary *innerDic) {
        
        ShopCartShopDTO *shop = [[ShopCartShopDTO alloc] init];
        [shop encodeForExceptionListFromDic:innerDic];
        return shop;
    
    });
    
    if (self.exceptionList.count || self.cShopExceptionList.count)
    {
        NSMutableArray *cartList = [[NSMutableArray alloc] init];
        if (self.exceptionList.count)
        {
            ShopCartShopDTO *suningShop = [ShopCartShopDTO suningShop];
            [suningShop setItemList:[self.exceptionList mutableCopy]];
            [cartList addObject:suningShop];
        }
        if (self.cShopExceptionList.count)
        {
            [cartList addObjectsFromArray:self.cShopExceptionList];
        }
        
        self.shopCartItemList = cartList;
        self.productAllPrice = EncodeNumberFromDic(items, @"productAllPrice");
        self.userPayAllPrice = EncodeNumberFromDic(items, @"userPayAllPrice");
        self.sunpgkPrice = EncodeNumberFromDic(items, @"sunpgkPrice");
        self.totalShipPrice = EncodeNumberFromDic(items, @"totalShipPrice");
        self.totalDiscount = EncodeNumberFromDic(items, @"totalDiscount");
        
        NSString *inSameCity = EncodeStringFromDic(items, @"inSameCity");
        self.inSameCity = [inSameCity isEqualToString:@"true"]?YES:NO;
    }
    
    //查找错误的订单行
    NSMutableArray *allExceptionList = [NSMutableArray arrayWithArray:self.exceptionList];
    for (ShopCartShopDTO *shop in self.cShopExceptionList)
    {
        [allExceptionList addObjectsFromArray:shop.itemList];
    }
    self.errorItemList = [self errorItemsFromExceptionList:allExceptionList];
    self.errorItem = [self.errorItemList firstObject];
    
    if (self.exceptionList.count == 0 && self.cShopExceptionList.count == 0)
    {
        NSString *erroMessage = EncodeStringFromDic(items, @"errorMessage");
        self.errorMsg = erroMessage.length?erroMessage:L(@"System_Abnomal_Try_later");
    }
}

- (ShopCartV2DTO *)errorItemFromExceptionList:(NSArray *)exceptionList
{
    return [[self errorItemsFromExceptionList:exceptionList] firstObject];
}

- (NSArray *)errorItemsFromExceptionList:(NSArray *)exceptionList
{
    if ([exceptionList count] == 0)
    {
        return nil;
    }
    
//    ShopCartV2DTO *errorItem = nil;
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    for (ShopCartV2DTO *item in exceptionList)
    {
        NSAssert([item isKindOfClass:[ShopCartV2DTO class]], @"ShopCartV2DTO type error");
        
        BOOL ischecked = [[self.cartListCheckStateDic objectForKey:item.catentryId] boolValue];
        if (ischecked)
        {
            if (item.errorDesc.trim.length > 0) {
                [resultArr addObject:item];
            }
            
            if (item.packageType == PackageTypeAccessory)
            {
                for (ShopCartV2DTO *innerItem in item.accessoryPackageList)
                {
                    if (innerItem.errorDesc.trim.length > 0) {
                        [resultArr addObject:innerItem];
                    }
                }
            }
            
            if (item.packageType == PackageTypeSmall)
            {
                for (ShopCartV2DTO *innerItem in item.smallPackageList)
                {
                    if (innerItem.errorDesc.trim.length > 0) {
                        [resultArr addObject:innerItem];
                    }
                }
            }
        }
    }
    
    return [resultArr count]?resultArr:nil;
}

#pragma mark -
#pragma mark cache method

//- (NSString *)shopCartCacheName
//{
//    NSString *userId = self.user?self.user.userId:@"unlogin";
//    NSString *cacheName = [NSString stringWithFormat:@"sn.shopcart.%@", userId];
//    return cacheName;
//}
//
//- (void)saveShopCartListToCache:(NSArray *)shopCartItemList
//{
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:shopCartItemList];
//    [[SNFileCache defaultCache] saveData:data
//                                    forKey:[self shopCartCacheName]
//                                  cacheAge:kSNCacheAgeForever];
//}
//
//- (NSArray *)shopCartListFromCache
//{
//    NSData *data = [[SNFileCache defaultCache] dataForKey:[self shopCartCacheName]];
//    id temp = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    if ([temp isKindOfClass:[NSArray class]]) {
//        return (NSArray *)temp;
//    }else{
//        return nil;
//    }
//}
//
//- (NSArray *)unloginShopCartListFromCache
//{
//    NSString *cahceName = @"sn.shopcart.unlogin";
//    NSData *data = [[SNFileCache defaultCache] dataForKey:cahceName];
//    if (!data) {
//        return nil;
//    }
//    id temp = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//    if ([temp isKindOfClass:[NSArray class]]) {
//        return (NSArray *)temp;
//    }else{
//        return nil;
//    }
//}
//
//- (void)removeUnloginShopCart //在登录后，合并完成后，清除未登录的购物车。
//{
//    [[SNFileCache defaultCache] removeDataForKey:@"sn.shopcart.unlogin"];
//}

@end
