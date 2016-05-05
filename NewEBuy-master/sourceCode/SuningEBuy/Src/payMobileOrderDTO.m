//
//  payMobileOrderDTO.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-14.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "payMobileOrderDTO.h"

@implementation payMobileOrderDTO

@synthesize mobileNumber = _mobileNumber;
@synthesize mobilequo    = _mobilequo;
@synthesize payPrice     = _payPrice;
@synthesize factPayPrice = _factPayPrice;

@synthesize yifubaoMoney =_yifubaoMoney;
@synthesize ispType = _ispType;
@synthesize providerNO = _providerNO;
@synthesize provinceId = _provinceId;
@synthesize provinceName = _provinceName;

- (void)dealloc{	
    
    TT_RELEASE_SAFELY(_mobileNumber);
    TT_RELEASE_SAFELY(_mobilequo);
    TT_RELEASE_SAFELY(_payPrice);
    TT_RELEASE_SAFELY(_factPayPrice);
    TT_RELEASE_SAFELY(_yifubaoMoney);
    TT_RELEASE_SAFELY(_ispType);
    TT_RELEASE_SAFELY(_providerNO);
    TT_RELEASE_SAFELY(_provinceId);
    TT_RELEASE_SAFELY(_provinceName);
}    



@end
