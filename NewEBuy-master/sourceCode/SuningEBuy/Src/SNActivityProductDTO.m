//
//  SNActivityProductDTO.m
//  SuningEBuy
//
//  Created by 家兴 王 on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SNActivityProductDTO.h"

@implementation SNActivityProductDTO

@synthesize bigBangName = _bigBangName;
@synthesize partNumber = _partNumber;
@synthesize productId = _productId;
@synthesize productName = _productName;
@synthesize productPrice = _productPrice;
@synthesize catentryDesc = _catentryDesc;
@synthesize promIcon=_promIcon;
@synthesize originalPrice=_originalPrice;

- (void)encodeFromDictionary:(NSDictionary *)dic
{    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.bigBangName = EncodeStringFromDic(dic, @"bigBang");
    self.partNumber = EncodeStringFromDic(dic, @"partNumber");
    self.productId = EncodeStringFromDic(dic, @"productId");
    self.productName = EncodeStringFromDic(dic, @"productName");
    self.productPrice = EncodeStringFromDic(dic, @"productPrice");
    self.catentryDesc = EncodeStringFromDic(dic, @"catentryDesc");
    self.promIcon = EncodeStringFromDic(dic, @"promIcon");
    self.originalPrice = EncodeStringFromDic(dic, @"originalPrice");
    self.vendorCode = EncodeStringFromDic(dic, @"vendorCode");
}

- (DataProductBasic *)transformToProductDTO
{
    DataProductBasic *dto = [[DataProductBasic alloc] init];
    dto.productId = self.productId;
    dto.productCode = self.partNumber;
    dto.shopCode = self.vendorCode;
    return dto;

}

@end
