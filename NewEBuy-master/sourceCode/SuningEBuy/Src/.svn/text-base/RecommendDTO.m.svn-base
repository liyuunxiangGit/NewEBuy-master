//
//  RecommendListDTO.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-4-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "RecommendDTO.h"
#import "ProductUtil.h"

@implementation RecommendDTO

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.sceneId = NotNilAndNull([dic objectForKey:@"sceneId"])?[dic objectForKey:@"sceneId"]:@"";
    
    self.parameter = NotNilAndNull([dic objectForKey:@"parameter"])?[dic objectForKey:@"parameter"]:@"";
    
    self.cityId = NotNilAndNull([dic objectForKey:@"cityId"])?[dic objectForKey:@"cityId"]:@"";
    
    NSArray *array = EncodeArrayFromDic(dic, @"skus");
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithCapacity:[array count]];
    for (NSDictionary *data in array) {
        
        RecommendListDTO *dto = [[RecommendListDTO alloc] init];
        [dto encodeFromDictionary:data];
        
        [list addObject:dto];
    }
    self.recommendList = list;
    
}

@end


@implementation RecommendListDTO

-(void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.sugGoodsCode = NotNilAndNull([dic objectForKey:@"sugGoodsCode"])?[dic objectForKey:@"sugGoodsCode"]:@"";
    self.sugGoodsId = NotNilAndNull([dic objectForKey:@"sugGoodsId"])?[dic objectForKey:@"sugGoodsId"]:@"";
    self.sugGoodsName = NotNilAndNull([dic objectForKey:@"sugGoodsName"])?[dic objectForKey:@"sugGoodsName"]:@"";
    self.sugGoodsDes = NotNilAndNull([dic objectForKey:@"sugGoodsDes"])?[dic objectForKey:@"sugGoodsDes"]:@"";
    self.promotionInfo = NotNilAndNull([dic objectForKey:@"promotionInfo"])?[dic objectForKey:@"promotionInfo"]:@"";
    self.vendorId = NotNilAndNull([dic objectForKey:@"vendorId"])?[dic objectForKey:@"vendorId"]:@"";
    self.price = NotNilAndNull([dic objectForKey:@"price"])?[dic objectForKey:@"price"]:@"";
    self.persent = NotNilAndNull([dic objectForKey:@"persent"])?[dic objectForKey:@"persent"]:@"";
    self.handwork = NotNilAndNull([dic objectForKey:@"handwork"])?[dic objectForKey:@"handwork"]:@"";
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.productUrl = [ProductUtil getImageUrlWithProductCode:self.sugGoodsCode size:ProductImageSize200x200];
    }
    else{
        
        self.productUrl = [ProductUtil getImageUrlWithProductCode:self.sugGoodsCode size:ProductImageSize120x120];
    }
    
}

- (DataProductBasic *)transformToProductDTO
{
    DataProductBasic *productDTO = [[DataProductBasic alloc] init];
    productDTO.productId = self.sugGoodsId;
    productDTO.productName = self.sugGoodsName;
    productDTO.productCode = self.sugGoodsCode;
    if ([self.vendorId isEqualToString:@"0000000000"]) {
        productDTO.shopCode = @"";
    }
    else
    {
        productDTO.shopCode = self.vendorId;
    }
    
    return productDTO;
}

@end