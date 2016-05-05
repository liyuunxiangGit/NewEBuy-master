//
//  ShopOrderListDto.m
//  SuningEBuy
//
//  Created by xmy on 24/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopOrderListDto.h"

@implementation ShopOrderListDto

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }

    NSString *orderItemCount = EncodeStringFromDic(dic, @"orderItemCount");
    NSString *orderChannel = EncodeStringFromDic(dic, @"orderChannel");
    NSString *sourceOrderId = EncodeStringFromDic(dic, @"sourceOrderId");
    NSString *orderSaleAmount = EncodeStringFromDic(dic, @"orderSaleAmount");
    NSString *orderDiscountAmount = EncodeStringFromDic(dic, @"orderDiscountAmount");
    NSString *orderPayAmount = EncodeStringFromDic(dic, @"orderPayAmount");
    NSString *orderDttm = EncodeStringFromDic(dic, @"orderDttm");
    NSString *omsOrderId = EncodeStringFromDic(dic, @"omsOrderId");
    
       
    if(NotNilAndNull(orderItemCount))
    {
        self.orderItemCount = orderItemCount;
    }
    
    if(NotNilAndNull(orderChannel))
    {
        self.orderChannel = orderChannel;
    }
    
    if(NotNilAndNull(sourceOrderId))
    {
        self.sourceOrderId = sourceOrderId;
    }
    
    if(NotNilAndNull(orderSaleAmount))
    {
        self.orderSaleAmount = orderSaleAmount;
    }
    
    if(NotNilAndNull(orderDiscountAmount))
    {
        self.orderDiscountAmount = orderDiscountAmount;
    }
    
    if(NotNilAndNull(orderPayAmount))
    {
        self.orderPayAmount = orderPayAmount;
    }
    
    
    if(NotNilAndNull(orderDttm))
    {
        self.orderDttm = orderDttm;
    }
    
    if(NotNilAndNull(omsOrderId))
    {
        self.omsOrderId = omsOrderId;
    }

    
    NSArray *itemList = EncodeArrayFromDic(dic, @"orderItemList");
        
    if (itemList !=nil && [itemList count]>0) {
        
//        if (!itemList) {
//            itemList = [[NSMutableArray alloc]init];
//        }
        
        for(NSDictionary *dic in itemList){
            
            ShopOrderItemListDto *dto = [[ShopOrderItemListDto alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            [self.orderItemList addObject:dto];
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

@implementation ShopOrderItemListDto

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.sourceOrderItemId = EncodeStringFromDic(dic, @"sourceOrderItemId");
    self.omsOrderItemId = EncodeStringFromDic(dic, @"omsOrderItemId");
    self.sapOrderId = EncodeStringFromDic(dic, @"sapOrderId");
    self.sapOrderType = EncodeStringFromDic(dic, @"sapOrderType");
    self.supplierCode = EncodeStringFromDic(dic, @"supplierCode");
    self.commodityCode = EncodeStringFromDic(dic, @"commodityCode");
    self.commodityName = EncodeStringFromDic(dic, @"commodityName");
    self.saleCount = EncodeStringFromDic(dic, @"saleCount");
    
    self.unitPrice = EncodeStringFromDic(dic, @"unitPrice");
    self.saleAmount = EncodeStringFromDic(dic, @"saleAmount");
    self.payStatus = EncodeStringFromDic(dic, @"payStatus");
    self.orderItemStatus = EncodeStringFromDic(dic, @"orderItemStatus");
    
     
}

@end
