//
//  HotelInfoService.h
//  SuningEBuy
//
//  Created by admin on 12-10-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HotelInfoService;
@class HotelIntroduceDTO;

@protocol HotelDetailServiceDelegate <NSObject>
@optional
-(void)getHotelDetailService:(HotelInfoService *)service 
                    Result:(BOOL)isSuccess
                  errorMsg:(NSString *)errorMsg;

-(void)getHotelRoomTypeService:(HotelInfoService *)service 
                      Result:(BOOL)isSuccess
                    errorMsg:(NSString *)errorMsg;

@end

@interface HotelInfoService : DataService
{
    HttpMessage   *detailMsg;
    HttpMessage   *roomTypeMsg;
}

@property (nonatomic,weak) id<HotelDetailServiceDelegate> delegate;
@property (nonatomic,strong) HotelIntroduceDTO *parseDto;
@property (nonatomic,strong) NSMutableArray *itemListArr;



-(void)beginHotelDetail:(NSString*)hotelId startDate:(NSString *)startDate endDate:(NSString *)endDate;
- (void)getHotelDetailFinish:(BOOL)isSuccess;
- (void)parseHotelDetail:(NSDictionary *)items;
- (void)beginRoomType:(NSString *)hotelId startDate:(NSString *)startDate endDate:(NSString *)endDate;
- (void)getHotelRoomTypeFinish:(BOOL)isSuccess;
- (void)parseHotelRomeType:(NSDictionary *)items;
@end




