//
//  ShopCartV2DTO.m
//  SuningEBuy
//
//  Created by  liukun on 13-5-6.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopCartV2DTO.h"

@implementation ShopCartV2DTO

@synthesize editing = _editing;

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    
    self.orderItemId = EncodeStringFromDic(dic, @"orderItemId");
    self.catentryId = EncodeStringFromDic(dic, @"catentryId");
    self.partNumber = EncodeStringFromDic(dic, @"partNumber");
    self.productName = EncodeStringFromDic(dic, @"productName");
    self.itemPrice = EncodeNumberFromDic(dic, @"itemPrice");
    self.quantity = EncodeStringFromDic(dic, @"quantity");
    self.cityCode = EncodeStringFromDic(dic, @"cityId");
    self.cityName = EncodeStringFromDic(dic, @"cityName");
    
    self.editQuantity = self.quantity;
    
    NSString *packageTypeStr = EncodeStringFromDic(dic, @"packageType");
    if ([packageTypeStr isEqualToString:@"NORMALPRODUCT"]) {
        self.packageType = PackageTypeNormal;
    }else if ([packageTypeStr isEqualToString:@"SMALLPACKAGE"]){
        self.packageType = PackageTypeSmall;
    }else if ([packageTypeStr isEqualToString:@"ACCESSORYPACKAGE"]){
        self.packageType = PackageTypeAccessory;
    }else if ([packageTypeStr isEqualToString:@"XNPACKAGE"]){
        self.packageType = PackageTypeXn;
    }

    NSString *powerFlagStr = EncodeStringFromDic(dic, @"powerFlag");
    self.powerFlag = [powerFlagStr isEqualToString:@"true"]?YES:NO;
    
    self.errorDesc = EncodeStringFromDic(dic, @"errorDesc");
    
    NSString *canTakeStr = EncodeStringFromDic(dic, @"canTake");
    self.canTake = [canTakeStr isEqualToString:@"Y"]?YES:NO;
    
    self.special = EncodeStringFromDic(dic, @"special").integerValue;
    
    //isChecked : 0,未勾选；1,已勾选；2:不支持勾选
    NSString *isCheck = EncodeStringFromDic(dic, @"isChecked");
    if ([isCheck isEqualToString:@"1"]) {
        self.isChecked = YES;
    }else{
        self.isChecked = NO;
        
        if ([isCheck isEqualToString:@"2"] && self.errorDesc.trim.length == 0)
        {
            self.errorDesc = L(@"SCGoodsNotSell");
        }
    }
    
    //isCanntCheck : 1,不能被勾选；0或其他，能勾选
    NSString *isCanntCheck = EncodeStringFromDic(dic, @"isCanntCheck");
    if ([isCanntCheck isEqualToString:@"1"]) {
        self.isCanntCheck = YES;
    }
    else
    {
        self.isCanntCheck = NO;
    }
    
    
    self.saleOrg = EncodeStringFromDic(dic, @"saleOrg");
    
    self.juhuiActiveId = EncodeStringFromDic(dic, @"actId");
    self.limitCount = EncodeStringFromDic(dic, @"actCount");
    self.groupCheckMsg = EncodeStringFromDic(dic, @"groupCheckMsg");
    
    /**
     *  如果errorDesc为空，则显示大聚会信息，原本的errorDesc优先级较高
     *  @author liukun
     *  @since 2.4.2
     */
    /**
     *  大聚会在购物车不展示提示信息
     *  @author kongbin
     *  @since 2.5.1
     */
    /*
     if (!self.errorDesc.length) {
     
     if ([self.groupCheckMsg isEqualToString:@"1"] || [self.groupCheckMsg isEqualToString:@"4"])
     {
     if (self.limitCount.length) {
     self.errorDesc = [NSString stringWithFormat:@"%@%@%@", L(@"SCToBuyUp"),self.limitCount,L(@"Piece")];
     }
     } else if ([self.groupCheckMsg isEqualToString:@"3"]) {
     
     if (self.limitCount.length) {
     self.errorDesc = [NSString stringWithFormat:@"%@%@%@", L(@"SCBigGatherSaleLeft"),self.limitCount,L(@"Piece")];
     }
     } else if (self.special == ShopCartSpecialMarketEnd) {
     
     self.errorDesc = L(@"SCBigGatherSaleOver");
     } else {
     
     if (self.limitCount.length) {
     self.errorDesc = [NSString stringWithFormat:@"%@%@%@", L(@"SCToBuyUp"),self.limitCount,L(@"Piece")];
     }
     }
     
     }
     */
    
    NSArray *accessoryList = EncodeArrayFromDic(dic, @"accessoryList");
    if ([accessoryList count] > 0)
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[accessoryList count]];
        for (NSDictionary *item in accessoryList)
        {
            ShopCartV2DTO *dto = [[ShopCartV2DTO alloc] init];
            [dto encodeFromDictionary:item];
            dto.packageType = PackageTypeAccessory;
            dto.isInnerProduct = YES;
            dto.massocceceId = EncodeStringFromDic(item, @"massocceceId");
            [array addObject:dto];
        }
        self.accessoryPackageList = array;
    }
    
    NSArray *smallList = EncodeArrayFromDic(dic, @"smallPackageList");
    if ([smallList count] > 0)
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[accessoryList count]];
        for (NSDictionary *item in smallList)
        {
            ShopCartV2DTO *dto = [[ShopCartV2DTO alloc] init];
            [dto encodeFromDictionary:item];
            dto.packageType = PackageTypeSmall;
            dto.isInnerProduct = YES;
            [array addObject:dto];
        }
        self.smallPackageList = array;
    }
    
    NSArray *xnList = EncodeArrayFromDic(dic, @"xnPackageList");
    if ([xnList count] > 0)
    {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:[accessoryList count]];
        for (NSDictionary *item in xnList)
        {
            ShopCartV2DTO *dto = [[ShopCartV2DTO alloc] init];
            [dto encodeFromDictionary:item];
            dto.packageType = PackageTypeXn;
            dto.isInnerProduct = YES;
            [array addObject:dto];
        }
        self.xnPackageList = array;
    }
    
    self.supplierCode = EncodeStringFromDic(dic, @"supplierCode");
}

