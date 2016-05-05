//
//  ShopCartPushTask.m
//  SuningEBuy
//
//  Created by liukun on 14-6-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopCartPushTask.h"
#import "SuNingSellDao.h"
@implementation ShopCartPushTask

- (instancetype)initWithItems:(NSArray *)items delegate:(id<BBTaskDelegate>)delegate
{
    self = [super init];
    if (self) {
        
        self.delegate = delegate;
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
        [dic setObject:@"2" forKey:@"channel"];
        
        NSMutableArray *_itemList = [[NSMutableArray alloc] init];
        
        for (ShopCartPushItem *item in items) {
            
            if ([item isCityItem]) //更改城市
            {
                [dic setObject:item.cityCode forKey:@"curCityId"];
            }
            else if ([item isQueryItem])
            {
                //do nothing
            }
            else if (item.itemId.length)
            {
                NSMutableDictionary *infoDic = [[NSMutableDictionary alloc] init];
                [infoDic setObject:item.itemId?item.itemId:@"" forKey:@"itemId"];
                if (item.quantity) {
                    [infoDic setObject:item.quantity forKey:@"quantity"];
                }
                if (item.special) {
                    [infoDic setObject:item.special forKey:@"special"];
                }
                if (item.flag) {
                    [infoDic setObject:item.flag forKey:@"flag"];
                }
                if (item.deleteFlag) {
                    [infoDic setObject:item.deleteFlag forKey:@"deleteFlag"];
                }
                [_itemList addObject:infoDic];
            }
        }
        
        if ([_itemList count]) {
            NSString *jsonString = [@{@"items": _itemList} JSONRepresentation];
            [dic setObject:jsonString forKey:@"updateInfo"];
        }else{
            [dic setObject:@"{}" forKey:@"updateInfo"];
        }
        
        [dic setObject:@"1" forKey:@"supportGroupbuy"];
        
        self.attributes = dic;
    }
    return self;
}

- (void)executeOperation
{
    NSString *url = [kHostAddressForHttp stringByAppendingString:@"/SNMobileShoppingCartQuery"];
    
    HTTPMSG_RELEASE_SAFELY(_httpMessage);
    
    _httpMessage = [[HttpMessage alloc] initWithDelegate:self
                                              requestUrl:url
                                             postDataDic:self.attributes
                                                 cmdCode:CC_ShopCartUpdate];
    [[HttpMsgCtrl shareInstance] sendHttpMsg:_httpMessage];
}

#pragma mark - call back

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *items = receiveMsg.jasonItems;
    if (receiveMsg.cmdCode == CC_ShopCartUpdate)
    {
        if (!items)
        {
            [self failWithError:kDataTaskInvalidJSONError];
        }
        else
        {
            NSString *isSuccess = EncodeStringFromDic(items, @"isSuccess");
            self.missItemId = EncodeStringFromDic(items, @"missItemId");
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
