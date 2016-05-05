//
//  ShopDetailDto.m
//  SuningEBuy
//
//  Created by xmy on 7/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopDetailDto.h"

@implementation ShopDetailDto

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.orderDttm = EncodeStringFromDic(dic, @"orderDttm");
    self.orderChannel = EncodeStringFromDic(dic, @"orderChannel");

    self.receiveName = EncodeStringFromDic(dic, @"receiveName");
    self.receiveMobile = EncodeStringFromDic(dic, @"receiveMobile");
    self.receiveAddress = EncodeStringFromDic(dic, @"receiveAddress");
    
    self.orderPayAmount = EncodeStringFromDic(dic, @"orderPayAmount");
    self.orderSaleAmount = EncodeStringFromDic(dic, @"orderSaleAmount");
    self.orderDiscountAmount = EncodeStringFromDic(dic, @"orderDiscountAmount");

    self.invoiceType = EncodeStringFromDic(dic, @"invoiceType");
    self.invoiceTitle = EncodeStringFromDic(dic, @"invoiceTitle");

    self.paymentDesc = EncodeStringFromDic(dic, @"paymentDesc");
    self.paymentCode = EncodeStringFromDic(dic, @"paymentCode");
    
    self.sourceOrderId = EncodeStringFromDic(dic, @"sourceOrderId");

    NSArray *arr = EncodeArrayFromDic(dic, @"orderItemList");
    
    if (arr !=nil && [arr count]>0)
    {
        for(NSDictionary *itemDic in arr)
        {
            ShopDetailItemDto *itemDto = [[ShopDetailItemDto alloc] init];
            
            [itemDto encodeFromDictionary:itemDic];
            
            [self.orderItemList addObject:itemDto];
            
        }
    }
    
    
}

- (NSMutableArray*)orderItemList
{
    if(!_orderItemList)
    {
        _orderItemList = [[NSMutableArray alloc] init];
    }
    
    return _orderItemList;
}


@end

@implementation ShopDetailItemDto

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.sapOrderId = EncodeStringFromDic(dic, @"sapOrderId");
    self.sapOrderType = EncodeStringFromDic(dic, @"sapOrderType");
    
    self.distChannel = EncodeStringFromDic(dic, @"distChannel");
    self.saleCount = EncodeStringFromDic(dic, @"saleCount");
    self.unitPrice = EncodeStringFromDic(dic, @"unitPrice");
    
    self.payAmount = EncodeStringFromDic(dic, @"payAmount");
    self.saleAmount = EncodeStringFromDic(dic, @"saleAmount");
    self.posOrderId = EncodeStringFromDic(dic, @"posOrderId");
    
    self.commodityCode = EncodeStringFromDic(dic, @"commodityCode");
    self.commodityName = EncodeStringFromDic(dic, @"commodityName");
    
    self.verifyCode = EncodeStringFromDic(dic, @"verifyCode");
    self.shipCondition = EncodeStringFromDic(dic, @"shipCondition");
    
    self.sourceOrderItemId = EncodeStringFromDic(dic, @"sourceOrderItemId");
    
    self.invoiceContent = EncodeStringFromDic(dic, @"invoiceContent");
    self.orderItemClass = EncodeStringFromDic(dic, @"orderItemClass");
    
    self.orderItemStatus = EncodeStringFromDic(dic, @"orderItemStatus");
    
}

//判断送货方式
+ (NSString*)judgeShipContition:(NSString*)str
{
    NSString *shipStr = Nil;
    
    if([str isEqualToString:@"02"] || IsStrEmpty(str) || [str isEqualToString:@"17"])
    {
        shipStr = L(@"MyEBuy_PickedUpInStores");
    }
    else
    {
        shipStr = L(@"MyEBuy_SuningDelivery");
    }
        
    return shipStr;
}




@end
