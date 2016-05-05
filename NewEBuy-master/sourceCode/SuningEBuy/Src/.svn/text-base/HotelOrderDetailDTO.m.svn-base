//
//  HotelOrderDetailDTO.m
//  SuningEBuy
//
//  Created by Qin on 14-2-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HotelOrderDetailDTO.h"

@implementation HotelOrderDetailDTO
@synthesize name = _name;

@synthesize statLevel = _statLevel;

@synthesize address = _address;

@synthesize roomType = _roomType;

@synthesize startLiveTimer = _startLiveTimer;

@synthesize bookingRoomCount = _bookingRoomCount;

@synthesize payType = _payType;

@synthesize datePrice = _datePrice;

@synthesize totalPrice = _totalPrice;

@synthesize liveingCountArr = _liveingCountArr;

@synthesize liveEarliestTimer = _liveEarliestTimer;

@synthesize liveLatestTimer = _liveLatestTimer;

@synthesize contactName = _contactName;

@synthesize phoneNumber = _phoneNumber;

@synthesize orderNO=_orderNO;

@synthesize orderStatus=_orderStatus;

@synthesize bookingTime=_bookingTime;
- (void)dealloc {
    
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(_statLevel);
    TT_RELEASE_SAFELY(_address);
    TT_RELEASE_SAFELY(_roomType);
    TT_RELEASE_SAFELY(_startLiveTimer);
    TT_RELEASE_SAFELY(_bookingRoomCount);
    
    TT_RELEASE_SAFELY(_payType);
    
    TT_RELEASE_SAFELY(_datePrice);
    
    TT_RELEASE_SAFELY(_totalPrice);
    
    TT_RELEASE_SAFELY(_liveingCountArr);
    
    TT_RELEASE_SAFELY(_liveEarliestTimer);
    
    TT_RELEASE_SAFELY(_liveLatestTimer);
    
    TT_RELEASE_SAFELY(_contactName);
    
    TT_RELEASE_SAFELY(_phoneNumber);
    
    TT_RELEASE_SAFELY(_orderNO);
    
    TT_RELEASE_SAFELY(_orderStatus);
    
    TT_RELEASE_SAFELY(_bookingTime);
    
}

- (NSDateFormatter *)dateFormatterServer
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [_dateFormatter setLocale:locale];
    
    [_dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm:ss a"];
    
    return _dateFormatter;
}

- (NSDateFormatter *)dateFormatterClient
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [_dateFormatter setLocale:locale];
    
    [_dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    return _dateFormatter;
}