+ (ShopCartV2DTO *)shopCartV2DTOFromProduct:(DataProductBasic *)product
{
    if (product == nil || ![product isKindOfClass:[DataProductBasic class]]) {
        return nil;
    }
    
    ShopCartV2DTO *dto = [[ShopCartV2DTO alloc] init];
    
    dto.catentryId = product.productId;
    dto.partNumber = product.productCode;
    dto.productName = product.productName;
    dto.itemPrice = product.suningPrice;
    //数量为1
    if (product.quantity < 1) {
        product.quantity = 1;
    }
    dto.quantity = [NSString stringWithFormat:@"%d",product.quantity];//product.quantity;
    dto.editQuantity = dto.quantity;
    dto.cityCode = product.cityCode;
    dto.powerFlag = [product.powerFlgOrAmt isEqualToString:@"true"];
    dto.canTake = [product.canTake isEqualToString:@"Y"];
    dto.saleOrg = product.saleOrg;
    
    //是否是抢购
    if (product.quickbuyId.trim.length > 0) {
        dto.special = ShopCartSpecialRush;
        dto.itemPrice = product.qianggouPrice;
    }
    else
    //是否是单价团 xiewei
    if (product.danjiaGroupId.trim.length > 0) {
        dto.special = ShopCartSpecialSimpleGroup;
        dto.itemPrice = product.qianggouPrice;
    }
    //大聚会价格
    if (product.isJuhui) {
        //FIXME:242
        dto.special = ShopCartSpecialMarket;
        dto.itemPrice = product.juhuiPrice;
        dto.juhuiActiveId = product.activityId;
    }
    
    //默认已勾选
    dto.isChecked = YES;
    dto.saleOrg = product.saleOrg;
    
    //配件套餐
    //因为iPhone客户端只展示一个列表，所以取合并后的配件套餐列表
    NSArray *accessoryList = product.allAccessoryProductList;
    if (product.packageType == PackageTypeAccessory && [accessoryList count] > 0)
    {
        NSMutableArray *array = [NSMutableArray array];
        for (DataProductBasic *innerProduct in accessoryList)
        {
            //被选中
            if (innerProduct.isAccessorySelect)
            {
                ShopCartV2DTO *pro = [ShopCartV2DTO shopCartV2DTOFromProduct:innerProduct];
                pro.packageType = PackageTypeAccessory;
                pro.massocceceId = innerProduct.masocceceId;
                pro.isInnerProduct = YES;
                [array addObject:pro];
            }
        }
        
        if ([array count] > 0)
        {
            dto.packageType = PackageTypeAccessory;
            dto.accessoryPackageList = array;
        }
    }
    
    //小套餐
    if (product.packageType == PackageTypeSmall)
    {
        NSMutableArray *smallList = [NSMutableArray array];
        for (DataProductBasic *innerProduct in product.smallPackageList)
        {
            ShopCartV2DTO *pro = [ShopCartV2DTO shopCartV2DTOFromProduct:innerProduct];
            pro.packageType = PackageTypeSmall;
            pro.isInnerProduct = YES;
            [smallList addObject:pro];
        }
        
        if ([smallList count] > 0)
        {
            dto.packageType = PackageTypeSmall;
            dto.smallPackageList = smallList;
        }
    }
    
    //x元n件
    if (product.packageType == PackageTypeXn)
    {
        //暂不支持
    }
    
    dto.supplierCode = product.shopCode;
    
    return dto;
}

