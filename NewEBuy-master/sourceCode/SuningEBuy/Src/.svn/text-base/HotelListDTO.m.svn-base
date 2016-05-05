//
//  HotelListDTO.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "HotelListDTO.h"


@implementation HotelListDTO


@synthesize lot = _lot;
@synthesize hotelDesc = _hotelDesc;
@synthesize hotelPrice = _hotelPrice;
@synthesize hotelAdds = _hotelAdds;
@synthesize hotelCouponRet = _hotelCouponRet;

@synthesize snstar = _snstar;
@synthesize category = _category;
@synthesize hotelId = _hotelId;
@synthesize hotelImg = _hotelImg;
@synthesize hotelName = _hotelName;

@synthesize lat = _lat;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_lot);
    TT_RELEASE_SAFELY(_hotelDesc);
    TT_RELEASE_SAFELY(_hotelPrice);
    TT_RELEASE_SAFELY(_hotelAdds);
    TT_RELEASE_SAFELY(_hotelCouponRet);
    
    TT_RELEASE_SAFELY(_snstar);
    TT_RELEASE_SAFELY(_category);
    TT_RELEASE_SAFELY(_hotelId);
    TT_RELEASE_SAFELY(_hotelImg);
    TT_RELEASE_SAFELY(_hotelName);
    
    TT_RELEASE_SAFELY(_lat);
    
}




-(void)encodeFromDictionary:(NSDictionary *)dic{
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *__lot = [dic objectForKey:@"lot"];
    NSString *__hotelDesc = [dic objectForKey:@"hotelDesc"];
    NSString *__hotelPrice = [dic objectForKey:@"hotelPrice"];
    NSString *__hotelAdds = [dic objectForKey:@"hotelAdds"];
    NSString *__hotelCouponRet = [dic objectForKey:@"hotelCouponRet"];
    
    NSString *__snstar = [dic objectForKey:@"snstar"];
    NSString *__category = [dic objectForKey:@"category"];
    
    NSString *__hotelId = [dic objectForKey:@"hotelId"]; 
    NSString *__hotelImg = [dic objectForKey:@"hotelImg"];
    NSString *__hotelName = [dic objectForKey:@"hotelName"];
    NSString *__lat = [dic objectForKey:@"lat"];
    
    
    if (NotNilAndNull(__lot) && ![__lot isEqualToString:@""]) {
        self.lot = __lot;
    }
    
    if (NotNilAndNull(__hotelDesc) && ![__hotelDesc isEqualToString:@""]) {

        self.hotelDesc = __hotelDesc;
    }
    
    if (NotNilAndNull(__hotelPrice) && ![__hotelPrice isEqualToString:@""]) {
        self.hotelPrice = __hotelPrice;
    }
    
    if (NotNilAndNull(__hotelAdds) && ![__hotelAdds isEqualToString:@""]) {
        self.hotelAdds = __hotelAdds;
    }
    
    if (NotNilAndNull(__hotelCouponRet) && ![__hotelCouponRet isEqualToString:@""]) {
        self.hotelCouponRet = __hotelCouponRet;
    }
    
    if (NotNilAndNull(__snstar) && ![__snstar isEqualToString:@""]) {
        self.snstar = __snstar;
    }
    
    if (NotNilAndNull(__category) && ![__category isEqualToString:@""]) {
        self.category = __category;
    }
    
    if (NotNilAndNull(__hotelId) && ![__hotelId isEqualToString:@""]) {
        self.hotelId = __hotelId;
    }
    
                
    NSString *firstTwo = [self.hotelId substringWithRange:NSMakeRange(0, 2)];
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@/%@/%@/",kHostHotelImageForHttp,firstTwo,self.hotelId];

    NSString *hotelImage = nil;
   
    if (NotNilAndNull(__hotelImg) && ![__hotelImg isEqualToString:@""]) {
   
        hotelImage= [imageUrl stringByAppendingString:__hotelImg];
        
    }
    else{
        
        hotelImage = kProductImageViewDefultImage;
    }
    NSURL *tempURL = [[NSURL alloc] initWithString:hotelImage];
    self.hotelImg = tempURL;
    TT_RELEASE_SAFELY(tempURL);

//    self.hotelImg = [NSURL URLWithString:hotelImage];
    
 
    
    if (NotNilAndNull(__hotelName) || ![__hotelName isEqualToString:@""]) {
        self.hotelName = __hotelName;
    }
    
    if (NotNilAndNull(__lat) || ![__lat isEqualToString:@""]) {
        self.lat = __lat;
    }
    
}


@end
