//
//  ShopCartLogic.m
//  SuningEBuy
//
//  Created by  liukun on 13-10-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopCartLogic.h"
#import "SNCache.h"
#import "AddressInfoDAO.h"
#import "SuNingSellDao.h"

@implementation ShopCartLogic


- (id)initWithCartList:(NSMutableArray *)cartList
       productAllPrice:(NSNumber *)productAllPrice
       userPayAllPrice:(NSNumber *)userPayAllPrice
           sunpgkPrice:(NSNumber *)sunpgkPrice
         totalDiscount:(NSNumber *)totalDiscount
         promotionDesc:(NSString *)promotionDesc
            inSameCity:(BOOL)inSameCity
{
    self = [super init];
    if (self) {
        
        self.shopCartList = cartList;
        self.productAllPrice = productAllPrice;
        self.userPayAllPrice = userPayAllPrice;
        self.sunpgkPrice = sunpgkPrice;
        self.totalDiscount = totalDiscount;
        self.promotionDesc = promotionDesc;
        self.inSameCity = inSameCity;
        
        //计算城市
        ShopCartV2DTO *firstItem = [self firstItem];
        self.cityCode = firstItem.cityCode;
        if (firstItem.cityName.length) {
            self.cityName = firstItem.cityName;
        }else if ([AddressInfoDAO isUpdateAddressOk]){
            AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
            self.cityName = [dao getCityNameByCityCode:self.cityCode];
        }else{
            self.cityName = @"";
        }
        
        //统一城市
        if (!inSameCity)
        {
            [self changeAllItemsCity:self.cityCode cityName:self.cityName];
        }
    }
    return self;
}

- (NSMutableArray *)shopCartList
{
    if (!_shopCartList) {
        _shopCartList = [[NSMutableArray alloc] init];
    }
    return _shopCartList;
}

- (NSString *)description
{
    NSString *str = [NSString stringWithFormat:@""];
    for (ShopCartShopDTO * shopDto in self.shopCartList)
    {
        for (ShopCartV2DTO *v2Dto in shopDto.itemList)
        {
            NSString *str1 = [NSString stringWithFormat:@"v2Dto = %@;v2Dto.isChecked = %d", v2Dto, v2Dto.isChecked];
            str = [str stringByAppendingString:str1];
        }
    }
    return str;
}

#pragma mark ----------------------------- utils

//是否为空
- (BOOL)isEmpty
{
    return self.shopCartList.count==0 ? YES : NO;
}

//是否有效的商品列表为空
- (BOOL)isValidItemEmpty
{
    //查找错误的订单行
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isCanntCheck == NO) {
            [resultArr addObject:dto];
        }
    }];
    
    return [resultArr count] ? NO : YES;
}

//所有订单行的合并列表
- (NSArray *)allItemList
{
    NSMutableArray *itemList = [NSMutableArray array];
    for (ShopCartShopDTO *shop in self.shopCartList)
    {
        NSAssert([shop isKindOfClass:[ShopCartShopDTO class]], @"ShopCartShopDTO type error");
        [itemList addObjectsFromArray:shop.itemList];
    }
    return itemList;
}

//第一个商品
- (ShopCartV2DTO *)firstItem
{
    ShopCartShopDTO *shop = [self.shopCartList firstObject];
    ShopCartV2DTO *item = [shop.itemList firstObject];
    return item;
}

//当前默认送货城市
- (NSString *)currentDeliveryCity
{
    __block NSString *deliveryCityCode = nil;
    
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isChecked) {
            deliveryCityCode = dto.cityCode;
            *stop = YES;
        }
    }];
    
    return deliveryCityCode;
}

//当前默认送货城市Name
- (NSString *)currentDeliveryCityName
{
    __block NSString *deliveryCityName = nil;
    
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isChecked) {
            deliveryCityName = dto.cityName;
            *stop = YES;
        }
    }];
    
    return deliveryCityName;
}

