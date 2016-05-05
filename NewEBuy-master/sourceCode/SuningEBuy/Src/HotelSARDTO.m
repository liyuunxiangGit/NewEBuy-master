//
//  HotelSARDTO.m
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-7-4.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import "HotelSARDTO.h"

@implementation HotelSARDTO
@synthesize locationId=locationId_;
@synthesize locationName=locationName_;
@synthesize loactionType=loactionType_;

-(void)dealloc{
    
    TT_RELEASE_SAFELY(locationId_);
    TT_RELEASE_SAFELY(locationName_);
    TT_RELEASE_SAFELY(loactionType_);    
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.locationId = EncodeStringFromDic(dic, @"locationId");
    self.locationName = EncodeStringFromDic(dic, @"locationName");
    self.loactionType = EncodeStringFromDic(dic, @"loactionType");
}





@end
