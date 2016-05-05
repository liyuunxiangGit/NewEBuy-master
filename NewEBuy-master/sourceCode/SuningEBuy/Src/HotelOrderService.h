//
//  HoterOrderService.h
//  SuningEBuy
//
//  Created by admin on 12-10-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HotelOrderService;
@class HotelOrderDTO;

@protocol HotelOrderDelegate <NSObject>
@optional
-(void)getHotelOrderService:(HotelOrderService *)service 
                         Result:(BOOL)isSuccess
                       errorMsg:(NSString *)errorMsg;
@end

@interface HotelOrderService :DataService
{
     HttpMessage *orderMsg;
}

@property (nonatomic,weak) id<HotelOrderDelegate> delegate;
- (void)beginHotelOrderSumbit:(HotelOrderDTO*)orderDto;
- (void)getHotelOrderSubmitFinish:(BOOL)isSuccess;
- (void)saveHoteOrder:(NSDictionary *)items;
@end