- (BOOL)isEqualToItem:(ShopCartV2DTO *)item
{
    //比较店家
    if ([self.supplierCode isEqualToString:item.supplierCode] ||
        (!self.supplierCode.length&&!item.supplierCode.length))
    {
        
    }
    else
    {
        return NO;
    }
    
    //比较商品id
    if (![self.catentryId isEqualToString:item.catentryId])
    {
        return NO;
    }
    //比较城市
    if (![self.cityCode isEqualToString:item.cityCode])
    {
        return NO;
    }
    
    //比较是否是同样的类型商品
    if (self.special != item.special)
    {
        return NO;
    }
    
    //比较套餐类型
    if (self.packageType != item.packageType)
    {
        return NO;
    }
    
    //配件套餐
    if (self.packageType == PackageTypeAccessory)
    {
        NSArray *accArr1 = [NSArray arrayWithArray:self.accessoryPackageList];
        NSArray *accArr2 = [NSArray arrayWithArray:item.accessoryPackageList];
        if ([accArr1 count] != [accArr2 count])
        {
            return NO;
        }
        for (int i = 0; i < [accArr1 count]; i++)
        {
            ShopCartV2DTO *dto1 = [accArr1 objectAtIndex:i];
            ShopCartV2DTO *dto2 = [accArr2 objectAtIndex:i];
            if (![dto1.catentryId isEqualToString:dto2.catentryId])
            {
                return NO;
            }
        }
    }
    
    return YES;
}