//当前默认送货城市
- (void)getDeliveryCityCode:(NSString **)cityCode cityName:(NSString **)cityName
{
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isChecked) {
            *cityCode = dto.cityCode;
            *cityName = dto.cityName;
            *stop = YES;
        }
    }];
}

//已勾选的购物车商品列表
- (NSArray *)checkedCartItemList
{
    NSMutableArray *array = [NSMutableArray array];
    
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isChecked) {
            [array addObject:dto];
        }
    }];
    
    return array;
}

//已勾选的购物车商品数量
- (NSInteger)checkedCartItemCount
{
    __block NSInteger count = 0;
    
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isChecked) {
            count+=[dto totalQuantity];
        }
    }];
    
    return count;
}

//编辑状态下已勾选的购物车商品数量
- (NSInteger)checkedEditCartItemCount
{
    __block NSInteger count = 0;
    
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isDeleteItemCheck) {
            count+=[dto totalQuantity];
        }
    }];
    
    return count;
}

//已勾选的购物车商品列表(包括套餐内商品)
- (NSArray *)checkedShopList
{
    NSMutableArray *array = [NSMutableArray array];
    
    [self enumerateShopsUsingBlock:^(ShopCartShopDTO *shop, BOOL *stop) {
        
        ShopCartShopDTO *shopCopy = [shop copy];
        NSArray *itemList = [shopCopy.itemList copy];
        for (ShopCartV2DTO *item in itemList)
        {
            if (!item.isChecked)
            {
                [shopCopy.itemList removeObject:item];
            }
        }
        
        if (shopCopy.itemList.count > 0)
        {
            [array addObject:shopCopy];
        }
        
    }];

    return array;
}

//购物车中店家的订单列表, shopCode为nil或@""，返回苏宁自营列表
- (NSArray *)itemListInShopCartOfShop:(NSString *)shopCode
{
    ShopCartShopDTO *shop = [self shopDTOInShopCartOfShop:shopCode];
    if (shop && shop.itemList)
    {
        return [NSArray arrayWithArray:shop.itemList];
    }
    return nil;
}

//失效的商品
- (NSArray *)invalidItemList
{
    //查找错误的订单行
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isCanntCheck) {
            [resultArr addObject:dto];
        }
    }];
    
    return [resultArr count]?[resultArr copy]:nil;
}

//购物车中店家DTO, shopCode为nil或@""，返回苏宁自营列表
- (ShopCartShopDTO *)shopDTOInShopCartOfShop:(NSString *)shopCode
{
    ShopCartShopDTO *shopDto = nil;
    if (!shopCode.length)
    {
        for (ShopCartShopDTO *shop in self.shopCartList)
        {
            //苏宁自营放在第一个
            NSAssert([shop isKindOfClass:[ShopCartShopDTO class]], @"ShopCartShopDTO type error");
            if (shop.isSuning)  shopDto = shop;
            break;
        }
    }
    else
    {
        for (ShopCartShopDTO *shop in self.shopCartList)
        {
            NSAssert([shop isKindOfClass:[ShopCartShopDTO class]], @"ShopCartShopDTO type error");
            if ([shop.shopCode isEqualToString:shopCode])
            {
                shopDto = shop;
                break;
            }
        }
    }
    return shopDto;
}

//购物车中店家DTO,
- (ShopCartShopDTO *)shopDTOInShopCartAtIndex:(NSInteger)index
{
    if (self.shopCartList.count > index)
    {
        return [self.shopCartList objectAtIndex:index];
    }
    else
    {
        return nil;
    }
}

//购物车中 商品所对应的 ShopCartV2DTO
- (ShopCartV2DTO *)cartItemInShopCartOfProduct:(DataProductBasic *)product
{
    ShopCartV2DTO *shopCartItem = nil;
    NSArray *itemList = nil;
    if (product.isCShop) //C店
    {
        itemList = [self itemListInShopCartOfShop:product.shopCode];
    }
    else
    {
        itemList = [self itemListInShopCartOfShop:nil];
    }
    
    for (ShopCartV2DTO *dto in itemList)
    {
        NSAssert([dto isKindOfClass:[ShopCartV2DTO class]], @"ShopCartV2DTO type error");
        if ([dto isEqualToProduct:product])
        {
            shopCartItem = dto;
            break;
        }
    }
    return shopCartItem;
}

