//
//  MobileQueryDTO.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-18.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MobileQueryDTO.h"

@implementation MobileQueryDTO

@synthesize orderNO = _orderNO;
@synthesize orderName = _orderName;
@synthesize facePrice = _facePrice;
@synthesize salePrice = _salePrice;
@synthesize status = _status;
@synthesize creatTime = _creatTime;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_creatTime);
    TT_RELEASE_SAFELY(_orderNO);
    TT_RELEASE_SAFELY(_orderName);
    TT_RELEASE_SAFELY(_facePrice);
    TT_RELEASE_SAFELY(_salePrice);
    TT_RELEASE_SAFELY(_status);
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
        
    self.orderNO = EncodeStringFromDic(dic, @"orderNO");
    
    self.orderName = EncodeStringFromDic(dic, @"orderName");
    
    self.facePrice = EncodeStringFromDic(dic, @"facePrice");
    
    self.salePrice = EncodeStringFromDic(dic, @"salePrice");
    
    self.status = EncodeStringFromDic(dic, @"status");
    
    self.creatTime = EncodeStringFromDic(dic, @"createTime");

}

- (NSString *)statusDesc
{
    if ([self.status isEqualToString:@"01"])
    {
        return L(@"VPDoNotPay");
    }
    else if ([self.status isEqualToString:@"02"])
    {
        return L(@"VPBeIngTopUp");
    }
    else if ([self.status isEqualToString:@"11"])
    {
        return L(@"Recharge failed");
    }
    else if ([self.status isEqualToString:@"00"])
    {
        return L(@"Recharge success");
    }
    else if ([self.status isEqualToString:@"12"])
    {
        return L(@"VPTopUpFailAndRefundSuccess");
    }
    else if ([self.status isEqualToString:@"13"])
    {
        return L(@"VPTopUpFailAndRefundFail");
    }
    else if ([self.status isEqualToString:@"14"])
    {
        return L(@"VPTopUpSuccessPartlyAndRefundSuccess");
    }
    else if ([self.status isEqualToString:@"15"])
    {
        return L(@"VPTopUpSuccessPartlyAndRefundFail");
    }
    else if ([self.status isEqualToString:@"99"])
    {
        return L(@"VPOrderListClosed");
    }
    else
    {
        return self.status;
    }
}

@end
