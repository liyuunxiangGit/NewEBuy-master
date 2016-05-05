//
//  NewOrderListDTO.m
//  SuningEBuy
//
//  Created by xmy on 31/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewOrderListDTO.h"

@implementation NewOrderListDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
        
    self.orderId = EncodeStringFromDic(dic, @"orderId");
    self.prepayAmount = EncodeStringFromDic(dic, @"prepayAmount");
    self.totalShipPrice = EncodeStringFromDic(dic, @"totalShipPrice");
    self.lastUpdate = EncodeStringFromDic(dic, @"lastUpdate");

    self.canConfirmAccept = [EncodeStringFromDic(dic, @"canConfirmAccept") isEqualToString:@"true"];
    self.canTwiceBuy = [EncodeStringFromDic(dic, @"canTwiceBuy") isEqualToString:@"1"];
    self.canMerchantOrder = [EncodeStringFromDic(dic, @"canMerchantOrder") isEqualToString:@"1"];
    self.ormOrder = EncodeStringFromDic(dic, @"ormOrder");
    self.oiStatus = EncodeStringFromDic(dic, @"oiStatus");
    
    NSArray *supplierList__ = [dic objectForKey:@"supplierList"];
    
    if (!IsArrEmpty(supplierList__)) {
    
        if (!_productList) {
            _productList = [[NSMutableArray alloc]init];
        }
        
        for (NSDictionary *tmpDic in supplierList__) {
            int firstItem = 0;
            BOOL confirmAccept = [EncodeStringFromDic(tmpDic, @"canConfirmAcceptNew") isEqualToString:@"1"];

            NSString *supplierCode = EncodeStringFromDic(tmpDic, @"supplierCode");
            NSString *cShopName = EncodeStringFromDic(tmpDic, @"cShopName");
            NSString *supplierOrderStatus = EncodeStringFromDic(tmpDic, @"supplierOrderStatus");
            NSArray *itemList = EncodeArrayFromDic(tmpDic, @"itemList");
            NSString *lastUpdate = EncodeStringFromDic(tmpDic, @"lastUpdate");
            NSString *orderID = EncodeStringFromDic(tmpDic, @"orderId");
            
            OrderSupplierListDTO *supplierDto = [[OrderSupplierListDTO alloc] init];
            
            [supplierDto encodeFromDictionary:tmpDic];
            
            [self.supplierList addObject:supplierDto];
            
            if (!IsArrEmpty(itemList)) {
                
                for (NSDictionary *dic1 in itemList) {
                    
                    ProductListDTO *product = [[ProductListDTO alloc]init];
                    [product encodeFromDictionary:dic1];
                    product.supplierCode = supplierCode;
                    product.supplierName = cShopName;
                    product.canConfirmAcceptPro = confirmAccept;
                    product.supplierOrderStatus = supplierOrderStatus;
                    
                    //-----自行添加字段,在订单列表中跳评价晒单页面使用-----
                    product.lastUpdate = lastUpdate;
                    product.orderID = orderID;
                    //-------------------end------------------------
                    
                    if (firstItem == 0) {
                        product.isShowShopName = YES;
                    }
                    else
                    {
                        product.isShowShopName = NO;
                    }

                    [self.productList addObject:product];
                    
                    self.supplierCode = supplierCode;
                    self.cShopName = cShopName;
                    self.supplierOrderStatus = supplierOrderStatus;
                    firstItem++;

                }
            }
//            self.supplierOrderStatus = supplierOrderStatus;
//            self.supplierCode = supplierCode;
//            self.cShopName = cShopName;
        }
    }
    
//    [self.supplierList addObjectsFromArray:supplierList__];
    
}

- (NSMutableArray*)supplierList
{
    if(!_supplierList)
    {
        _supplierList = [[NSMutableArray alloc] init];
    }
    return _supplierList;
}

