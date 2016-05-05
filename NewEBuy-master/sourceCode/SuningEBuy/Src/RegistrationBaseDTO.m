//
//  RegistrationBaseDTO.m
//  SuningEBuy
//
//  Created by 王家兴 on 13-7-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "RegistrationBaseDTO.h"

@implementation RegistrationBaseDTO

@end

@implementation RegistrationDetailBaseDTO
@synthesize userId = _userId;
@synthesize checkType = _checkType;
@synthesize distance = _distance;
@synthesize latitudeAndLongitude = _latitudeAndLongitude;
@synthesize storeId = _storeId;
@synthesize checkCodeId = _checkCodeId;
@synthesize custNum = _custNum;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_userId);
    TT_RELEASE_SAFELY(_checkType);
    TT_RELEASE_SAFELY(_distance);
    TT_RELEASE_SAFELY(_latitudeAndLongitude);
    TT_RELEASE_SAFELY(_storeId);
    TT_RELEASE_SAFELY(_checkCodeId);
    TT_RELEASE_SAFELY(_custNum);
    
}

@end

@implementation StoresRegistrationBaseDTO
@synthesize userId = _userId;
@synthesize distance = _distance;
@synthesize latitudeAndLongitude = _latitudeAndLongitude;
@synthesize storeId = _storeId;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_userId);
    TT_RELEASE_SAFELY(_distance);
    TT_RELEASE_SAFELY(_latitudeAndLongitude);
    TT_RELEASE_SAFELY(_storeId);
    
}
@end