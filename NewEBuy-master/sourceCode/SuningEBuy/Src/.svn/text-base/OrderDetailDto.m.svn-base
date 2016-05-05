//
//  OrderDetailDto.m
//  SuningEBuy
//
//  Created by xmy on 5/5/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "OrderDetailDto.h"
#import "ProductUtil.h"

@implementation OrderDetailDto
- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.orderId = EncodeStringFromDic(dic, @"orderId");
    self.oiStatus = EncodeStringFromDic(dic, @"oiStatus");
    self.lastUpdate = EncodeStringFromDic(dic, @"lastUpdate");
    self.totalPrice = EncodeStringFromDic(dic, @"totalPrice");
    self.totalDiscount = EncodeStringFromDic(dic, @"totalDiscount");
    self.prepayAmount = EncodeStringFromDic(dic, @"prepayAmount");
    self.policyDesc = EncodeStringFromDic(dic, @"policyDesc");
    self.comments = EncodeStringFromDic(dic, @"comments");
    self.ormOrder = EncodeStringFromDic(dic, @"ormOrder");
    self.supplierCode = EncodeStringFromDic(dic, @"supplierCode");
    self.cShopName = EncodeStringFromDic(dic, @"cShopName");
    self.totalShipPrice = EncodeStringFromDic(dic, @"totalShipPrice");
    
    self.canReturnOrder = [EncodeStringFromDic(dic, @"canReturnOrder") isEqualToString:@"1"];
    self.canTwiceBuy = [EncodeStringFromDic(dic, @"canTwiceBuy") isEqualToString:@"1"];
    self.merchantOrder = [EncodeStringFromDic(dic, @"merchantOrder") isEqualToString:@"1"];
    self.canConfirmAccept = [EncodeStringFromDic(dic, @"canConfirmAccept") isEqualToString:@"true"];


}
@end

@implementation OrderDetailItemDto
- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.orderItemId = EncodeStringFromDic(dic, @"orderItemId");
    self.productCode = EncodeStringFromDic(dic, @"productCode");
    self.productId = EncodeStringFromDic(dic, @"productId");
    self.productName = EncodeStringFromDic(dic, @"productName");
    self.quantityInIntValue = EncodeStringFromDic(dic, @"quantityInIntValue");
    self.totalProduct = EncodeStringFromDic(dic, @"totalProduct");
    self.isBundle = EncodeStringFromDic(dic, @"isBundle");
    self.posOrderNumber = EncodeStringFromDic(dic, @"posOrderNumber");
    self.verificationCode = EncodeStringFromDic(dic, @"verificationCode");
    self.currentShipModeType = EncodeStringFromDic(dic, @"currentShipModeType");
    self.taxType = EncodeStringFromDic(dic, @"taxType");
    self.itemPlacerName = EncodeStringFromDic(dic, @"itemPlacerName");
    self.itemMobilePhone = EncodeStringFromDic(dic, @"itemMobilePhone");
    self.address = EncodeStringFromDic(dic, @"address");
    self.invoice = EncodeStringFromDic(dic, @"invoice");
    self.invoiceDescription = EncodeStringFromDic(dic, @"invoiceDescription");
    self.exWarrantyFlag = EncodeStringFromDic(dic, @"exWarrantyFlag");
    self.exWarrantyName = EncodeStringFromDic(dic, @"exWarrantyName");
    self.exWarrantyQuantity = EncodeStringFromDic(dic, @"exWarrantyQuantity");
    self.exWarrantyPrice = EncodeStringFromDic(dic, @"exWarrantyPrice");
    self.returnStatus = EncodeStringFromDic(dic, @"returnStatus");

    self.imageURL = [ProductUtil getImageUrlWithProductCode:self.productCode size:ProductImageSize120x120];

    self.canTwiceBuy = [EncodeStringFromDic(dic, @"canTwiceBuy") isEqualToString:@"1"];
    self.canReturnOrder = [EncodeStringFromDic(dic, @"canReturnOrder") isEqualToString:@"1"];

}
@end

@implementation OrderDetailCListDto
- (void)encodeFromDictionary:(NSDictionary *)dic
{
 	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    self.expressNo = EncodeStringFromDic(dic, @"expressNo");
    self.isconfirmReceipt = [EncodeStringFromDic(dic, @"isconfirmReceipt") isEqualToString:@"true"];
    self.itemList = EncodeArrayFromDic(dic, @"itemList");

}
@end