//
//  GBSubmitDTO.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBSubmitDTO.h"

@implementation GBSubmitDTO

@synthesize orderId             = _orderId;
@synthesize userId              = _userId;
@synthesize payAmount           = _payAmount;
@synthesize eppAmount           = _eppAmount;
@synthesize paymentType         = _paymentType;

@synthesize memberId            = _memberId;
@synthesize payMode             = _payMode;
@synthesize eppPassword         = _eppPassword;
@synthesize validateMsg         = _validateMsg;
@synthesize categoryId          = _categoryId;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_categoryId);
    TT_RELEASE_SAFELY(_validateMsg);
    TT_RELEASE_SAFELY(_eppPassword);
    TT_RELEASE_SAFELY(_paymentType);
    TT_RELEASE_SAFELY(_eppAmount);
    TT_RELEASE_SAFELY(_payAmount);
    
    TT_RELEASE_SAFELY(_memberId);
    TT_RELEASE_SAFELY(_userId);
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_snProId);
    
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
}

- (void)setPayMode:(GBPayMode)payMode
{
    _payMode = payMode;
    switch (_payMode) {
        case GBPayModeEfubao:
        {
            self.paymentType = @"0";
            break;
        }
        case GBPayModeHuiFuWeb:
        {
            self.paymentType = @"18001";
            break;
        }
        
        case GBPayModeOnlineBank:
        {
            self.paymentType = @"18003";
            break;
        }
        case GBPayModeUnSelect:
        {
            self.paymentType = @"0";
            break;
        }
    }
}



@end