//当前购物车商品个数
- (NSInteger)allProductQuantity
{
    __block NSInteger totalNumber = 0;
    
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        totalNumber += dto.totalQuantity;

    }];
    
    return totalNumber;
}

//购物车中已有的商品的商品数量
- (NSInteger)quantityOfProduct:(DataProductBasic *)product
{
    ShopCartV2DTO *cartItem = [self cartItemInShopCartOfProduct:product];
    return [cartItem.quantity integerValue];
}

//所有订单行的数量
- (NSInteger)allCartItemQuantity
{
    __block NSInteger totalNumber = 0;
    
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        totalNumber += [self cartItemQuantityOfDTO:dto];
    }];
    
    return totalNumber;
}

//某一dto占订单行数
- (NSInteger)cartItemQuantityOfDTO:(ShopCartV2DTO *)dto
{
    switch (dto.packageType) {
        case PackageTypeNormal:
        {
            return 1;
            break;
        }
        case PackageTypeAccessory:
        {
            return [dto.accessoryPackageList count] + 1;
            break;
        }
        case PackageTypeSmall:
        {
            return [dto.smallPackageList count] + 1;
            break;
        }
        default:
            return 0;
            break;
    }
}

//本地计算购物车的商品总价格
- (double)calculateTotalPrice
{
    __block double price = 0.0L;
    
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isChecked)
        {
            price += dto.totalPrice;
        }
    }];
    
    return price;
}

//是否有苏宁自营的商品
- (BOOL)hasSuningShop
{
    if (self.shopCartList.count > 0)
    {
        ShopCartShopDTO *shop = [self.shopCartList objectAtIndex:0];
        return shop.isSuning;
    }
    return NO;
}

//本地检查是否城市相同
- (BOOL)localCheckIsInSameCity
{
    NSString *city = [self currentDeliveryCity];
    
    __block BOOL isSame = YES;
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isChecked && ![dto.cityCode isEqualToString:city])
        {
            isSame = NO;
            *stop = YES;
        }
    }];
    
    return YES;
}

//是否选中的有苏宁自营的商品
- (BOOL)isSuningChecked
{
    BOOL isChecked = NO;
    ShopCartShopDTO *shop = [self shopDTOInShopCartOfShop:nil];
    for (ShopCartV2DTO *dto in shop.itemList)
    {
        if (dto.isChecked) {
            isChecked = YES;
            break;
        }
    }
    return isChecked;
}

//是否选中的有C店的商品
- (BOOL)isCShopChecked
{
    BOOL isChecked = NO;
    for (ShopCartShopDTO *shop in self.shopCartList)
    {
        if (shop.isSuning) {
            continue;
        }else{
            for (ShopCartV2DTO *dto in shop.itemList)
            {
                if (dto.isChecked) {
                    isChecked = YES;
                    break;
                }
            }
            if (isChecked) {
                break;
            }
        }
    }
    return isChecked;
}

#pragma mark ----------------------------- utils

//判断列表是否是C店订单
+ (BOOL)isCShopOrder:(NSArray *)cartList
{
    BOOL isCOrder = NO;
    for (ShopCartShopDTO *shop in cartList)
    {
        NSAssert([shop isKindOfClass:[ShopCartShopDTO class]], @"ShopCartShopDTO type error");

        for (ShopCartV2DTO *dto in shop.itemList)
        {
            NSAssert([dto isKindOfClass:[ShopCartV2DTO class]], @"ShopCartV2DTO type error");

            if (dto.isChecked) {
                
                if (dto.isCShop)
                {
                    isCOrder = YES;
                }
                else
                {
                    isCOrder = NO;
                }
                break;
            }
        }
    }
    return isCOrder;
}

