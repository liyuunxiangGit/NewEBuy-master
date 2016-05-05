//
//  GiftCouponDTO.m
//  SuningEBuy
//
//  Created by xy ma on 12-6-15.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "GiftCouponDTO.h"

@implementation GiftCouponDTO

//@property (nonatomic, copy) NSString *id;
//@property (nonatomic, copy) NSString *serialNum;
//@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *description;
//
//@property (nonatomic, copy) NSString *endDate;
//@property (nonatomic, copy)  NSString *balance;
//@property (nonatomic, copy) NSString *usedAmount;
//@property (nonatomic, copy) NSString *type;

@synthesize giftCouponId = _giftCouponId;
@synthesize serialNum = _serialNum;
@synthesize name = _name;
@synthesize descriptions = _descriptions;

@synthesize endDate = _endDate;
@synthesize balance = _balance; ////电话支付 @"11602"   /货到付款  11601
@synthesize usedAmount = _usedAmount;
@synthesize type = _type;
@synthesize couponType = _couponType;
@synthesize exclusive = _exclusive;
@synthesize isSelected = _isSelected;

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (!dic || ![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.giftCouponId = EncodeStringFromDic(dic, @"id");
    self.serialNum = EncodeStringFromDic(dic, @"serialNum");
    self.name = EncodeStringFromDic(dic, @"name");
    self.descriptions = EncodeStringFromDic(dic, @"description");
    self.endDate = EncodeStringFromDic(dic, @"endDate");
    self.balance = EncodeStringFromDic(dic, @"balance");
    self.usedAmount = EncodeStringFromDic(dic, @"usedAmount");
    self.type = EncodeStringFromDic(dic, @"type");
    self.ispt = [EncodeStringFromDic(dic, @"platFormUse") boolValue];
    self.exclusive = EncodeStringFromDic(dic, @"exclusive");
    
    if ([_type isEqualToString:@"TOTAL"]) {
        self.couponType = CouponTypeTotal;
    }else if ([_type isEqualToString:@"POINT"]){
        self.couponType = CouponTypePoint;
    }else if ([_type isEqualToString:@"ECOUPON"]){
        self.couponType = CouponTypeECoupon;
    }else if ([_type isEqualToString:@"CASHCARD"]){
        self.couponType = CouponTypeCashCard;
    }else if ([_type isEqualToString:@"GIFTCOUPON"]){
        self.couponType = CouponTypeGiftCoupon;
    }else if ([_type isEqualToString:@"ADCOUPON"]){
        self.couponType = CouponTypeAdCoupon;
    }else if ([_type isEqualToString:@"MINDCOUPON(9994)"]){
        self.couponType = CouponTypeMINDCOUPON;
    }else if ([_type isEqualToString:@"VIPCARD"]){
        self.couponType = CouponTypeVIPCard;
    }else if ([_type isEqualToString:@"VOUCHERCODE"]){
        self.couponType = CouponTypeVoucherCode;
        self.balance = self.usedAmount;
        self.isSelected = YES;
    }else{
        self.couponType = CouponTypeUnKnown;
    }
    
    
    self.couponTmpId = EncodeStringFromDic(dic, @"couponTmpId");
    
    //默认为空字符串
    if (!_couponTmpId) {
        _couponTmpId = @"";
    }
}

- (NSString *)formatedName
{
    NSString *name = nil;
    switch (self.couponType) {
        case CouponTypePoint:   //云钻电子券
        {
            name = L(@"PFCloudDiamondElectronicTicket");
            break;
        }
        case CouponTypeGiftCoupon:
        {
            name = self.name;
            break;
        }
        case CouponTypeMINDCOUPON:
        case CouponTypeVoucherCode:
        {
            name = self.name.length?self.name:L(@"PFCoupons");
            
            break;
        }
        case CouponTypeAdCoupon:
        {
            name = L(@"PFAdvertisingCoupons");
            
            break;
        }
        case CouponTypeTotal:
        case CouponTypeCashCard:
        {
            if ([self.name isEqualToString:@"0"]) {
                name = L(@"PFGiftCards");
            }else{
                name = L(@"PFBookGiftCard");
            }
            
            break;
        }
        case CouponTypeECoupon: //暂时没有的
        {
            break;
        }
        case CouponTypeVIPCard:
        {
            name = L(@"PFVIPCard");
            break;
        }
        default:
            break;
    }
    
    return name;
}

@end