- (BOOL)canCancelOrderList
{
    //可取消订单或退货，且不是货到付款订单
    if (self.canMerchantOrder == YES && ![self isCanCancelOrderList])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)isCanCancelOrderList
{
    return [_ormOrder isEqualToString:@"11601"]; //[_policyDesc hasPrefix:@"货到付款"];
}
//是否为收货完成订单
- (BOOL)isFinishAcceptOK:(BOOL)finish
{
    //如果ProductListDTO有finishAccept字段则用该字段判断，没有则根据其他值判断
    
    if(finish == YES)
    {
        if([self.oiStatus isEqualToString:@"C"] || [self.oiStatus isEqualToString:@"SC"]
           || [self.oiStatus isEqualToString:@"SD"] || [self.oiStatus isEqualToString:@"WD"] || [self.oiStatus isEqualToString:@"SOMED"])
        {
            return YES;

        }
        else
        {
            return NO;

        }
    }
    else
    {

        return NO;
        
    }
   
}

//是否为已发货订单
- (BOOL)isDelivityOK:(NSString*)omsStatusStr
{
    //如果ProductListDTO有omsStatus字段则用该字段判断，没有则根据(canConfirmAccept)其他值判断
    if(IsStrEmpty(omsStatusStr))
    {
        //可确认收货且为已支付订单则为已发货订单
        if(self.canConfirmAccept && ([self.oiStatus isEqualToString:@"C"] || [self.oiStatus isEqualToString:@"SC"]
           || [self.oiStatus isEqualToString:@"SD"] || [self.oiStatus isEqualToString:@"WD"] || [self.oiStatus isEqualToString:@"SOMED"]))
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        if([omsStatusStr isEqualToString:@"C000"]  &&( [self.oiStatus isEqualToString:@"C"] || [self.oiStatus isEqualToString:@"SC"] || [self.oiStatus isEqualToString:@"SD"] || [self.oiStatus isEqualToString:@"WD"] || [self.oiStatus isEqualToString:@"SOMED"]))
        {
            return YES;
        }
        else
        {
            return NO;

        }
    }
    
}

@end

@implementation OrderSupplierListDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.supplierCode = EncodeStringFromDic(dic, @"supplierCode");
    self.cShopName = EncodeStringFromDic(dic, @"cShopName");
    self.canConfirmAcceptNew = [EncodeStringFromDic(dic, @"canConfirmAcceptNew") isEqualToString:@"1"];
    self.supplierOrderStatus = EncodeStringFromDic(dic, @"supplierOrderStatus");
    NSArray *itemList = EncodeArrayFromDic(dic, @"itemList");
    
    if (!IsArrEmpty(itemList)) {
        
        if (!_productList) {
            _productList = [[NSMutableArray alloc]initWithCapacity:itemList.count];
        }
        
        for (NSDictionary *tmpDic in itemList) {
            ProductListDTO *product = [[ProductListDTO alloc]init];
            [product encodeFromDictionary:tmpDic];
            product.supplierCode = self.supplierCode;
            product.supplierName = self.cShopName;
            product.canConfirmAcceptPro = self.canConfirmAcceptNew;
            [self.productList addObject:product];
        }
    }
}

@end

@implementation ProductListDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.orderItemId = EncodeStringFromDic(dic, @"orderItemId");
    self.productCode = EncodeStringFromDic(dic, @"productCode");
    self.productId = EncodeStringFromDic(dic, @"productId");
    self.productName = EncodeStringFromDic(dic, @"productName");
    self.quantity = EncodeStringFromDic(dic, @"quantity");
    self.itemPrice = EncodeStringFromDic(dic, @"itemPrice");
    self.omsStatus = EncodeStringFromDic(dic, @"omsStatus");
    self.finishAccept = [EncodeStringFromDic(dic, @"finishAccept") isEqualToString:@"true"];
    self.isCanComment = EncodeStringFromDic(dic, @"canComment");
    self.isCanShow = EncodeStringFromDic(dic, @"canShow");

}

@end