+ (NSString *)submitType:(NSArray *)cartList
{
    BOOL isCOrder = NO;
    BOOL isSuningOrder = NO;
    for (ShopCartShopDTO *shop in cartList)
    {
        NSAssert([shop isKindOfClass:[ShopCartShopDTO class]], @"ShopCartShopDTO type error");
        
        for (ShopCartV2DTO *dto in shop.itemList)
        {
            NSAssert([dto isKindOfClass:[ShopCartV2DTO class]], @"ShopCartV2DTO type error");
            
            if (dto.isChecked) {
                
                if (dto.isCShop)
                {
                    isCOrder = YES;
                }
                else
                {
                    isSuningOrder = YES;
                }
                if (isSuningOrder && isCOrder) {
                    break;
                }
            }
        }
    }
    if (isCOrder && isSuningOrder) {
        return @"2";
    }
    if (isSuningOrder && !isCOrder) {
        return @"0";
    }
    if (isCOrder && !isSuningOrder) {
        return @"1";
    }
    return @"";
}

//枚举商户
- (void)enumerateShopsUsingBlock:(void (^)(ShopCartShopDTO *shop, BOOL *stop))block
{
    NSArray *shopList = [self.shopCartList copy];
    BOOL stop = NO;
    for (ShopCartShopDTO *shop in shopList)
    {
        NSAssert([shop isKindOfClass:[ShopCartShopDTO class]], @"ShopCartShopDTO type error");
        block(shop, &stop);
        if (stop) {
            break;
        }
    }
}

//枚举订单行
- (void)enumerateCartItemsUsingBlock:(void (^)(ShopCartV2DTO *dto, BOOL *stop))block
{
    [self enumerateShopsUsingBlock:^(ShopCartShopDTO *shop, BOOL *stop) {
        
        BOOL stop1 = NO;
        NSArray *itemList = [shop.itemList copy];
        for (ShopCartV2DTO *dto in itemList)
        {
            NSAssert([dto isKindOfClass:[ShopCartV2DTO class]], @"ShopCartV2DTO type error");
            block(dto, &stop1);
            if (stop1) {
                break;
            }
        }
        
        *stop = stop1;
    }];
}


#pragma mark ----------------------------- event

- (void)addProductToLocalShopCart:(DataProductBasic *)product
{
    [self addProductToLocalShopCart:product isMerge:YES];
}

//添加一个商品,是否合并到已有商品
- (void)addProductToLocalShopCart:(DataProductBasic *)product isMerge:(BOOL)isMerge
{
    //将所有的商品城市改为该城市
    {
        NSString *cityCode = product.cityCode;
        self.cityCode = cityCode;
        //获取cityName
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        self.cityName = [dao getCityNameByCityCode:self.cityCode];
        
        [self changeAllItemsCity:self.cityCode cityName:self.cityName];
    }
    //查看是否有店家
    NSString *shopCode = product.isCShop?product.shopCode:nil;
    ShopCartShopDTO *shop = [self shopDTOInShopCartOfShop:shopCode];
    
//    BOOL isSuningChecked = [self isSuningChecked];
//    BOOL isCShopChecked = [self isCShopChecked];
//    
    //新添的项目
    ShopCartV2DTO *cartItem = nil;
    if (shop)
    {
        if (isMerge)
        {
            cartItem = [self cartItemInShopCartOfProduct:product];
            
            if (cartItem)
            {
                //已经存在
                [cartItem cover:product];
                
                //默认设置为已勾选
                cartItem.isChecked = YES;
            }
            else
            {
                //初始化
                cartItem = [ShopCartV2DTO shopCartV2DTOFromProduct:product];
                
                //插入第一个
                [shop.itemList insertObject:cartItem atIndex:0];
            }
        }
        else
        {
            //初始化
            cartItem = [ShopCartV2DTO shopCartV2DTOFromProduct:product];
            
            //插入第一个
            [shop.itemList insertObject:cartItem atIndex:0];
        }
    }
    else
    {
        if (product.isCShop)
        {
            shop = [ShopCartShopDTO cShopWithShopCode:product.shopCode
                                             shopName:product.shopName];
        }
        else
        {
            shop = [ShopCartShopDTO suningShop];
        }
        
        //初始化
        cartItem = [ShopCartV2DTO shopCartV2DTOFromProduct:product];
        
        //插入第一个
        [shop.itemList insertObject:cartItem atIndex:0];
        
        if (product.isCShop)
        {
            if (self.hasSuningShop)
            {
                [self.shopCartList insertObject:shop atIndex:1];
            }
            else
            {
                [self.shopCartList insertObject:shop atIndex:0];
            }
        }
        else
        {
            [self.shopCartList insertObject:shop atIndex:0];
        }
    }
    cartItem.isChecked = YES;
/*
    //最后设置勾选状态
    if ((isSuningChecked && cartItem.isCShop) ||
        (isCShopChecked && !cartItem.isCShop))
    {
        cartItem.isChecked = NO;
    }
    else
    {
        cartItem.isChecked = YES;
    }
 */
}

