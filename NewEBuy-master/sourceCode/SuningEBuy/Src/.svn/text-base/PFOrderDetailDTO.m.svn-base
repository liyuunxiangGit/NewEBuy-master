//
//  PFOrderDetailDTO.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PFOrderDetailDTO.h"
#import "PlanTicketSwitch.h"

@implementation PFOrderDetailDTO

@synthesize totalAmount = _totalAmount;
@synthesize airLineInfoArray = _airLineInfoArray;
@synthesize addressInfo = _addressInfo;
@synthesize zipCode = _zipCode;
@synthesize orderId = _orderId;
@synthesize addressType = _addressType;
@synthesize orderStatus = _orderStatus;
@synthesize paymentType = _paymentType;
@synthesize orderStatusRemark = _orderStatusRemark;
@synthesize creatTime = _creatTime;
@synthesize contactName = _contactName;
@synthesize mobile = _mobile;
@synthesize email = _email;
@synthesize userId = _userId;
@synthesize airLineType = _airLineType;
@synthesize startCityName = _startCityName;
@synthesize arriveCityName = _arriveCityName;
@synthesize travellerArray = _travellerArray;
@synthesize goTicketArray = _goTicketArray;
@synthesize backTicketArray = _backTicketArray;

- (void)dealloc {
    TT_RELEASE_SAFELY(_totalAmount);
    TT_RELEASE_SAFELY(_airLineInfoArray);
    TT_RELEASE_SAFELY(_addressInfo);
    TT_RELEASE_SAFELY(_zipCode);
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_addressType);
    TT_RELEASE_SAFELY(_orderStatus);
    TT_RELEASE_SAFELY(_paymentType);
    TT_RELEASE_SAFELY(_orderStatusRemark);
    TT_RELEASE_SAFELY(_creatTime);
    TT_RELEASE_SAFELY(_contactName);
    TT_RELEASE_SAFELY(_mobile);
    TT_RELEASE_SAFELY(_email);
    TT_RELEASE_SAFELY(_userId);
    TT_RELEASE_SAFELY(_airLineType);
    TT_RELEASE_SAFELY(_startCityName);
    TT_RELEASE_SAFELY(_arriveCityName);
    TT_RELEASE_SAFELY(_travellerArray);
    TT_RELEASE_SAFELY(_goTicketArray);
    TT_RELEASE_SAFELY(_backTicketArray);

}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    
    /*应付金额*/
    if ([PlanTicketSwitch canUserNewServer]) {
        NSString *__amount = [dic objectForKey:@"totalamount"];
        if (NotNilAndNull(__amount)) self.totalAmount = __amount;
    }else{
        NSDecimalNumber *__amount = [dic objectForKey:@"amount"];
        if (NotNilAndNull(__amount)) self.totalAmount = [__amount stringValue];
    }
    
    /*航班*/
    NSArray *__airlineViewInfoArray = [dic objectForKey:@"airlineViewInfoBeans"];
    if (NotNilAndNull(__airlineViewInfoArray) && [__airlineViewInfoArray count] > 0) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in __airlineViewInfoArray)
        {
            AirlineInfoDTO *dto = [[AirlineInfoDTO alloc] init];
            [dto encodeFromDictionary:dic];
            [array addObject:dto];
        }
        self.airLineInfoArray = array;
    }
    
    /*
     "addressInfo":
     {
     "addressId":23,
     "usersId":33000776147,
     "firstName":"张佳 文",
     “secondName”:””,
     "proCode":"1",
     "cityId":1,
     "districtId":1,
     "townId":2,
     cityName:”市”
     townName:”街道”,
     districtName:” 区”,
     proName:”省”,
     "address":"测试地 址",
     "mobile":"18651665697",
     "phone":"88888888",
     "zipCode":"210000",
     "status":"0"
     },
     
     */
    /*address info*/
    NSDictionary *__addressInfo = [dic objectForKey:@"addressInfo"];
    if (NotNilAndNull(__addressInfo)) {
        AddressInfoDTO *dto = [[AddressInfoDTO alloc] init];
        [dto encodeFromDictionary:__addressInfo];
        NSNumber *__addressId = [__addressInfo objectForKey:@"addressId"];
        if (NotNilAndNull(__addressId))   dto.addressNo = [__addressId stringValue];
        dto.provinceContent = [__addressInfo objectForKey:@"proName"];
        dto.addressContent = [__addressInfo objectForKey:@"address"];
        dto.recipient = [__addressInfo objectForKey:@"firstName"];
        dto.tel = [__addressInfo objectForKey:@"mobile"];
        self.addressInfo = dto;
        NSString *__zipCode = [__addressInfo objectForKey:@"zipCode"];
        if (NotNilAndNull(__zipCode))   self.zipCode = __zipCode;
    }
    
    /*订单信息*/
    NSDictionary *__ordersViewInfoBean = [dic objectForKey:@"ordersViewInfoBean"];
    if (NotNilAndNull(__ordersViewInfoBean)) {
        NSNumber *__ordersId = [__ordersViewInfoBean objectForKey:@"ordersId"];
        NSString *__addressType = [__ordersViewInfoBean objectForKey:@"addressType"];
        NSString *__status = [__ordersViewInfoBean objectForKey:@"status"];
        NSString *__paymentType = [__ordersViewInfoBean objectForKey:@"paymentType"];
        NSString *__statusRemark = [__ordersViewInfoBean objectForKey:@"statusRemark"];
        NSString *__creatTime = [__ordersViewInfoBean objectForKey:@"createTime"];
        NSString *__contactName = [__ordersViewInfoBean objectForKey:@"contactName"];
        NSString *__mobile = [__ordersViewInfoBean objectForKey:@"mobile"];
        NSString *__email = [__ordersViewInfoBean objectForKey:@"email"];
        NSNumber *__usersId = [__ordersViewInfoBean objectForKey:@"usersId"];
        if (NotNilAndNull(__ordersId))   self.orderId = [__ordersId stringValue];
        if (NotNilAndNull(__addressType)) {
            NSInteger typeInt = [__addressType integerValue];
            switch (typeInt) {
                case 1:
                    self.addressType = L(@"BTNotNeedReimburseProof");
                    break;
                case 2:
                    self.addressType = L(@"BTNotNeedReimburseProof");
                    break;
                case 3:
                    self.addressType = L(@"BTSuningDistributionForFree");
                    break;
                default:
                    break;
            }
        }
        if (NotNilAndNull(__status))   self.orderStatus = __status;
        if (NotNilAndNull(__statusRemark))   self.orderStatusRemark = __statusRemark;
        if (NotNilAndNull(__paymentType)){
            NSInteger paymentInt = [__paymentType integerValue];
            switch (paymentInt) {
                case 1:
                    self.paymentType = L(@"yifubaoPayWay");
                    break;
                case 2:
                    self.paymentType = L(@"BTOnlineBankPay");
                    break;
                case 3:
                    self.paymentType = L(@"choosePayWayFor40");
                    break;
                case 4:
                    self.paymentType = L(@"BTEbuy--OnlineBankPay");
                    break;
                case 5:
                    self.paymentType = L(@"BTEbuy--NimblePay");
                    break;
                case 6:
                    self.paymentType = L(@"BTRemitPay");
                    break;
                default:
                    self.paymentType = @"--";
                    break;
            }
        }
        if (NotNilAndNull(__creatTime))   self.creatTime = __creatTime;
        if (NotNilAndNull(__contactName))   self.contactName = __contactName;
        if (NotNilAndNull(__mobile))   self.mobile = __mobile;
        if (NotNilAndNull(__email))   self.email = __email;
        if (NotNilAndNull(__usersId))   self.userId = [__usersId stringValue];
    }
    
    /*air info*/
    NSDictionary *__airInfo = [dic objectForKey:@"airinfo"];
    if (NotNilAndNull(__airInfo)) {
        NSString *__airlineType = [__airInfo objectForKey:@"airline_type"];
        NSString *__startCityName = [__airInfo objectForKey:@"startcityname"];
        NSString *__arriveCityName = [__airInfo objectForKey:@"arrivecityname"];
        if (NotNilAndNull(__airlineType))   self.airLineType = __airlineType;
        if (NotNilAndNull(__startCityName))   self.startCityName = __startCityName;
        if (NotNilAndNull(__arriveCityName))   self.arriveCityName = __arriveCityName;
    }
    
    /*乘客信息*/
    NSArray *__travellerInfo = [dic objectForKey:@"travellerInfos"];
    if (NotNilAndNull(__travellerInfo) && [__travellerInfo count] > 0) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in __travellerInfo)
        {
            TravellerInfoDTO *dto = [[TravellerInfoDTO alloc] init];
            [dto encodeFromDictionary:dic];
            [array addObject:dto];
        }
        self.travellerArray = array;
    }
    
    /*机票信息*/
    NSArray *__airTickets = [dic objectForKey:@"airticket"];
    if (NotNilAndNull(__airTickets) && [__airTickets count] > 0) {
        NSMutableArray *array1 = [[NSMutableArray alloc] init];
        NSMutableArray *array2 = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in __airTickets)
        {
            TicketDetailDTO *dto = [[TicketDetailDTO alloc] init];
            [dto encodeFromDictionary:dic];
            if ([dto.airlineType eq:L(@"BTGoBackWay")]) {
                [array2 addObject:dto];
            }else{
                [array1 addObject:dto];
            }
        }
        self.goTicketArray = array1;
        self.backTicketArray = array2;
    }
}

@end
