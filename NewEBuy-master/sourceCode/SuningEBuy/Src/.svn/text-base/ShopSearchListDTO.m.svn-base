//
//  ShopSearchListDTO.m
//  SuningEBuy
//
//  Created by chupeng on 14-7-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopSearchListDTO.h"

@implementation ShopSearchListDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    
    NSString *shopId = [dic strValue:@"shopId"];
    NSString *shopDomain = [dic strValue:@"shopDomain"];
    NSString *logoUrl = [dic strValue:@"logoUrl"];
    NSString *supplyId = [dic strValue:@"supplyId"];
    NSMutableArray *brandname = [[dic arrayValue:@"shopId"] mutableCopy];
    NSString *companyName = [dic strValue:@"companyName"];
    NSString *shopName = [dic strValue:@"shopName"];
    NSString *shopAddress = [dic strValue:@"shopAddress"];
    NSString *catalog = [dic strValue:@"catalog"];
    NSString *supplySatisfyStar = [dic strValue:@"supplySatisfyStar"];
    NSString *productScore = [dic strValue:@"productScore"];
    NSString *serviceScore = [dic strValue:@"serviceScore"];
    NSString *logisticsScore = [dic strValue:@"logisticsScore"];
    NSString *salesNum = [dic strValue:@"salesNum"];
    
    if (NotNilAndNull(shopId))
        self.shopId = shopId;
    
    if (NotNilAndNull(shopDomain))
        self.shopDomain = shopDomain;
    
    if (NotNilAndNull(logoUrl))
        self.logoUrl = logoUrl;
    
    if (NotNilAndNull(supplyId))
        self.supplyId = supplyId;
    
    if (NotNilAndNull(brandname))
        self.brandname = brandname;
    
    if (NotNilAndNull(companyName))
        self.companyName = companyName;
    
    if (NotNilAndNull(shopName))
        self.shopName = shopName;
    
    if (NotNilAndNull(shopAddress))
        self.shopAddress = shopAddress;
    
    if (NotNilAndNull(catalog))
        self.catalog = catalog;
    
    if (NotNilAndNull(supplySatisfyStar))
        self.supplySatisfyStar = supplySatisfyStar;
    
    if (NotNilAndNull(productScore))
        self.productScore = productScore;
    
    if (NotNilAndNull(serviceScore))
        self.serviceScore = serviceScore;
    
    if (NotNilAndNull(logisticsScore))
        self.logisticsScore = logisticsScore;
    
    if (NotNilAndNull(salesNum))
        self.salesNum = salesNum;
    
}


@end
