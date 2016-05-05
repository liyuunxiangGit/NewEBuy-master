//
//  HotelListDTO.h
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-2.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpDTO.h"

@interface HotelListDTO : BaseHttpDTO

{
    
}

@property(nonatomic, copy)     NSString     *lot;
@property(nonatomic, copy)     NSString     *hotelDesc;
@property(nonatomic, copy)     NSString     *hotelPrice;
@property(nonatomic, copy)     NSString     *hotelAdds;
@property(nonatomic, copy)     NSString     *hotelCouponRet;

@property(nonatomic, copy)     NSString     *snstar;
@property(nonatomic, copy)     NSString     *category;
@property(nonatomic, copy)     NSString     *hotelId;
@property(nonatomic, copy)     NSURL     *hotelImg;
@property(nonatomic, copy)     NSString     *hotelName;

@property(nonatomic, copy)     NSString     *lat;



-(void)encodeFromDictionary:(NSDictionary *)dic;

@end
