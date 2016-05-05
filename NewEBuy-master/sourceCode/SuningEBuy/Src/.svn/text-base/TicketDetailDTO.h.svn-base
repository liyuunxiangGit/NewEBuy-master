//
//  TicketDetailDTO.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicketDetailDTO : NSObject

//-------------------------------------------------------
//机票信息
//-------------------------------------------------------

/*大订单id*/
@property (nonatomic, copy) NSString *orderId;

/*小订单id*/
@property (nonatomic, copy) NSString *orderItemId;

/*航线类型：去程，返程*/
@property (nonatomic, copy) NSString *airlineType;

/*乘客名称*/
@property (nonatomic, copy) NSString *travellerName;

/*状态*/
@property (nonatomic, copy) NSString *status;

/*成人机建费*/
@property (nonatomic, copy) NSString *adultFee;

/*儿童机建费*/
@property (nonatomic, copy) NSString *childFee;

/*成人燃油费*/
@property (nonatomic, copy) NSString *adultTax;

/*儿童燃油费*/
@property (nonatomic, copy) NSString *childTax;

/*成人价格*/
@property (nonatomic, copy) NSString *adultPrice;

/*儿童价格*/
@property (nonatomic, copy) NSString *childPrice;

/*成人直降*/
@property (nonatomic, copy) NSString *adultAdjustment;

/*儿童直降*/
@property (nonatomic, copy) NSString *childAdjustment;

/*票类型：成人，儿童*/
@property (nonatomic, copy) NSString *travellerType;

/*总价格*/
@property (nonatomic, copy) NSString *totalAmount;

/*电子票号*/
@property (nonatomic, copy) NSString *itinerary;

/*保单号，接口使用*/
@property (nonatomic, copy) NSString *insuranceNo;

/*保险信息：新接口使用*/
@property (nonatomic, strong) NSArray  *insuranceArr;

/*证件类型*/
@property (nonatomic, copy) NSString *cardType;

/*证件号码*/
@property (nonatomic, copy) NSString *idCode;

/*出生日期*/
@property (nonatomic, copy) NSString *birthday;

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
