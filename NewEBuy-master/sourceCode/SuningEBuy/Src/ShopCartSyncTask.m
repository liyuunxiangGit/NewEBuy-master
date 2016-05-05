//
//  ShopCartSyncTask.m
//  SuningEBuy
//
//  Created by liukun on 14-6-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopCartSyncTask.h"
#import "ShopCartShopDTO.h"
#import "SuNingSellDao.h"

@implementation ShopCartSyncTask

- (NSString *)postPackageItems:(NSArray *)shopList
{
    NSMutableArray *itemList = [NSMutableArray array];
    for (ShopCartShopDTO *shop in shopList)
    {
        NSAssert([shop isKindOfClass:[ShopCartShopDTO class]], @"ShopCartShopDTO type error");
        [itemList addObjectsFromArray:shop.itemList];
    }
    
    NSMutableArray *postArr = [NSMutableArray arrayWithCapacity:[itemList count]];
    
//    NSMutableDictionary *checkStateDic = [NSMutableDictionary dictionary];
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
        
        //大聚惠
        if (!IsStrEmpty(item.juhuiActiveId)) {
            [postDic setValue:item.juhuiActiveId forKey:@"actId"];
        }
        
        //勾选
        [postDic setValue:STR_FROM_INT(item.isChecked) forKey:@"flag"];
        
//        if (![checkStateDic[item.catentryId] boolValue])
//        {
//            [checkStateDic setObject:@(item.isChecked) forKey:item.catentryId];
//        }
//        
//        
        
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
//    self.cartListCheckStateDic = checkStateDic;
    
    return [postDataDic JSONRepresentation];
}


- (instancetype)initWithCartList:(NSArray *)cartList
                         isMerge:(BOOL)isMerge
                      isInSettle:(BOOL)isInSettle
                        delegate:(id<BBTaskDelegate>)delegate
{
    self = [super init];
    
    if (self) {
        
        self.delegate = delegate;
        _isMerge = isMerge;
        
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
        //支持大聚惠
        [postDataDic setObject:@"1" forKey:@"supportGroupbuy"];
        
        if (isInSettle) {
            [postDataDic setObject:@"logonWin" forKey:@"logonWin"];
        }
        
        self.attributes = postDataDic;
    }
    
    return self;
}

- (void)executeOperation
{
    //engine
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttp, @"SNMobileShoppingCartQuery"];
    
    HTTPMSG_RELEASE_SAFELY(_httpMessage);
    
    _httpMessage = [[HttpMessage alloc] initWithDelegate:self
                                              requestUrl:url
                                             postDataDic:self.attributes
                                                 cmdCode:CC_SyncShopCart];
    [[HttpMsgCtrl shareInstance] sendHttpMsg:_httpMessage];
    
}

#pragma mark - call back

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    if (receiveMsg.cmdCode == CC_SyncShopCart)
    {
        if (!items)
        {
            [self failWithError:kDataTaskInvalidJSONError];
        }
        else
        {
            NSString *isSuccess = EncodeStringFromDic(items, @"isSuccess");
            if ([isSuccess isEqualToString:@"1"])
            {
                [self parseShoppingCartList:items];
                [self markAsFinished];
            }
            else
            {
                [self failWithError:TaskError(1, L(@"ShopCart_Sync_Fail"))];
            }
            
        }
    }
}

- (void)parseShoppingCartList:(NSDictionary *)items
{
    /**
     *  接口返回金额仅为商品金额，展示合计要加上返回的总运费
     *  @author kb
     *  @since  2.4.3
     */
    NSNumber *totalShipPrice = EncodeNumberFromDic(items, @"totalShipCharge");
    NSNumber *userShouldPay = EncodeNumberFromDic(items, @"userPayAllPrice");
    double allPrice = [totalShipPrice doubleValue] + [userShouldPay doubleValue];
    self.userPayAllPrice = [NSNumber numberWithDouble:allPrice];
    
    self.productAllPrice = EncodeNumberFromDic(items, @"productAllPrice");
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
        suningShop.totalShipPrice = EncodeNumberFromDic(items, @"snTotalShipPrice");
        suningShop.limitedAmount = EncodeNumberFromDic(items, @"limitedAmount");
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
    if (![__gIsProduceCode length])
    {
        return;
    }
    //销售来源
    SuNingSellDao* dao = [[SuNingSellDao alloc] init];
    for (int i = 0;i < [resultList count];++i)
    {
        id tempData = resultList[i];
        if ([tempData isKindOfClass:[ShopCartShopDTO class]])
        {
            NSArray* tempArray = ((ShopCartShopDTO*)tempData).itemList;
            BOOL isBreak = NO;
            for (ShopCartV2DTO* tempShopCartV2DTO in tempArray)
            {
                if ([__gIsProduceCode isEqualToString:((ShopCartV2DTO*)tempShopCartV2DTO).partNumber])
                {
                    NSString *tempPrice = [tempShopCartV2DTO.itemPrice formatPriceString];
                    [dao insertSuNingSellDAOFromDB:sourceTitle channelDetail:daoPageTitle produceCode:tempShopCartV2DTO.partNumber producePrice:tempPrice];
                    isBreak = YES;
                    break;
                }
            }
            if (isBreak)
            {
                break;
            }
        }
        else if ([tempData isKindOfClass:[ShopCartV2DTO class]]&&([__gIsProduceCode isEqualToString:((ShopCartV2DTO*)tempData).partNumber]))
        {
            NSString *tempPrice = [((ShopCartV2DTO*)tempData).itemPrice formatPriceString];
            [dao insertSuNingSellDAOFromDB:sourceTitle channelDetail:daoPageTitle produceCode:((ShopCartV2DTO*)tempData).partNumber producePrice:tempPrice];
            break;
        }
    }
    __gIsProduceCode = nil;

}

- (NSArray *)invalidItemsFromItemList:(NSArray *)itemList
{
    if ([itemList count] == 0)
    {
        return nil;
    }
    //查找错误的订单行
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    for (ShopCartShopDTO *shop in itemList)
    {
        for (ShopCartV2DTO *item in shop.itemList)
        {
            NSAssert([item isKindOfClass:[ShopCartV2DTO class]], @"ShopCartV2DTO type error");
            if (item.isCanntCheck == YES) {
                [resultArr addObject:item];
            }
        }
    }
    
    return [resultArr count]?resultArr:nil;
}

@end
