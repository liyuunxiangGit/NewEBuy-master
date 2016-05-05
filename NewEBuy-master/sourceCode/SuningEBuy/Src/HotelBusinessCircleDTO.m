//
//  HotelBusinessCircleDTO.m
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-7-4.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//

#import "HotelBusinessCircleDTO.h"

@implementation HotelBusinessCircleDTO

@synthesize locationId=locationId_;
@synthesize locationName=locationName_;
@synthesize loactionType=loactionType_;

-(void)dealloc{
    
    TT_RELEASE_SAFELY(locationId_);
    TT_RELEASE_SAFELY(locationName_);
    TT_RELEASE_SAFELY(loactionType_);    
}

-(void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
	NSString *locationId  = [dic objectForKey:@"locationId"];
	NSString *locationName    = [dic objectForKey:@"locationName"];
	NSString *loactionType   = [dic objectForKey:@"loactionType"];
    
	if(NotNilAndNull(locationId)){
		self.locationId = locationId;
	}			
	if (NotNilAndNull(locationName)) {
		self.locationName = locationName;
	}
    //    if (loactionType != nil && ![loactionType isEqualToString:@""]) {
    self.loactionType = loactionType;
    //	}
}





@end