//清除已选中的商品
- (void)cleanCheckedCartItems:(NSArray *__autoreleasing *)cleanedItems
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *shopList = [NSArray arrayWithArray:self.shopCartList];
    SuNingSellDao* tempDao = [[SuNingSellDao alloc] init];
    for (ShopCartShopDTO *shop in shopList)
    {
        NSAssert([shop isKindOfClass:[ShopCartShopDTO class]], @"ShopCartShopDTO type error");
        
        NSArray *itemList = [NSArray arrayWithArray:shop.itemList];
        for (ShopCartV2DTO *dto in itemList)
        {
            NSAssert([dto isKindOfClass:[ShopCartV2DTO class]], @"ShopCartV2DTO type error");

            if (dto.isChecked)
            {
     
                [tempDao deleteSuNingSellDAOFromDB:dto.partNumber isSearch:YES];
                [shop.itemList removeObject:dto];
                [array addObject:dto];
            }
            
        }
        
        //如果商品清空了，那么移除该店铺
        if (shop.itemList.count == 0)
        {
            [self.shopCartList removeObject:shop];
        }
    }
    
    if ([array count])
    {
        *cleanedItems = [array copy];
    }
}

//清除编辑状态下以选中的商品
- (void)cleanEditCheckedCartItems:(NSArray *__autoreleasing *)cleanedItems
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *shopList = [NSArray arrayWithArray:self.shopCartList];
    SuNingSellDao* tempDao = [[SuNingSellDao alloc] init];
    for (ShopCartShopDTO *shop in shopList)
    {
        NSAssert([shop isKindOfClass:[ShopCartShopDTO class]], @"ShopCartShopDTO type error");
        
        NSArray *itemList = [NSArray arrayWithArray:shop.itemList];
        for (ShopCartV2DTO *dto in itemList)
        {
            NSAssert([dto isKindOfClass:[ShopCartV2DTO class]], @"ShopCartV2DTO type error");
            
            if (dto.isDeleteItemCheck)
            {
                [tempDao deleteSuNingSellDAOFromDB:dto.partNumber isSearch:YES];
                [shop.itemList removeObject:dto];
                [array addObject:dto];
            }
            
        }
        
        //如果商品清空了，那么移除该店铺
        if (shop.itemList.count == 0)
        {
            [self.shopCartList removeObject:shop];
        }
    }
    
    if ([array count])
    {
        *cleanedItems = [array copy];
    }
}

//改变抢购商品为普通商品
- (void)changeSpecialItemToNormal:(ShopCartV2DTO *)rushItem changedItem:(ShopCartV2DTO *__autoreleasing *)item
{
    //获取商店
    ShopCartShopDTO *shop = [self shopDTOInShopCartOfShop:rushItem.supplierCode];
    
    if (shop)
    {
        NSArray *itemList = [NSArray arrayWithArray:shop.itemList];
        for (ShopCartV2DTO *dto in itemList)
        {
            if ([dto isEqualToItem:rushItem])
            {
                dto.special = ShopCartSpecialNone;
                *item = dto;
                break;
            }
        }
    }
}