//与商品详情DTO比较
- (BOOL)isEqualToProduct:(DataProductBasic *)product
{
    //比较店家
    if (product.isCShop)
    {
        if (![self.supplierCode isEqualToString:product.shopCode])
        {
            return NO;
        }
    }
    else
    {
        if (self.supplierCode.length)
        {
            return NO;
        }
    }
    
    //比较商品id
    if (![self.catentryId isEqualToString:product.productId])
    {
        return NO;
    }
    //比较城市
    if (![self.cityCode isEqualToString:product.cityCode])
    {
        return NO;
    }
    
    //比较是否是同样的类型商品
    //是否是抢购或单价团
    ShopCartSpecial speType = ShopCartSpecialNone;
    if (product.quickbuyId.trim.length > 0) {
        speType = ShopCartSpecialRush;
    }else if (product.danjiaGroupId.trim.length > 0) {
        speType = ShopCartSpecialSimpleGroup;
    }else if(product.isJuhui){
        //FIXME:242
        speType = ShopCartSpecialMarket;
    }
    
    if(self.special == ShopCartSpecialZhiJiang && speType == ShopCartSpecialNone)
    {
        //当购物车中商品为直降商品时，再加入的普通商品认为是相同的
    }
    else if (self.special != speType)
    {
        return NO;
    }
    
    //比较套餐类型
    PackageType packType = PackageTypeNormal;
    NSArray *accessoryList = product.allAccessoryProductList;
    if (product.packageType == PackageTypeAccessory)
    {
        for (DataProductBasic *innerProduct in accessoryList)
        {
            //被选中
            if (innerProduct.isAccessorySelect)
            {
                packType = PackageTypeAccessory;
                break;
            }
        }
    }else{
        packType = product.packageType;
    }
    if (packType != self.packageType)
    {
        return NO;
    }
    
    //配件套餐
    if (self.packageType == PackageTypeAccessory)
    {
        NSArray *accArr1 = [NSArray arrayWithArray:self.accessoryPackageList];
        NSArray *accArr2 = [NSArray arrayWithArray:product.selectedAccessoryList];
        if ([accArr1 count] != [accArr2 count])
        {
            return NO;
        }
        for (int i = 0; i < [accArr1 count]; i++)
        {
            ShopCartV2DTO *dto1 = [accArr1 objectAtIndex:i];
            DataProductBasic *dto2 = [accArr2 objectAtIndex:i];
            NSAssert([dto1 isKindOfClass:[ShopCartV2DTO class]], @"ShopCartV2DTO type error");
            NSAssert([dto2 isKindOfClass:[DataProductBasic class]], @"DataProductBasic type error");
            if (![dto1.catentryId isEqualToString:dto2.productId])
            {
                return NO;
            }
        }
    }
    
    return YES;
}

- (void)increaseQuantity:(int)count
{
    int currentCount = [self.quantity intValue];
    self.quantity = STR_FROM_INT(currentCount+count);
    self.editQuantity = self.quantity;
    //如果是套餐商品，商品内的每个商品+1
    if (self.packageType == PackageTypeAccessory)
    {
        for (ShopCartV2DTO *innerProduct in self.accessoryPackageList)
        {
            int currentInnerQuantity = [innerProduct.quantity intValue];
            if (currentInnerQuantity >= 99) {
                continue;
            }
            innerProduct.quantity = STR_FROM_INT(currentInnerQuantity+count);
            innerProduct.editQuantity = innerProduct.quantity;
        }
    }
    //小套餐内商品数量等于虚拟主商品数量
    else if (self.packageType == PackageTypeSmall)
    {
        for (ShopCartV2DTO *innerProduct in self.smallPackageList)
        {
            innerProduct.quantity = self.quantity;
            innerProduct.editQuantity = innerProduct.quantity;
        }
    }
}
- (void)cover:(DataProductBasic *)product
{
//    int currentCount = [self.quantity intValue];
    self.quantity = STR_FROM_INT(product.quantity);
    self.editQuantity = self.quantity;
    //如果是套餐商品，商品内的每个商品+1
    if (self.packageType == PackageTypeAccessory)
    {
        for (ShopCartV2DTO *innerProduct in self.accessoryPackageList)
        {
            int currentInnerQuantity = [innerProduct.quantity intValue];
            if (currentInnerQuantity >= 99) {
                continue;
            }
            DataProductBasic *package = [product.allAccessoryProductList objectAtIndex:0];
            innerProduct.quantity = STR_FROM_INT(package.quantity);
            innerProduct.editQuantity = innerProduct.quantity;
        }
    }
    //小套餐内商品数量等于虚拟主商品数量
    else if (self.packageType == PackageTypeSmall)
    {
        for (ShopCartV2DTO *innerProduct in self.smallPackageList)
        {
            innerProduct.quantity = self.quantity;
            innerProduct.editQuantity = innerProduct.quantity;
        }
    }
}

