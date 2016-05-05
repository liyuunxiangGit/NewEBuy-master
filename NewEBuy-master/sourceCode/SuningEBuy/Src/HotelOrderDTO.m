//
//  HotelOrderModel.m
//  SuningEBuy
//
//  Created by admin on 12-10-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "HotelOrderDTO.h"
#import "HotelOrder.h"

@implementation HotelOrderDTO
@synthesize hotelId = _hotelId;
@synthesize userId = _userId;
@synthesize memberCardNo = _memberCardNo;
@synthesize internalNum = _internalNum;
@synthesize roomTypeId = _roomTypeId;
@synthesize ratePlanId = _ratePlanId;
@synthesize startDate = _startDate;
@synthesize endDate = _endDate;
@synthesize guestName = _guestName;
@synthesize linkManName = _linkManName;
@synthesize linkManPhoneNum = _linkManPhoneNum;
@synthesize selectRoomNum = _selectRoomNum;
@synthesize arriveTime = _arriveTime;
@synthesize leaveTime = _leaveTime;
@synthesize email = _email;

-(void)dealloc
{
    TT_RELEASE_SAFELY(_hotelId);
    TT_RELEASE_SAFELY(_userId);
    TT_RELEASE_SAFELY(_memberCardNo);
    TT_RELEASE_SAFELY(_internalNum);
    TT_RELEASE_SAFELY(_roomTypeId);
    TT_RELEASE_SAFELY(_ratePlanId);
    TT_RELEASE_SAFELY(_startDate);
    TT_RELEASE_SAFELY(_endDate);
    TT_RELEASE_SAFELY(_guestName);
    TT_RELEASE_SAFELY(_linkManName);
    TT_RELEASE_SAFELY(_linkManPhoneNum);
    TT_RELEASE_SAFELY(_selectRoomNum);
    TT_RELEASE_SAFELY(_arriveTime);
    TT_RELEASE_SAFELY(_leaveTime);
    TT_RELEASE_SAFELY(_email);    
    
}

-(NSMutableDictionary*)decodeToDictionary
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.hotelId?self.hotelId:@"" forKey:kHttpRequestHotelId]; 
    [dic setObject:self.userId?self.userId:@"" forKey:kHttpRequestMemberId]; 
    [dic setObject:self.memberCardNo?self.memberCardNo:@"" forKey:kHttpRequestMemberCardNum]; 
    [dic setObject:self.internalNum?self.internalNum:@"" forKey:kHttpRequestInternalNum]; 
    [dic setObject:self.roomTypeId?self.roomTypeId:@"" forKey:kHttpRequestRoomTypeId]; 
    [dic setObject:self.ratePlanId?self.ratePlanId:@"" forKey:kHttpRequestRatePlanId];
    [dic setObject:self.startDate?self.startDate:@"" forKey:kHttpRequestCheckInDate]; 
    [dic setObject:self.endDate?self.endDate:@"" forKey:kHttpRequestCheckOutDate]; 
    [dic setObject:self.guestName?self.guestName:@"" forKey:kHttpRequestGuestNames]; 
    [dic setObject:self.linkManName?self.linkManName:@"" forKey:kHttpRequestLinkMan]; 
    [dic setObject:self.linkManPhoneNum?self.linkManPhoneNum:@"" forKey:kHttpRequestLinkMobile]; 
    [dic setObject:self.selectRoomNum?self.selectRoomNum:@"" forKey:kHttpRequestRoomAmount];
    [dic setObject:self.arriveTime?self.arriveTime:@"" forKey:kHttpRequestArrivalEarlyTime]; 
    [dic setObject:self.leaveTime?self.leaveTime:@"" forKey:kHttpRequestArrivalLateTime]; 
    [dic setObject:self.email?self.email:@"" forKey:kHttpRequestLinkEmail];
    return dic;

}
@end
