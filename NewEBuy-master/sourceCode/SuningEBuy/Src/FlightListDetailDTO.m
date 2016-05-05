//
//  FlightListDetailDTO.m
//  SuningEBuy
//
//  Created by shasha on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightListDetailDTO.h"

@implementation FlightListDetailDTO
@synthesize company = _company;
@synthesize companyName = _companyName;
@synthesize roomB = _roomB;
@synthesize roomPrice = _roomPrice;
@synthesize offRate = _offRate;
@synthesize offPrice = _offPrice;
@synthesize retPrice = _retPrice;
@synthesize fTime = _fTime;
@synthesize fDate = _fDate;
@synthesize oaFullName = _oaFullName;
@synthesize aTime = _aTime;
@synthesize aDate = _aDate;
@synthesize aaFullName = _aaFullName;
@synthesize fNo = _fNo;
@synthesize room = _room;


- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)dealloc {
    TT_RELEASE_SAFELY(_company);
    TT_RELEASE_SAFELY(_companyName);
    TT_RELEASE_SAFELY(_roomPrice);
    TT_RELEASE_SAFELY(_roomB);
    TT_RELEASE_SAFELY(_offRate);
    TT_RELEASE_SAFELY(_offPrice);
    TT_RELEASE_SAFELY(_retPrice);
    TT_RELEASE_SAFELY(_oaFullName);
    TT_RELEASE_SAFELY(_fTime);
    TT_RELEASE_SAFELY(_fDate);
    TT_RELEASE_SAFELY(_aaFullName);
    TT_RELEASE_SAFELY(_aTime);
    TT_RELEASE_SAFELY(_aDate);
    TT_RELEASE_SAFELY(_fNo);
    TT_RELEASE_SAFELY(_room);
}

@end
