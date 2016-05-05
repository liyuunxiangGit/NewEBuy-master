//
//  GBEfubaoDTO.m
//  SuningEBuy
//
//  Created by xie wei on 13-6-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBEfubaoDTO.h"

@implementation GBEfubaoDTO

@synthesize orderId = _orderId;
@synthesize userId = _userId;
@synthesize memberId = _memberId;
@synthesize paymentType = _paymentType;
@synthesize ifSuccess = _ifSuccess;
@synthesize passwordErrorTimes = _passwordErrorTimes;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_userId);
    TT_RELEASE_SAFELY(_memberId);
    TT_RELEASE_SAFELY(_paymentType);
    TT_RELEASE_SAFELY(_ifSuccess);
    TT_RELEASE_SAFELY(_passwordErrorTimes);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return;
    }
    
    self.orderId = EncodeStringFromDic(dic, @"orderId");
    self.userId = EncodeStringFromDic(dic, @"userId");
    self.memberId = EncodeStringFromDic(dic, @"memberId");
    self.paymentType = EncodeStringFromDic(dic, @"paymentType");
    self.ifSuccess = EncodeStringFromDic(dic, @"ifSuccess");
    self.passwordErrorTimes = EncodeStringFromDic(dic, @"passwordErrorTimes");
}

@end