- (NSDateFormatter *)dateFormatterMin
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [_dateFormatter setLocale:locale];
    
    [_dateFormatter setDateFormat:@"HH:mm"];
    
    return _dateFormatter;
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    
    _liveingCountArr = [[NSMutableArray alloc] init];
    
    NSString *__name = [dic objectForKey:@"hotelName"];
    NSString *__statLevel = [dic objectForKey:@"category"];
    NSString *__address = [dic objectForKey:@"hotelAddress"];
    
    NSString *__roomTypee = [dic objectForKey:@"roomTypeName"];
    
    NSString *checkInDate = [dic objectForKey:@"checkInDate"];
    
    NSString *checkOutDate = [dic objectForKey:@"checkOutDate"];
    
    NSString *__startLiveTimer =@"";
    if ((checkInDate !=nil) && (checkOutDate !=nil)) {
        
        NSDate *date = [[self dateFormatterServer] dateFromString:checkInDate];
        
        NSString *checkIn = [[self dateFormatterClient] stringFromDate:date];
        
        NSDate *dateOut = [[self dateFormatterServer] dateFromString:checkOutDate];
        
        NSString *checkOut = [[self dateFormatterClient] stringFromDate:dateOut];
        
        __startLiveTimer = [NSString stringWithFormat:@"%@ %@ %@",checkIn, L(@"GBTo"),checkOut];
    }
    
    NSNumber *__bookingRoomCount = [dic objectForKey:@"roomAmount"];
    
    NSString *__payType = [dic objectForKey:@"paymentTypeStr"];
    
    NSString *__datePrice = [dic objectForKey:@"dailyAvgPrice"];
    
    NSString *__totalPrice = [dic objectForKey:@"totalPrice"];
    
    NSString *__liveEarliestTimer = [dic objectForKey:@"arrivalEarlyTime"];
    if (NotNilAndNull(__liveEarliestTimer)) {
        NSDate *date = [[self dateFormatterServer] dateFromString:__liveEarliestTimer];
        
        NSString *checkIn = [[self dateFormatterMin] stringFromDate:date];
        
        __liveEarliestTimer = checkIn;
    }
    
    NSString *__liveLatestTimer = [dic objectForKey:@"arrivalLateTime"];
    if (NotNilAndNull(__liveLatestTimer)) {
        NSDate *date = [[self dateFormatterServer] dateFromString:__liveLatestTimer];
        
        NSString *checkIn = [[self dateFormatterMin] stringFromDate:date];
        
        __liveLatestTimer = checkIn;
    }
    
    NSDictionary *contacterDic = [dic objectForKey:@"contacter"];
    
    NSString *__contactName = [contacterDic objectForKey:@"name"];
    
    NSString *__phoneNumbere = [contacterDic objectForKey:@"mobile"];
    
    NSMutableArray *guestsArr = [dic objectForKey:@"guests"];
    
    if (guestsArr !=nil) {
        
        for (NSDictionary *tempDic in guestsArr) {
            NSString *guestsName = [tempDic objectForKey:@"name"];
            
            if (NotNilAndNull(guestsName)) {
                [self.liveingCountArr addObject:guestsName];
            }
        }
    }
    
    NSString *__orderNO = [dic objectForKey:@"XFOrderNo"];
    
    NSString *__orderStatus = [dic objectForKey:@"orderStatusStr"];
    
    NSString *__bookingTime=[dic objectForKey:@"bookingTime"];
    
    if (NotNilAndNull(__bookingTime)) {
        NSDate *date = [[self dateFormatterServer] dateFromString:__bookingTime];
        
        NSString *timeString = [[self dateFormatterMin] stringFromDate:date];
        
        NSString *dateString =[[self dateFormatterClient] stringFromDate:date];
        
        __bookingTime = [NSString stringWithFormat:@"%@ %@",dateString,timeString];
    }
    
    if (NotNilAndNull(__name))   self.name = __name;
    if (NotNilAndNull(__statLevel))   self.statLevel = __statLevel;
    if (NotNilAndNull(__address))   self.address = __address;
    if (NotNilAndNull(__roomTypee))   self.roomType = __roomTypee;
    if (NotNilAndNull(__startLiveTimer))   self.startLiveTimer = __startLiveTimer;
    if (NotNilAndNull(__bookingRoomCount))   self.bookingRoomCount = [__bookingRoomCount stringValue];
    
    
    if (NotNilAndNull(__payType))   self.payType = __payType;
    
    if (NotNilAndNull(__datePrice))   self.datePrice = __datePrice;
    
    if (NotNilAndNull(__totalPrice))   self.totalPrice = __totalPrice;
    
    
    if (NotNilAndNull(__liveEarliestTimer))   self.liveEarliestTimer = __liveEarliestTimer;
    
    if (NotNilAndNull(__liveLatestTimer))   self.liveLatestTimer = __liveLatestTimer;
    
    if (NotNilAndNull(__contactName))   self.contactName = __contactName;
    
    if (NotNilAndNull(__phoneNumbere))   self.phoneNumber = __phoneNumbere;
    
    if (NotNilAndNull(__orderNO))        self.orderNO=__orderNO;
    
    if (NotNilAndNull(__orderStatus))        self.orderStatus=__orderStatus;
    
    if (NotNilAndNull(__bookingTime))        self.bookingTime=__bookingTime;
    
}
@end
