//
//  GiftCouponDTO.h
//  SuningEBuy
//
//  Created by xy ma on 12-6-15.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CouponTypeTotal,
    CouponTypePoint,        //云钻
    CouponTypeECoupon,      //云钻兑换券－－－电子礼金券
    CouponTypeCashCard,     //储值卡
    CouponTypeGiftCoupon,   //礼品卡
    CouponTypeAdCoupon,     //广告券
    CouponTypeMINDCOUPON,   //
    CouponTypeVoucherCode,  //13位直降code部分
    CouponTypeVIPCard,
    CouponTypeUnKnown
}CouponType;

@interface GiftCouponDTO : NSObject

@property (nonatomic, copy) NSString *giftCouponId;
@property (nonatomic, copy) NSString *serialNum;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *descriptions;

@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *usedAmount;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) CouponType couponType;


@property (nonatomic, copy) NSString *exclusive;//互斥标识  1  互斥，互斥券只能使用其中一张   0 不互斥
@property (nonatomic, assign) BOOL   isSelected;
@property (nonatomic, copy) NSString *couponTmpId;  //券模板ID， 同样的券模板可以多选


/* add by gjf 区分c店优惠券*/
//-----begin
@property (nonatomic, strong) NSString *couponCount;  //c店券数量
@property (nonatomic, strong) NSString *vendorName;  //供应商
@property (nonatomic, strong) NSString *vendorCode;  //供应商编码
@property (nonatomic, assign) BOOL ispt;  //是否平台通用券
//-----end

/*
 type类型的值主要有
 
 TOTAL
 POINT//云钻
 ECOUPON//云钻兑换券
 CASHCARD//储值卡
 GIFTCOUPON//礼品券
 ADCOUPON//广告券
 MINDCOUPON(9994),
 VOUCHERCODE//13位直降code部分
 */

- (void)encodeFromDictionary:(NSDictionary *)dic;


- (NSString *)formatedName;

@end
