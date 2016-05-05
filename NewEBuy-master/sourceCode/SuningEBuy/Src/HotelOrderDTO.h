//
//  HotelOrderModel.h
//  SuningEBuy
//
//  Created by admin on 12-10-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelOrderDTO : BaseHttpDTO
{
    
}
@property (nonatomic,copy) NSString   *hotelId;
@property (nonatomic,copy) NSString   *userId;
@property (nonatomic,copy) NSString   *memberCardNo;
@property (nonatomic,copy) NSString   *internalNum;
@property (nonatomic,copy) NSString   *roomTypeId;
@property (nonatomic,copy) NSString   *ratePlanId;
@property (nonatomic,copy) NSString   *startDate;
@property (nonatomic,copy) NSString   *endDate;
@property (nonatomic,copy) NSString   *guestName;
@property (nonatomic,copy) NSString   *linkManName;
@property (nonatomic,copy) NSString   *linkManPhoneNum;
@property (nonatomic,copy) NSString   *selectRoomNum;
@property (nonatomic,copy) NSString   *arriveTime;
@property (nonatomic,copy) NSString   *leaveTime;
@property (nonatomic,copy) NSString   *email;

-(NSMutableDictionary*)decodeToDictionary;
@end
