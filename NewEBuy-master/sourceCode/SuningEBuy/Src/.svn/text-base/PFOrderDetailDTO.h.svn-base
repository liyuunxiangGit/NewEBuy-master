//
//  PFOrderDetailDTO.h
//  ;
//
//  Created by 刘坤 on 12-5-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TicketDetailDTO.h"
#import "AirlineInfoDTO.h"
#import "TravellerInfoDTO.h"
#import "AddressInfoDTO.h"

typedef enum _PFDetailDataType{
    PFDetailDataTypeOrder       = 0,
    PFDetailDataTypeAirline     = 1,
    PFDetailDataTypeTicket      = 2,
    PFDetailDataTypeUserInfo    = 3,
    PFDetailDataTypeAddressInfo = 4
}PFDetailDataType;

@interface PFOrderDetailDTO : NSObject

/*应付金额*/
@property (nonatomic, copy) NSString *totalAmount;

/*航班信息*/
@property (nonatomic, strong) NSArray *airLineInfoArray;

//-------------------------------------------------------
//地址信息
//-------------------------------------------------------

@property (nonatomic, strong) AddressInfoDTO *addressInfo;

@property (nonatomic, copy) NSString *zipCode;

//-------------------------------------------------------
//订单信息
//-------------------------------------------------------

/*大订单号*/
@property (nonatomic, copy) NSString *orderId;

/*配送方式*/
@property (nonatomic, copy) NSString *addressType;

/*大订单号状态*/
@property (nonatomic, copy) NSString *orderStatus;

/*支付方式*/
@property (nonatomic, copy) NSString *paymentType;

/*状态描述*/
@property (nonatomic, copy) NSString *orderStatusRemark;

/*创建时间*/
@property (nonatomic, copy) NSString *creatTime;

/*下订单人姓名*/
@property (nonatomic, copy) NSString *contactName;

/*下单人手机号*/
@property (nonatomic, copy) NSString *mobile;

/*下单人邮箱*/
@property (nonatomic, copy) NSString *email;

/*用户Id*/
@property (nonatomic, copy) NSString *userId;

//-------------------------------------------------------
//航班信息简介
//-------------------------------------------------------

/*航班类型：往返，单程*/
@property (nonatomic, copy) NSString *airLineType;

/*起飞城市*/
@property (nonatomic, copy) NSString *startCityName;

/*到达城市*/
@property (nonatomic, copy) NSString *arriveCityName;


//-------------------------------------------------------
//航班信息简介
//-------------------------------------------------------

@property (nonatomic, strong) NSArray *travellerArray;

//去程机票信息
@property (nonatomic, strong) NSArray *goTicketArray;

//返程机票信息
@property (nonatomic, strong) NSArray *backTicketArray;

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