//设置为全不选
- (void)unSelectAll
{
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        dto.isChecked = NO;
    }];
}

- (void)unSelectAllWithChangedItems:(NSArray **)items
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isChecked) {
            dto.isChecked = NO;
            [array addObject:dto];
        }
    }];
    
    if ([array count]) {
        *items = [array copy];
    }
}

//全选
- (void)selectAllWithChangedItems:(NSArray *__autoreleasing *)items
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (!dto.recursiveErrorDesc.length)
        {
            if (!dto.isChecked) {
                dto.isChecked = YES;
                [array addObject:dto];
            }
        }
    }];
    
    if ([array count])
    {
        *items = [array copy];
    }
}

//编辑状态下的全选与全不选
- (void)unSelectEditAllWithChangedItems
{
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isDeleteItemCheck) {
            dto.isDeleteItemCheck = NO;
        }
    }];
}

- (void)selectEditAllWithChangedItems
{
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (!dto.recursiveErrorDesc.length)
        {
            if (!dto.isDeleteItemCheck) {
                dto.isDeleteItemCheck = YES;
            }
        }
    }];
}
//当前是否全部选择
- (BOOL)isAllSelected
{
    __block BOOL isAllChecked = YES;
    __block int rCheckedCount = 0;

    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isChecked)
        {
            rCheckedCount ++;
        }
        else
        {
            if (!dto.isCanntCheck)
            {
                isAllChecked = NO;
                *stop = YES;
            }
            /*
             大聚惠商品有errorDesc且可以购买时，下面的判断有问题
             */
//            if (dto.errorDesc.length == 0 && !dto.isCanntCheck)
//            {
//                isAllChecked = NO;
//                *stop = YES;
//            }
        }
    }];
    
    return (rCheckedCount > 0 && isAllChecked);
}

//是否编辑状态下的商品都已全选
- (BOOL)isEditAllSelect
{
    __block BOOL isAllChecked = YES;
    __block int rCheckedCount = 0;
    
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        if (dto.isDeleteItemCheck)
        {
            rCheckedCount ++;
        }
        else
        {
            if (!dto.isCanntCheck)
            {
                isAllChecked = NO;
                *stop = YES;
            }
            /*
             大聚惠商品有errorDesc且可以购买时，下面的判断有问题
             */
//            if (dto.errorDesc.length == 0 && !dto.isCanntCheck)
//            {
//                isAllChecked = NO;
//                *stop = YES;
//            }
        }
    }];
    
    return (rCheckedCount > 0 && isAllChecked);
}

//更改已勾选商品的城市
- (void)changeAllItemsCity:(NSString *)cityCode cityName:(NSString *)cityName
{
    [self enumerateCartItemsUsingBlock:^(ShopCartV2DTO *dto, BOOL *stop) {
        
        [dto changeCity:cityCode cityName:cityName];
    }];
    
    self.cityCode = cityCode; self.cityName = cityName;
}

