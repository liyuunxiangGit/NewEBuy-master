//
//  ActivateIntegralDTO.m
//  SuningEBuy
//
//  Created by zhangjian on 12-3-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ActivateIntegralDTO.h"

@implementation ActivateIntegralDTO

@synthesize integralName = _integralName;
@synthesize integralGender = _integralGender;
@synthesize integralCardTypeCn = _integralCardTypeCn;
@synthesize integralCardIsExist = _integralCardIsExist;
@synthesize integralCardType = _integralCardType;

@synthesize integralIdCode = _integralIdCode;
@synthesize integralMobile = _integralMobile;
@synthesize integralIsBindMobile = _integralIsBindMobile;
@synthesize integralState = _integralState;
@synthesize integralCity = _integralCity;

@synthesize integralAddressField1 = _integralAddressField1;
@synthesize integralAddressField2 = _integralAddressField2;
@synthesize integralDetAdd = _integralDetAdd;

@synthesize provinceName = _provinceName;
@synthesize cityName = _cityName;
@synthesize districtName = _districtName;
@synthesize townName = _townName;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_integralName);
    TT_RELEASE_SAFELY(_integralGender);
    TT_RELEASE_SAFELY(_integralCardTypeCn);
    TT_RELEASE_SAFELY(_integralCardIsExist);
    TT_RELEASE_SAFELY(_integralCardType);
    
    TT_RELEASE_SAFELY(_integralIdCode);
    TT_RELEASE_SAFELY(_integralMobile);
    TT_RELEASE_SAFELY(_integralIsBindMobile);
    TT_RELEASE_SAFELY(_integralState);
    TT_RELEASE_SAFELY(_integralCity);
    
    TT_RELEASE_SAFELY(_integralAddressField1);
    TT_RELEASE_SAFELY(_integralAddressField2);
    TT_RELEASE_SAFELY(_integralDetAdd);
    
    TT_RELEASE_SAFELY(_provinceName);
    TT_RELEASE_SAFELY(_cityName);
    TT_RELEASE_SAFELY(_districtName);
    TT_RELEASE_SAFELY(_townName);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *__name = [dic objectForKey:@"name"];
    NSString *__gender = [dic objectForKey:@"gender"];
    NSString *__cardTypeCn = [dic objectForKey:@"cardTypeCn"];
    NSString *__cardIsExist = [dic objectForKey:@"cardIsExist"];
    NSString *__cardType = [dic objectForKey:@"cardType"];
    
    NSString *__idCode = [dic objectForKey:@"idCode"];
    NSString *__mobile = [dic objectForKey:@"mobile"];
    NSString *__isBindMobile = [dic objectForKey:@"isBindMobile"];
    NSString *__state = [dic objectForKey:@"state"];
    NSString *__city = [dic objectForKey:@"city"];
    NSString *__addressField1 = [dic objectForKey:@"addressField1"];
    NSString *__addressField2 = [dic objectForKey:@"addressField2"];
    NSString *__detAdd = [dic objectForKey:@"detAdd"];
    NSString *__provinceName = [dic objectForKey:@"provinceName"];
    NSString *__cityName = [dic objectForKey:@"cityName"];
    NSString *__districtName = [dic objectForKey:@"districtName"];
    NSString *__townName = [dic objectForKey:@"townName"];
    
    if (NotNilAndNull(__name))              self.integralName = __name;
    if (NotNilAndNull(__gender))            self.integralGender = __gender;
    if (NotNilAndNull(__cardTypeCn))        self.integralCardTypeCn = __cardTypeCn;
    if (NotNilAndNull(__cardType))          self.integralCardType = __cardType;
    if (NotNilAndNull(__cardIsExist))       self.integralCardIsExist = __cardIsExist;
    if (NotNilAndNull(__idCode))            self.integralIdCode = __idCode;
    if (NotNilAndNull(__mobile))            self.integralMobile = __mobile;
    if (NotNilAndNull(__isBindMobile))      self.integralIsBindMobile = __isBindMobile;
    if (NotNilAndNull(__state))             self.integralState = __state;
    if (NotNilAndNull(__city))              self.integralCity = __city;
    if (NotNilAndNull(__addressField1))     self.integralAddressField1 = __addressField1;
    if (NotNilAndNull(__addressField2))     self.integralAddressField2 = __addressField2;
    if (NotNilAndNull(__detAdd))            self.integralDetAdd = __detAdd;
    if (NotNilAndNull(__provinceName))      self.provinceName = __provinceName;
    if (NotNilAndNull(__cityName))          self.cityName = __cityName;
    if (NotNilAndNull(__districtName))      self.districtName = __districtName;
    if (NotNilAndNull(__townName))          self.townName = __townName;
}


@end
