//
//  HotelOrderListDto.m
//  SuningEBuy
//
//  Created by Qin on 14-2-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "HotelOrderListDto.h"

@implementation HotelOrderListDto

@synthesize orderNO = _orderNO;

@synthesize hotelName = _hotelName;

@synthesize number = _number;

@synthesize totalPrice = _totalPrice;

@synthesize timer = _timer;

@synthesize status = _status;

@synthesize orderUid = _orderUid;

- (void)dealloc {
    TT_RELEASE_SAFELY(_orderNO);
    TT_RELEASE_SAFELY(_hotelName);
    TT_RELEASE_SAFELY(_number);
    TT_RELEASE_SAFELY(_totalPrice);
    TT_RELEASE_SAFELY(_timer);
    TT_RELEASE_SAFELY(_status);
    
    TT_RELEASE_SAFELY(_orderUid);
    
}

- (NSDateFormatter *)dateFormatterServer
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:@"MMM dd, yyyy hh:mm:ss a"];
    
    return _dateFormatter;
}

- (NSDateFormatter *)dateFormatterClient
{
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    return _dateFormatter;
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    
    NSString *__orderNO = [dic objectForKey:@"XFOrderNo"];
    NSString *__orderUid = [dic objectForKey:@"XFOrderId"];
    NSString *__hotelName = [dic objectForKey:@"hotelName"];
    NSNumber *__number = [dic objectForKey:@"roomAmount"];
    NSString *__totalPrice = [dic objectForKey:@"totalPrice"];
    NSString *__timer = [dic objectForKey:@"orderCreateDate"];
    
    //    if (NotNilAndNull(__timer)) {
    //        NSDate *date = [[self dateFormatterServer] dateFromString:__timer];
    //
    //        NSString *checkIn = [[self dateFormatterClient] stringFromDate:date];
    //
    //        __timer = checkIn;
    //    }
    
    NSString *__status = [dic objectForKey:@"orderStatusStr"];
    
    
    if (NotNilAndNull(__orderNO))   self.orderNO = __orderNO;
    if (NotNilAndNull(__hotelName))   self.hotelName = __hotelName;
    if (NotNilAndNull(__number))   self.number = [__number stringValue];
    if (NotNilAndNull(__totalPrice))   self.totalPrice = __totalPrice;
    if (NotNilAndNull(__timer))   self.timer = __timer;
    if (NotNilAndNull(__status))   self.status = __status;
    
    if (NotNilAndNull(__orderUid))   self.orderUid = __orderUid;
}

@end
