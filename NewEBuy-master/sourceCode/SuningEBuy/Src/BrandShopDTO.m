//
//  BrandShopDTO.m
//  SuningEBuy
//
//  Created by chupeng on 14-7-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BrandShopDTO.h"

@implementation BrandShopDTO
- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic))
        return;
    
    NSString *brandName = [dic strValue:@"brandName"];
    NSString *brandImage = [dic strValue:@"brandImage"];
    NSString *descriptions = [dic strValue:@"description"];
    NSString *url = [dic strValue:@"url"];
    
    if (NotNilAndNull(brandName)) self.brandName = brandName;
    
    if (NotNilAndNull(brandImage)) self.brandImage = brandImage;
    
    if (NotNilAndNull(descriptions)) self.descriptions = descriptions;


    
    if (NotNilAndNull(url)) self.url = url;
    
}
@end