- (void)mergeFrom:(ShopCartV2DTO *)item
{
    if ([self isEqualToItem:item])
    {
        //合并主商品数量
        int addCount = [item.quantity intValue];
        self.quantity = STR_FROM_INT([self.quantity intValue]+addCount);
        self.editQuantity = self.quantity;
        //套餐商品
        if (self.packageType == PackageTypeAccessory)
        {
            for (int i = 0; i < [self.accessoryPackageList count]; i++)
            {
                ShopCartV2DTO *innerPro1 = [self.accessoryPackageList objectAtIndex:i];
                ShopCartV2DTO *innerPro2 = [item.accessoryPackageList objectAtIndex:i];
                addCount = [innerPro2.quantity intValue];
                innerPro1.quantity = STR_FROM_INT([innerPro1.quantity intValue]+addCount);
                innerPro1.editQuantity = innerPro1.quantity;
            }
        }
        else if (self.packageType == PackageTypeSmall)
        {
            for (ShopCartV2DTO *innerProduct in self.smallPackageList)
            {
                innerProduct.quantity = self.quantity;
                innerProduct.editQuantity = innerProduct.quantity;
            }
        }
    }
}

//总数量
- (NSInteger)totalQuantity
{
    NSInteger count = 0;
    
    count += [self.quantity integerValue];
    
    //只有配件套餐的套餐商品才计算数量,小套餐不计算数量,数量与勾选状态无关
    if (self.packageType == PackageTypeAccessory)
    {
        for (ShopCartV2DTO *innerProduct in self.accessoryPackageList)
        {
            count += [innerProduct.quantity integerValue];
        }
    }
    
    return count;
}

//总价格
- (double)totalPrice
{
    double price = 0.0L;
    
    price += [self.itemPrice doubleValue]*[self.quantity integerValue];
    
    if (self.packageType == PackageTypeAccessory)
    {
        for (ShopCartV2DTO *innerProduct in self.accessoryPackageList)
        {
            price += [innerProduct.itemPrice doubleValue]*[innerProduct.quantity integerValue];
        }
    }
    
    return price;
}

//是否是C店
- (BOOL)isCShop
{
    return self.supplierCode.length>0?YES:NO;
}

//改变城市
- (void)changeCity:(NSString *)cityCode cityName:(NSString *)cityName
{
    if (![self.cityCode isEqualToString:cityCode]) {
        self.saleOrg = nil;
    }
    self.cityCode = cityCode;
    self.cityName = cityName;
    
    if (self.packageType == PackageTypeAccessory)
    {
        for (ShopCartV2DTO *item in self.accessoryPackageList)
        {
            if (![item.cityCode isEqualToString:cityCode]) {
                item.saleOrg = nil;
            }
            item.cityCode = cityCode;
            item.cityName = cityName;
        }
    }
    else if (self.packageType == PackageTypeSmall)
    {
        for (ShopCartV2DTO *item in self.smallPackageList)
        {
            if (![item.cityCode isEqualToString:cityCode]) {
                item.saleOrg = nil;
            }
            item.cityCode = cityCode;
            item.cityName = cityName;
        }
    }
    else if (self.packageType == PackageTypeXn)
    {
        for (ShopCartV2DTO *item in self.xnPackageList)
        {
            if (![item.cityCode isEqualToString:cityCode]) {
                item.saleOrg = nil;
            }
            item.cityCode = cityCode;
            item.cityName = cityName;
        }
    }
}

- (void)setAllInEditing:(BOOL)editing
{
    self.editing = editing;
    if (self.packageType == PackageTypeAccessory)
    {
        for (ShopCartV2DTO *subItem in self.accessoryPackageList)
        {
            subItem.editing = editing;
        }
    }
    else if (self.packageType == PackageTypeSmall)
    {
        for (ShopCartV2DTO *subItem in self.smallPackageList)
        {
            subItem.editing = editing;
        }
    }
}

