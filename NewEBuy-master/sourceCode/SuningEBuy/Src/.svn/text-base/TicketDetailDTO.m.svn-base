//
//  TicketDetailDTO.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "TicketDetailDTO.h"
#import "InsuranceDTO.h"
#import "PlanTicketSwitch.h"

@implementation TicketDetailDTO

@synthesize orderId = _orderId;
@synthesize orderItemId = _orderItemId;
@synthesize airlineType = _airlineType;
@synthesize travellerName = _travellerName;
@synthesize status = _status;
@synthesize adultFee = _adultFee;
@synthesize childFee = _childFee;
@synthesize adultTax = _adultTax;
@synthesize childTax = _childTax;
@synthesize adultPrice = _adultPrice;
@synthesize childPrice = _childPrice;
@synthesize adultAdjustment = _adultAdjustment;
@synthesize childAdjustment = _childAdjustment;
@synthesize travellerType = _travellerType;
@synthesize totalAmount = _totalAmount;
@synthesize itinerary = _itinerary;
@synthesize insuranceNo = _insuranceNo;
@synthesize cardType = _cardType;
@synthesize idCode = _idCode;
@synthesize birthday = _birthday;
@synthesize insuranceArr = _insuranceArr;


- (void)dealloc {
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_orderItemId);
    TT_RELEASE_SAFELY(_airlineType);
    TT_RELEASE_SAFELY(_travellerName);
    TT_RELEASE_SAFELY(_status);
    TT_RELEASE_SAFELY(_adultFee);
    TT_RELEASE_SAFELY(_childFee);
    TT_RELEASE_SAFELY(_adultTax);
    TT_RELEASE_SAFELY(_childTax);
    TT_RELEASE_SAFELY(_adultPrice);
    TT_RELEASE_SAFELY(_childPrice);
    TT_RELEASE_SAFELY(_adultAdjustment);
    TT_RELEASE_SAFELY(_childAdjustment);
    TT_RELEASE_SAFELY(_travellerType);
    TT_RELEASE_SAFELY(_totalAmount);
    TT_RELEASE_SAFELY(_itinerary);
    TT_RELEASE_SAFELY(_insuranceNo);
    TT_RELEASE_SAFELY(_cardType);
    TT_RELEASE_SAFELY(_idCode);
    TT_RELEASE_SAFELY(_birthday);
    TT_RELEASE_SAFELY(_insuranceArr);
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    
    NSNumber *__orderId = [dic objectForKey:@"orders_id"];
    NSNumber *__orderItemsId = [dic objectForKey:@"orderitems_id"];
    NSString *__airlineType = [dic objectForKey:@"airline_type"];
    NSString *__travellerName = [dic objectForKey:@"travellername"];
    NSString *__status = [dic objectForKey:@"status"];
    NSDecimalNumber *__adultFee = [dic objectForKey:@"adultfee"];
    NSDecimalNumber *__childFee = [dic objectForKey:@"childfee"];
    NSDecimalNumber *__adultTax = [dic objectForKey:@"adulttax"];
    NSDecimalNumber *__childTax = [dic objectForKey:@"childtax"];
    NSDecimalNumber *__adultPrice = [dic objectForKey:@"flightadultprice"];
    NSDecimalNumber *__childPrice = [dic objectForKey:@"flightchildprice"];
    NSDecimalNumber *__adultAdjustment = [dic objectForKey:@"adultadjustment"];
    NSDecimalNumber *__childAdjustment = [dic objectForKey:@"childadjustment"];
    NSString *__travellerType = [dic objectForKey:@"traveller_type"];
    NSString *__itinerary = [dic objectForKey:@"itinerary"];
    NSString *__cardType = [dic objectForKey:@"card_type"];
    NSString *__idCode = [dic objectForKey:@"idCode"];
    NSString *__birthday = [dic objectForKey:@"birthday"];
    
    if ([PlanTicketSwitch canUserNewServer]) {
        NSArray  *__insuranceArr = [dic objectForKey:@"insureLists"];
        if (!IsArrEmpty(__insuranceArr)) {
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in __insuranceArr) {
                InsuranceDTO *dto = [[InsuranceDTO alloc] init];
                [dto encodeFromDictionary:dic];
                [tempArr addObject:dto];
                TT_RELEASE_SAFELY(dto);
            }
            
            self.insuranceArr = tempArr;
            TT_RELEASE_SAFELY(tempArr);
        }
    }else{
        
        NSString *__insuranceNo = [dic objectForKey:@"insuranceno"];
        if (NotNilAndNull(__insuranceNo))   self.insuranceNo = __insuranceNo;
    
    }
   
    
    if (NotNilAndNull(__orderId))   self.orderId = [__orderId stringValue];
    if (NotNilAndNull(__orderItemsId))   self.orderItemId = [__orderItemsId stringValue];
    if (NotNilAndNull(__airlineType))   self.airlineType = __airlineType;
    if (NotNilAndNull(__travellerName))   self.travellerName = __travellerName;
    if (NotNilAndNull(__status))   self.status = __status;
    if (NotNilAndNull(__adultFee))   self.adultFee = [__adultFee stringValue];
    if (NotNilAndNull(__childFee))   self.childFee = [__childFee stringValue];
    if (NotNilAndNull(__adultTax))   self.adultTax = [__adultTax stringValue];
    if (NotNilAndNull(__childTax))   self.childTax = [__childTax stringValue];
    if (NotNilAndNull(__adultPrice))   self.adultPrice = [__adultPrice stringValue];
    if (NotNilAndNull(__childPrice))   self.childPrice = [__childPrice stringValue];
    if (NotNilAndNull(__adultAdjustment))   self.adultAdjustment = [__adultAdjustment stringValue];
    if (NotNilAndNull(__childAdjustment))   self.childAdjustment = [__childAdjustment stringValue];
    if (NotNilAndNull(__travellerType))   self.travellerType = __travellerType;
    if (NotNilAndNull(__itinerary))   self.itinerary = __itinerary;
    if (NotNilAndNull(__cardType))
    {
        NSInteger typeInt = [__cardType integerValue];
        switch (typeInt) {
            case 0:
                self.cardType = L(@"BTIdentityCard");
                break;
            case 1:
                self.cardType = L(@"005");
                break;
            case 2:
                self.cardType = L(@"BTMilitaryCredentials");
                break;
            case 3:
                self.cardType = L(@"BTGoBackHomeCredentials");
                break;
            case 4:
                self.cardType = L(@"BTHKMacaoPass");
                break;
            case 5:
                self.cardType = L(@"BTTaiwanCompatriotCredentials");
                break;
            case 9:
                self.cardType = L(@"BTOther");
                break;
            default:
                self.cardType = L(@"BTOther");
                break;
        }
    }
    if (NotNilAndNull(__idCode))   self.idCode = __idCode;
    if (NotNilAndNull(__birthday))   self.birthday = __birthday;

    id __totalAmount = [dic objectForKey:@"totalamount"];
    if (NotNilAndNull(__totalAmount)) {
        if ([__totalAmount isKindOfClass:[NSNumber class]]) {
            self.totalAmount = [__totalAmount stringValue];
        }else{
            self.totalAmount = __totalAmount;
        }
    }
    
//    //鉴于接口未好，使用两个值算出totalamount
//    NSNumber *insureTotalAmount = [dic objectForKey:@"insureTotalAmount"];
//    NSNumber *ticketTotalAmount = [dic objectForKey:@"ticketTotalAmount"];
//    if (NotNilAndNull(insureTotalAmount) && NotNilAndNull(ticketTotalAmount)) {
//        double __totalAmount = [insureTotalAmount doubleValue]+[ticketTotalAmount doubleValue];
//        self.totalAmount = [NSString stringWithFormat:@"%.2lf", __totalAmount];
//    }
}


@end
