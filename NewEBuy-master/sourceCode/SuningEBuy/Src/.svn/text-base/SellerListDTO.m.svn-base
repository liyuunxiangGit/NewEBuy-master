//
//  SellerListDTO.m
//  SuningEBuy
//
//  Created by blues on 13-10-17.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SellerListDTO.h"

@implementation SellerListDTO


@synthesize productCode = _productCode;
@synthesize productId = _productId;
@synthesize cityCode = _cityCode;
@synthesize shopCode = _shopCode;
@synthesize shopName = _shopName;
@synthesize productPrice = _productPrice;
@synthesize shopGrade = _shopGrade;
@synthesize serviceAttitude = _serviceAttitude;
@synthesize sellerSpeed = _sellerSpeed;
@synthesize deliverSpeed = _deliverSpeed;
@synthesize inventoryInfo = _inventoryInfo;
@synthesize fare = _fare;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_cityCode);
    TT_RELEASE_SAFELY(_productId);
    TT_RELEASE_SAFELY(_productCode);
    TT_RELEASE_SAFELY(_shopCode);
    TT_RELEASE_SAFELY(_shopName);
    TT_RELEASE_SAFELY(_shopGrade);
    TT_RELEASE_SAFELY(_productPrice);
    TT_RELEASE_SAFELY(_serviceAttitude);
    TT_RELEASE_SAFELY(_sellerSpeed);
    TT_RELEASE_SAFELY(_deliverSpeed);
    TT_RELEASE_SAFELY(_inventoryInfo);
    TT_RELEASE_SAFELY(_fare);
    
//    TT_RELEASE_SAFELY(_qianggouActId);
//    TT_RELEASE_SAFELY(_qianggouFlag);
//    TT_RELEASE_SAFELY(_qianggouPrice);
//    
//    TT_RELEASE_SAFELY(_tuangouActId);
//    TT_RELEASE_SAFELY(_tuangouFlag);
//    TT_RELEASE_SAFELY(_tuangouPrice);
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.shopCode = EncodeStringFromDic(dic, @"shopCode");
    self.shopName = EncodeStringFromDic(dic, @"shopName");
    self.productPrice = EncodeStringFromDic(dic, @"productPrice");
    self.shopGrade = EncodeStringFromDic(dic, @"shopGrade");
    self.serviceAttitude = EncodeStringFromDic(dic, @"serviceAttitude");
    self.sellerSpeed = EncodeStringFromDic(dic, @"sellerSpeed");
    self.deliverSpeed = EncodeStringFromDic(dic, @"deliverSpeed");
    self.inventoryInfo = EncodeStringFromDic(dic, @"inventoryInfo");
    self.fare = EncodeStringFromDic(dic, @"fare");
    self.productCode = EncodeStringFromDic(dic, @"productCode");
    self.productId = EncodeStringFromDic(dic, @"productId");
    self.cityCode = EncodeStringFromDic(dic, @"cityCode");
    
    
    self.inventoryInfo = self.inventoryInfo.removeHtmlTags;
//    self.qianggouActId = EncodeStringFromDic(dic, @"qianggouActId");
//    self.qianggouFlag = EncodeStringFromDic(dic, @"qianggouFlag");
//    self.qianggouPrice = EncodeStringFromDic(dic, @"qianggouPrice");
//    
//    self.tuangouActId = EncodeStringFromDic(dic, @"tuangouActId");
//    self.tuangouFlag = EncodeStringFromDic(dic, @"tuangouFlag");
//    self.tuangouPrice = EncodeStringFromDic(dic, @"tuangouPrice");
}

//- (NSDictionary *)postDataDictionary
//{
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
//    [dic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];
//    
//    
//    [dic setObject:POST_VALUE(self.productId) forKey:@"productId"];
//    [dic setObject:POST_VALUE(self.productCode) forKey:@"productCode"];
//    [dic setObject:POST_VALUE(self.cityCode) forKey:@"cityCode"];
//    [dic setObject:POST_VALUE(self.shopCode) forKey:@"shopCode"];
//    [dic setObject:POST_VALUE(self.shopName) forKey:@"shopName"];
//    [dic setObject:POST_VALUE(self.shopGrade) forKey:@"shopGrade"];
//    [dic setObject:POST_VALUE(self.productPrice) forKey:@"productPrice"];
//    [dic setObject:POST_VALUE(self.serviceAttitude) forKey:@"serviceAttitude"];
//    [dic setObject:POST_VALUE(self.sellerSpeed) forKey:@"sellerSpeed"];
//    [dic setObject:POST_VALUE(self.deliverSpeed) forKey:@"deliverSpeed"];
//    [dic setObject:POST_VALUE(self.inventoryInfo) forKey:@"inventoryInfo"];
//    [dic setObject:POST_VALUE(self.fare) forKey:@"fare"];
//
//    return dic;
//}

@end
