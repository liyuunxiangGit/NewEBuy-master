//
//  HotelDataSourceDTO.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-9.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "HotelDataSourceDTO.h"

@implementation HotelDataSourceDTO

@synthesize cityName = _cityName;
@synthesize startDate = _startDate;
@synthesize endDate = _endDate;
@synthesize hotelName = _hotelName;
@synthesize priceArea = _priceArea;

@synthesize starGrade = _starGrade;
@synthesize hotelAroundId = _hotelAroundId;
@synthesize hotelId = _hotelId;
@synthesize sortType = _sortType;
@synthesize sort = _sort;

@synthesize productImg = _productImg;
@synthesize ratePlanId = _ratePlanId;
@synthesize roomTypeId = _roomTypeId;
@synthesize dateTime = _dateTime;

@synthesize totalPrice = _totalPrice;
@synthesize roomTypeName = _roomTypeName;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_cityName);
    TT_RELEASE_SAFELY(_startDate);
    TT_RELEASE_SAFELY(_endDate);
    TT_RELEASE_SAFELY(_hotelName);
    TT_RELEASE_SAFELY(_priceArea);
    
    TT_RELEASE_SAFELY(_starGrade);
    TT_RELEASE_SAFELY(_hotelAroundId);
    TT_RELEASE_SAFELY(_hotelId);
    TT_RELEASE_SAFELY(_sortType);
    TT_RELEASE_SAFELY(_sort);
    
    TT_RELEASE_SAFELY(_productImg);
    TT_RELEASE_SAFELY(_ratePlanId);
    TT_RELEASE_SAFELY(_roomTypeId);
    TT_RELEASE_SAFELY(_dateTime);
    
}




- (void)encodeFromDictionary:(NSDictionary *)dic{
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    
    NSString *__cityName = [dic objectForKey:@"cityName"];
    NSString *__startDate = [dic objectForKey:@"startDate"];
    NSString *__endDate = [dic objectForKey:@"endDate"];
    NSString *__hotelName = [dic objectForKey:@"hotelName"];
    NSString *__priceArea = [dic objectForKey:@"priceArea"];

    NSString *__starGrade = [dic objectForKey:@"starGrade"];
    NSString *__hotelAroundId = [dic objectForKey:@"hotelAroundId"];
    NSString *__hotelId = [dic objectForKey:@"hotelId"];
    NSString *__sortType = [dic objectForKey:@"sortType"];
    NSString *__sort = [dic objectForKey:@"sort"];
    
//    NSString *__productImg = [dic objectForKey:@"productImg"];
    NSString *__ratePlanId = [dic objectForKey:@"ratePlanId"];
    NSString *__roomTypeId = [dic objectForKey:@"roomTypeId"];
    
    
    if (NotNilAndNull(__cityName) && ![__cityName isEqualToString:@""]) {
        self.cityName = __cityName;
    }
    if (NotNilAndNull(__startDate) && ![__startDate isEqualToString:@""]) {
        self.startDate = __startDate;
    }
    if (NotNilAndNull(__endDate) && ![__endDate isEqualToString:@""]) {
        self.endDate = __endDate;
    }
    if (NotNilAndNull(__hotelName) && ![__hotelName isEqualToString:@""]) {
        self.hotelName = __hotelName;
    }
    if (NotNilAndNull(__priceArea) && ![__priceArea isEqualToString:@""]) {
        self.priceArea = __priceArea;
    }
    

    if (NotNilAndNull(__starGrade) && ![__starGrade isEqualToString:@""]) {
        self.starGrade = __starGrade;
    }
    if (NotNilAndNull(__hotelAroundId) && ![__hotelAroundId isEqualToString:@""]) {
        self.hotelAroundId = __hotelAroundId;
    }
    if (NotNilAndNull(__hotelId) && ![__hotelId isEqualToString:@""]) {
        self.hotelId = __hotelId;
    }
    if (NotNilAndNull(__sortType) && ![__sortType isEqualToString:@""]) {
        self.sortType = __sortType;
    }
    if (NotNilAndNull(__sort) && ![__sort isEqualToString:@""]) {
        self.sort = __sort;
    }

    if (NotNilAndNull(__ratePlanId) && ![__ratePlanId isEqualToString:@""]) {
        self.ratePlanId = __ratePlanId;
    }
    if (NotNilAndNull(__roomTypeId) && ![__roomTypeId isEqualToString:@""]) {
        self.roomTypeId = __roomTypeId;
    }

    
}









@end
