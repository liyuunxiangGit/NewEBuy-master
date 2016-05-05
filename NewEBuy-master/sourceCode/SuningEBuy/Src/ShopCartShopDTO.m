//
//  ShopCartShopDTO.m
//  SuningEBuy
//
//  Created by  liukun on 13-10-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopCartShopDTO.h"

@implementation ShopCartShopDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.shopCode       = EncodeStringFromDic(dic, @"supplierCode");
    self.shopName       = EncodeStringFromDic(dic, @"cShopName");
    self.shipPrice      = EncodeNumberFromDic(dic, @"shipPrice");
    self.totalShipPrice = EncodeNumberFromDic(dic, @"totalShipPrice");
    self.itemList       = (NSMutableArray *)EncodeArrayFromDicUsingParseBlock(dic, @"itemList", ^id(NSDictionary *innerDic) {
        
        ShopCartV2DTO *dto = [[ShopCartV2DTO alloc] init];
        [dto encodeFromDictionary:innerDic];
        return dto;
    });
}

- (void)encodeForExceptionListFromDic:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.shopCode = EncodeStringFromDic(dic, @"supplierCode");
    self.shopName = EncodeStringFromDic(dic, @"cShopName");
    self.shipPrice = EncodeNumberFromDic(dic, @"shipPrice");
    
    self.itemList = (NSMutableArray *)EncodeArrayFromDicUsingParseBlock(dic, @"itemList", ^id(NSDictionary *innerDic) {
        
        ShopCartV2DTO *dto = [[ShopCartV2DTO alloc] init];
        [dto encodeFromDictionary:innerDic];
        return dto;
    });
}

- (BOOL)isSuning
{
    return !self.shopCode.length;
}

+ (instancetype)suningShop
{
    ShopCartShopDTO *shop = [[ShopCartShopDTO alloc] init];
    shop.shopCode = nil;
    shop.shopName = L(@"MyEBuy_SuningSelf");
    shop.itemList = [NSMutableArray array];
    return shop;
}

+ (instancetype)cShopWithShopCode:(NSString *)shopCode
                         shopName:(NSString *)shopName
{
    ShopCartShopDTO *shop = [[ShopCartShopDTO alloc] init];
    shop.shopCode = shopCode;
    shop.shopName = shopName;
    shop.itemList = [NSMutableArray array];
    return shop;
}

- (BOOL)isAllSelect
{
    BOOL isAllSelect = YES;
    
    int rCheckedCount = 0;
    for (ShopCartV2DTO *dto in self.itemList)
    {
        if (dto.isChecked)
        {
            rCheckedCount ++;
        }
        else
        {
            
            if (!dto.isCanntCheck)
            {
                isAllSelect = NO;
                break;
            }
            //大聚惠商品在下面判断条件下会有问题
//            if (dto.recursiveErrorDesc.length == 0 && !dto.isCanntCheck)
//            {
//                isAllSelect = NO;
//                break;
//            }
        }
    }
    return (rCheckedCount > 0 && isAllSelect);
}

- (BOOL)isEditAllSelect
{
    BOOL isAllSelect = YES;
    
    int rCheckedCount = 0;
    for (ShopCartV2DTO *dto in self.itemList)
    {
        if (dto.isDeleteItemCheck)
        {
            rCheckedCount ++;
        }
        else
        {
            if (!dto.isCanntCheck)
            {
                isAllSelect = NO;
                break;
            }
            //大聚惠商品在下面判断条件下会有问题
//            if (dto.errorDesc.length == 0 && !dto.isCanntCheck)
//            {
//                isAllSelect = NO;
//                break;
//            }
        }
    }
    return (rCheckedCount > 0 && isAllSelect);
}

//设置为全不选
- (void)unSelectAll
{
    for (ShopCartV2DTO *dto in self.itemList)
    {
        dto.isChecked = NO;
    }
}

- (void)unSelectAllWithChangedItems:(NSArray **)items
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (ShopCartV2DTO *dto in self.itemList)
    {
        if (dto.isChecked) {
            dto.isChecked = NO;
            [array addObject:dto];
        }
    }
    
    if ([array count]) {
        *items = [array copy];
    }
}

//全选
- (void)selectAllWithChangedItems:(NSArray *__autoreleasing *)items
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (ShopCartV2DTO *dto in self.itemList){
        
        if (!dto.recursiveErrorDesc.length)
        {
            if (!dto.isChecked) {
                dto.isChecked = YES;
                [array addObject:dto];
            }
        }
    }

    if ([array count])
    {
        *items = [array copy];
    }
}

- (void)unSelectEditAllWithChangedItems
{
    for (ShopCartV2DTO *dto in self.itemList)
    {
        if (dto.isDeleteItemCheck) {
            dto.isDeleteItemCheck = NO;
        }
    }

}

- (void)selectEditAllWithChangedItems
{
    for (ShopCartV2DTO *dto in self.itemList){
        
        if (!dto.recursiveErrorDesc.length)
        {
            if (!dto.isDeleteItemCheck) {
                dto.isDeleteItemCheck = YES;
            }
        }
    }
}

- (BOOL)isEditing
{
    BOOL isEdit = NO;
    //必须所有的商品都再编辑
    for (ShopCartV2DTO *item in self.itemList)
    {
        if (item.hasInEditing) {
            isEdit = YES;
            break;
        }
    }
    return isEdit;
}

- (void)setEditing:(BOOL)editing
{
    for (ShopCartV2DTO *item in self.itemList)
    {
        [item setAllInEditing:editing];
    }
}

#pragma mark ----------------------------- coding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.shopCode forKey:@"shopCode"];
    [aCoder encodeObject:self.shopName forKey:@"shopName"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.itemList];
    [aCoder encodeObject:data forKey:@"itemList"];
}


- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.shopCode = [coder decodeObjectForKey:@"shopCode"];
        self.shopName = [coder decodeObjectForKey:@"shopName"];
        NSData *data = [coder decodeObjectForKey:@"itemList"];
        self.itemList = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    
    ShopCartShopDTO *dto = [[[self class] allocWithZone:zone] init];
    
    dto->_shopCode = [self.shopCode copy];
    dto->_shopName = [self.shopName copy];
    dto->_itemList = [self.itemList trueDeepMutableCopy];
    
    return dto;
}

- (NSArray *)identifierArray
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:self.itemList.count];
    for (ShopCartV2DTO *dto in self.itemList)
    {
        [array addObjectsFromArray:dto.identifierArray];
    }
    return array;
}
@end