- (NSArray *)cleanItemsWillDelete
{
    NSMutableArray *cleanedItems = [[NSMutableArray alloc] init];
    [self enumerateShopsUsingBlock:^(ShopCartShopDTO *shop, BOOL *stop) {
        
        NSArray *tempList = [shop.itemList copy];
        int i = 0;
        for (ShopCartV2DTO *item in tempList)
        {
            if (item.isDeleteItemCheck)
            {
                [cleanedItems addObject:item];
                [shop.itemList removeObject:item];
                
                if (shop.itemList.count == 0)
                {
                    [self.shopCartList removeObject:shop];
                }
            }
            else if (item.packageType == PackageTypeAccessory)
            {
                NSArray *accessoyList = [item.accessoryPackageList copy];
                for (ShopCartV2DTO *innerItem in accessoyList)
                {
                    if (innerItem.isDeleteItemCheck)
                    {
                        [cleanedItems addObject:innerItem];
                        [item.accessoryPackageList removeObject:innerItem];
                    }
                }
                
                //如果配件套餐配件删除完了，就变为普通商品
                if (item.accessoryPackageList.count == 0)
                {
                    item.accessoryPackageList = nil;
                    item.packageType = PackageTypeNormal;
                }
            }
            else if (item.packageType == PackageTypeSmall)
            {
                //小套餐移除一件，其余变普通
                NSMutableArray *matchedItems = [NSMutableArray array];
                
                NSArray *smallList = [NSArray arrayWithArray:item.smallPackageList];
                
                for (ShopCartV2DTO *innerItem in smallList)
                {
                    if (innerItem.isDeleteItemCheck)
                    {
                        [matchedItems addObject:innerItem];
                        [cleanedItems addObject:innerItem];
                    }
                }
                
                if (matchedItems.count)
                {
                    NSMutableArray *mSmallList = [NSMutableArray arrayWithArray:item.smallPackageList];
                    [mSmallList removeObjectsInArray:matchedItems];
                    
                    [shop.itemList removeObject:item];
                    
                    if (mSmallList.count) {
                        for (ShopCartV2DTO *otherItem in mSmallList)
                        {
                            otherItem.packageType = PackageTypeNormal;
                            otherItem.isInnerProduct = NO;
                        }
                        [shop.itemList insertObjects:mSmallList atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(i, [mSmallList count])]];
                    }
                }
                
            }
            i++;
        }
    }];
    
    return [cleanedItems count]?cleanedItems:nil;
}

//删除某一商品
- (void)deleteItem:(ShopCartV2DTO *)cartItem
{
    [self enumerateShopsUsingBlock:^(ShopCartShopDTO *shop, BOOL *stop) {
        
        NSArray *tempList = [shop.itemList copy];
        int i = 0;
        for (ShopCartV2DTO *item in tempList)
        {
            if (item == cartItem)
            {
                [shop.itemList removeObject:item];
                *stop = YES;
                
                if (shop.itemList.count == 0)
                {
                    [self.shopCartList removeObject:shop];
                }
                
                break;
            }
            else if (item.packageType == PackageTypeAccessory)
            {
                BOOL matched = NO;
                NSArray *accessoyList = [item.accessoryPackageList copy];
                for (ShopCartV2DTO *innerItem in accessoyList)
                {
                    if (innerItem == cartItem)
                    {
                        [item.accessoryPackageList removeObject:innerItem];
                        matched = YES;
                        break;
                    }
                }
                
                //如果配件套餐配件删除完了，就变为普通商品
                if (item.accessoryPackageList.count == 0)
                {
                    item.accessoryPackageList = nil;
                    item.packageType = PackageTypeNormal;
                }
                
                if (matched) {
                    *stop = YES;
                    break;
                }
            }
            else if (item.packageType == PackageTypeSmall)
            {
                //小套餐移除一件，其余变普通
                ShopCartV2DTO *matchedItem = nil;
                
                NSArray *smallList = [NSArray arrayWithArray:item.smallPackageList];
                
                for (ShopCartV2DTO *innerItem in smallList)
                {
                    if (innerItem == cartItem)
                    {
                        matchedItem = innerItem;
                        break;
                    }
                }
                
                if (matchedItem)
                {
                    NSMutableArray *mSmallList = [NSMutableArray arrayWithArray:item.smallPackageList];
                    [mSmallList removeObject:matchedItem];
                    
                    for (ShopCartV2DTO *otherItem in mSmallList)
                    {
                        otherItem.packageType = PackageTypeNormal;
                        otherItem.isInnerProduct = NO;
                    }
                    
                    [shop.itemList removeObject:item];
                    [shop.itemList insertObjects:mSmallList atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(i, [mSmallList count])]];
                    *stop = YES;
                    break;
                }
                
            }
            i++;
        }
    }];
}