//是否全部在编辑状态
- (BOOL)isAllInEditing
{
    BOOL isEdit = self.editing;
    
    if (isEdit)
    {
        if (self.packageType == PackageTypeAccessory)
        {
            for (ShopCartV2DTO *subItem in self.accessoryPackageList)
            {
                if (!subItem.editing) {
                    isEdit = NO;
                    break;
                }
            }
        }
        else if (self.packageType == PackageTypeSmall)
        {
            for (ShopCartV2DTO *subItem in self.smallPackageList)
            {
                if (!subItem.editing) {
                    isEdit = NO;
                    break;
                }
            }
        }
    }
    
    return isEdit;
}

- (BOOL)hasInEditing
{
    BOOL isEdit = self.editing;
    
    if (!isEdit)
    {
        if (self.packageType == PackageTypeAccessory)
        {
            for (ShopCartV2DTO *subItem in self.accessoryPackageList)
            {
                if (subItem.editing) {
                    isEdit = YES;
                    break;
                }
            }
        }
        else if (self.packageType == PackageTypeSmall)
        {
            for (ShopCartV2DTO *subItem in self.smallPackageList)
            {
                if (subItem.editing) {
                    isEdit = YES;
                    break;
                }
            }
        }
    }
    
    return isEdit;
}

//是否可以更改数量
- (BOOL)canModifyQuantity
{
    //抢购商品、小套餐内商品、暂停销售、无货、下架等商品不可以改数量
    if (self.special == ShopCartSpecialRush ||
        (self.packageType == PackageTypeSmall && self.isInnerProduct) ||
        
        (self.errorDesc.length && ([self.errorDesc rangeOfString:L(@"SCStopSales")].location != NSNotFound ||
                                   [self.errorDesc rangeOfString:L(@"SCNotSales")].location != NSNotFound ||
                                   [self.errorDesc rangeOfString:L(@"SCNoGoods")].location != NSNotFound ||
                                   [self.errorDesc rangeOfString:L(@"SCUnderCarriage")].location != NSNotFound))
        
        )
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

//是否有错误商品
- (NSString *)recursiveErrorDesc
{
    NSString *error = nil;
    if (self.isCanntCheck)
    {
        error = self.errorDesc;
    }
    else if (self.packageType == PackageTypeAccessory)
    {
        for (ShopCartV2DTO *innerDto in self.accessoryPackageList)
        {
            if (innerDto.isCanntCheck)
            {
                error = [NSString stringWithFormat:@"%@《%@》%@%@", L(@"SCInPackage"),innerDto.productName,L(@"SCGoodsAndSoOn"), innerDto.errorDesc];
                break;
            }
        }
    }
    else if (self.packageType == PackageTypeSmall)
    {
        for (ShopCartV2DTO *innerDto in self.smallPackageList)
        {
            if (innerDto.isCanntCheck)
            {
                error = [NSString stringWithFormat:@"%@《%@》%@%@", L(@"SCInPackage"),innerDto.productName,L(@"SCGoodsAndSoOn"), innerDto.errorDesc];
                break;
            }
        }
    }
    
    return error;
}

//更改勾选状态
- (BOOL)modifyCheck:(NSString **)errorMsg
{
    
    if (self.isChecked)
    {
        self.isChecked = NO;
        return YES;
    }
    else
    {
        NSString *error = [self recursiveErrorDesc];
        
        if (error)
        {
            *errorMsg = error;
            return NO;
        }
        else
        {
            self.isChecked = YES;
            return YES;
        }
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.orderItemId forKey:@"orderItemId"];
    [aCoder encodeObject:self.catentryId forKey:@"catentryId"];
    [aCoder encodeObject:self.partNumber forKey:@"partNumber"];
    [aCoder encodeObject:self.productName forKey:@"productName"];
    [aCoder encodeObject:self.itemPrice forKey:@"itemPrice"];
    [aCoder encodeObject:self.quantity forKey:@"quantity"];
    [aCoder encodeObject:self.editQuantity forKey:@"editQuantity"];
    [aCoder encodeObject:@(self.packageType) forKey:@"packageType"];
    [aCoder encodeObject:self.cityCode forKey:@"cityCode"];
    [aCoder encodeObject:self.cityName forKey:@"cityName"];
    [aCoder encodeObject:@(self.canTake) forKey:@"canTake"];
    [aCoder encodeObject:@(self.special) forKey:@"special"];
    [aCoder encodeObject:@(self.powerFlag) forKey:@"powerFlag"];
    [aCoder encodeObject:self.errorDesc forKey:@"errorDesc"];
    [aCoder encodeObject:self.saleOrg forKey:@"saleOrg"];
    [aCoder encodeObject:self.juhuiActiveId forKey:@"juhuiActiveId"];
    [aCoder encodeObject:self.limitCount forKey:@"limitCount"];
    [aCoder encodeObject:@(self.isChecked) forKey:@"isChecked"];
    [aCoder encodeObject:@(self.isCanntCheck) forKey:@"isCanntCheck"];
    [aCoder encodeObject:@(self.isDeleteItemCheck) forKey:@"isDeleteItemCheck"];
    
    NSData *aData = [NSKeyedArchiver archivedDataWithRootObject:self.accessoryPackageList];
    [aCoder encodeObject:aData forKey:@"accessoryPackageList"];
    
    NSData *sData = [NSKeyedArchiver archivedDataWithRootObject:self.smallPackageList];
    [aCoder encodeObject:sData forKey:@"smallPackageList"];
    
    NSData *xData = [NSKeyedArchiver archivedDataWithRootObject:self.xnPackageList];
    [aCoder encodeObject:xData forKey:@"xnPackageList"];
    
    [aCoder encodeObject:__INT(self.isInnerProduct) forKey:@"isInnerProduct"];
    
    [aCoder encodeObject:self.supplierCode forKey:@"supplierCode"];
}


- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.orderItemId = [coder decodeObjectForKey:@"orderItemId"];
        self.catentryId = [coder decodeObjectForKey:@"catentryId"];
        self.partNumber = [coder decodeObjectForKey:@"partNumber"];
        self.productName = [coder decodeObjectForKey:@"productName"];
        self.itemPrice = [coder decodeObjectForKey:@"itemPrice"];
        self.quantity = [coder decodeObjectForKey:@"quantity"];
        self.editQuantity = [coder decodeObjectForKey:@"editQuantity"];
        self.packageType = [[coder decodeObjectForKey:@"packageType"] intValue];
        self.cityCode = [coder decodeObjectForKey:@"cityCode"];
        self.cityName = [coder decodeObjectForKey:@"cityName"];
        self.canTake = [[coder decodeObjectForKey:@"canTake"] boolValue];
        self.powerFlag = [[coder decodeObjectForKey:@"powerFlag"] boolValue];
        self.special = [[coder decodeObjectForKey:@"special"] integerValue];
        self.errorDesc = [coder decodeObjectForKey:@"errorDesc"];
        self.saleOrg = [coder decodeObjectForKey:@"saleOrg"];
        self.juhuiActiveId = [coder decodeObjectForKey:@"juhuiActiveId"];
        self.limitCount = [coder decodeObjectForKey:@"limitCount"];
        self.isChecked = [[coder decodeObjectForKey:@"isChecked"] boolValue];
        self.isCanntCheck = [[coder decodeObjectForKey:@"isCanntCheck"] boolValue];
        self.isDeleteItemCheck = [[coder decodeObjectForKey:@"isDeleteItemCheck"] boolValue];

        NSData *aData = [coder decodeObjectForKey:@"accessoryPackageList"];
        self.accessoryPackageList = [NSKeyedUnarchiver unarchiveObjectWithData:aData];

        NSData *sData = [coder decodeObjectForKey:@"smallPackageList"];
        self.smallPackageList = [NSKeyedUnarchiver unarchiveObjectWithData:sData];
        
        NSData *xData = [coder decodeObjectForKey:@"xnPackageList"];
        self.xnPackageList = [NSKeyedUnarchiver unarchiveObjectWithData:xData];
        
        self.isInnerProduct = [[coder decodeObjectForKey:@"isInnerProduct"] boolValue];
        
        self.supplierCode = [coder decodeObjectForKey:@"supplierCode"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    
    ShopCartV2DTO *cartCopyDTO = [[[self class] allocWithZone:zone] init];
    
    cartCopyDTO->_orderItemId = [self.orderItemId copy];
    cartCopyDTO->_catentryId = [self.catentryId copy];
    cartCopyDTO->_partNumber = [self.partNumber copy];
    cartCopyDTO->_productName = [self.productName copy];
    cartCopyDTO->_itemPrice = [self.itemPrice copy];
    cartCopyDTO->_quantity = [self.quantity copy];
    cartCopyDTO->_editQuantity = [self.editQuantity copy];
    cartCopyDTO->_packageType = self.packageType;
    cartCopyDTO->_cityCode = [self.cityCode copy];
    cartCopyDTO->_cityName = [self.cityName copy];
    cartCopyDTO->_canTake = self.canTake;
    
    //考虑到下一层级已经只有一层，所以用one-level-deep-copy
    cartCopyDTO->_accessoryPackageList = [[NSMutableArray alloc] initWithArray:self.accessoryPackageList copyItems:YES];
    cartCopyDTO->_xnPackageList = [[NSMutableArray alloc] initWithArray:self.xnPackageList copyItems:YES];
    cartCopyDTO->_smallPackageList = [[NSMutableArray alloc] initWithArray:self.smallPackageList copyItems:YES];
    cartCopyDTO->_errorDesc = [self.errorDesc copy];
    cartCopyDTO->_saleOrg = [self.saleOrg copy];
    cartCopyDTO->_powerFlag = self.powerFlag;
    cartCopyDTO->_special = self.special;
    cartCopyDTO.isChecked = self.isChecked;
    cartCopyDTO.isCanntCheck = self.isCanntCheck;
    cartCopyDTO.isDeleteItemCheck = self.isDeleteItemCheck;
    cartCopyDTO.isInnerProduct = self.isInnerProduct;
    cartCopyDTO->_supplierCode = [self.supplierCode copy];
    
    return cartCopyDTO;
}

//支持判断是否是相同的订单行
- (NSArray *)identifierArray
{
    if (self.isInnerProduct) {
        return @[[NSString stringWithFormat:@"AccessoryItem:%@_%@",self.catentryId, self.quantity]];
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    void (^generateIdentier)(BOOL) = ^(BOOL isCheck) {
        
        NSString *specialStr = nil;
        switch (self.special) {
            case ShopCartSpecialRush: {
                specialStr = @"1";
                break;
            }
            case ShopCartSpecialSimpleGroup: {
                specialStr = @"5";
            }
            case ShopCartSpecialMarket: {
                specialStr = @"7";
            }
            default: {
                specialStr = @"0";
                break;
            }
        }
        
        NSMutableArray *hashArr = [@[self.catentryId?self.catentryId:@"",
                                     self.supplierCode?self.supplierCode:@"",
                                     self.quantity?self.quantity:@"1",
                                     STR_FROM_INT(self.packageType),
                                     self.cityCode?self.cityCode:[Config currentConfig].defaultCity,
                                     specialStr,
                                     isCheck ? @"1" : @"0",
                                     ] mutableCopy];
        if (self.packageType == PackageTypeAccessory && self.accessoryPackageList.count)
        {
            NSArray *accArr1 = [NSArray arrayWithArray:self.accessoryPackageList];
            NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:accArr1.count];
            for (ShopCartV2DTO *dto in accArr1)
            {
                [tempArr addObject:[NSString stringWithFormat:@"%@_%@", dto.catentryId,dto.quantity]];
            }
            //排序保证不同的顺序认为是相同的商品
            [tempArr sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                return [obj1 compare:obj2];
            }];
            
            for (NSString *item in tempArr)
            {
                [hashArr addObject:[NSString stringWithFormat:@"{AccessoryItem:%@}", item]];
            }
        }
        
        NSString *desc = [hashArr componentsJoinedByString:@"_"];
        [array addObject:desc];
    };
    
    generateIdentier(self.isChecked);
    if (self.isCanntCheck)
    {
        generateIdentier(!self.isChecked);
    }
    return [array copy];
}

@end
