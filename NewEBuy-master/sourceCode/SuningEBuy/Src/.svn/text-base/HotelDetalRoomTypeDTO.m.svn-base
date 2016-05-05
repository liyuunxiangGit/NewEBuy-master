//
//  HotelDetalRoomTypeDTO.m
//  SuningEBuy
//
//  Created by robin wang on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotelDetalRoomTypeDTO.h"

@implementation HotelDetalRoomTypeDTO
@synthesize name = _name;
@synthesize  nike = _nike;
@synthesize discribe =_discribe;
@synthesize price = _price;
@synthesize status = _status;

@synthesize uid = _uid;

@synthesize area = _area;

@synthesize floor = _floor;

@synthesize ratePlanId = _ratePlanId;

- (void)dealloc {
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_discribe);
    TT_RELEASE_SAFELY(_price);
    TT_RELEASE_SAFELY(_status);
    
    TT_RELEASE_SAFELY(_uid);
    TT_RELEASE_SAFELY(_nike);
    TT_RELEASE_SAFELY(_ratePlanId);
    
    TT_RELEASE_SAFELY(_floor);
    TT_RELEASE_SAFELY(_area);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    
    NSString *__nike = [dic objectForKey:@"ratePlanName"];
   // NSString *__name = [dic objectForKey:@"roomTypeName"];
   // NSString *__discribe = [dic objectForKey:@"bedDescription"];
    
   // NSMutableArray *tempArr = [dic objectForKey:@"ratePlans"];
    
    NSString *__pric = [dic objectForKey:@"averagePrice"];
    NSString *__status = [dic objectForKey:@"ratePlanInvStatusCode"];
    
    NSString *__uid = [dic objectForKey:@"roomTypeId"];
    
        NSString *__ratePlanId = [dic objectForKey:@"ratePlanId"];

     if (NotNilAndNull(__nike))   self.nike = __nike;   
   // if (NotNilAndNull(__name))   self.name = __name;
   // if (NotNilAndNull(__discribe))   self.discribe = __discribe;
    if (NotNilAndNull(__pric))   self.price = __pric;
    if (NotNilAndNull(__status))   self.status = __status;
    if (NotNilAndNull(__uid))   self.uid = __uid;
    if (NotNilAndNull(__ratePlanId))   self.ratePlanId = __ratePlanId;

}
@end