#pragma mark ----------------------------- coding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSData *listData = [NSKeyedArchiver archivedDataWithRootObject:self.shopCartList];
    [aCoder encodeObject:listData forKey:@"shopCartList"];
    
    [aCoder encodeObject:self.productAllPrice forKey:@"productAllPrice"];
    [aCoder encodeObject:self.userPayAllPrice forKey:@"userPayAllPrice"];
    [aCoder encodeObject:self.sunpgkPrice forKey:@"sunpgkPrice"];
    [aCoder encodeObject:self.totalDiscount forKey:@"totalDiscount"];
    [aCoder encodeObject:self.promotionDesc forKey:@"promotionDesc"];
    [aCoder encodeObject:@(self.inSameCity) forKey:@"inSameCity"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        
        NSData *listData = [coder decodeObjectForKey:@"shopCartList"];
        self.shopCartList = [NSKeyedUnarchiver unarchiveObjectWithData:listData];
        
        self.productAllPrice = [coder decodeObjectForKey:@"productAllPrice"];
        self.userPayAllPrice = [coder decodeObjectForKey:@"userPayAllPrice"];
        self.sunpgkPrice = [coder decodeObjectForKey:@"sunpgkPrice"];
        self.totalDiscount = [coder decodeObjectForKey:@"totalDiscount"];
        self.promotionDesc = [coder decodeObjectForKey:@"promotionDesc"];
        self.inSameCity = [[coder decodeObjectForKey:@"inSameCity"] boolValue];

    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    
    ShopCartLogic *dto = [[[self class] allocWithZone:zone] init];
    
    dto->_shopCartList = [self.shopCartList trueDeepMutableCopy];
    dto->_productAllPrice = [self.productAllPrice copy];
    dto->_userPayAllPrice = [self.userPayAllPrice copy];
    dto->_sunpgkPrice = [self.sunpgkPrice copy];
    dto->_totalDiscount = [self.totalDiscount copy];
    dto->_promotionDesc = [self.promotionDesc copy];
    dto->_inSameCity = self.inSameCity;

    return dto;
}

#pragma mark ----------------------------- cache methods

+ (instancetype)cachedLogic
{
    NSString *cahceName = [self cacheName];
    NSData *data = [[SNFileCache defaultCache] dataForKey:cahceName];
    if (!data) {
        return nil;
    }
    ShopCartLogic *logic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if ([logic isKindOfClass:[ShopCartLogic class]])
    {
        return logic;
    }
    else
    {
        return nil;
    }
}

+ (instancetype)emptyLogic
{
    ShopCartLogic *logic = [[ShopCartLogic alloc] init];
    return logic;
}

+ (NSString *)cacheName
{
   return @"sn.shopCartLogic";
}

- (void)saveToCache
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [[SNFileCache defaultCache] saveData:data
                                    forKey:[ShopCartLogic cacheName]
                                  cacheAge:kSNCacheAgeForever];
}

+ (void)removeCache //在登录后，合并完成后，清除未登录的购物车。
{
    [[SNFileCache defaultCache] removeDataForKey:[ShopCartLogic cacheName]];
}

- (NSArray *)identifierArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (ShopCartShopDTO *dto in self.shopCartList)
    {
        [array addObjectsFromArray:dto.identifierArray];
    }
    return array;
}

- (BOOL)isMatchedIn:(ShopCartLogic *)antherLogic
{
    NSArray *itemArr = [antherLogic identifierArray];
    NSMutableDictionary *map = [[NSMutableDictionary alloc] init];
    for (NSString *identifier in itemArr)
    {
        [map setObject:@(YES) forKey:identifier];
    }
    
    BOOL matched1 = YES;
    BOOL matched2 = YES;
    
    NSArray *identifierArrayOther = [self identifierArray];
    NSMutableDictionary *map2 = [[NSMutableDictionary alloc] init];
    for (NSString *identifier in identifierArrayOther)
    {
        [map2 setObject:@(YES) forKey:identifier];
        if ([[map objectForKey:identifier] boolValue])
        {
            continue;
        }
        else
        {
            matched1 = NO;
        }
    }
    
    for (NSString *identifier in itemArr)
    {
        if ([[map2 objectForKey:identifier] boolValue])
        {
            continue;
        }
        else
        {
            matched2 = NO;
            break;
        }
    }
    
    return matched1||matched2;
}

@end
