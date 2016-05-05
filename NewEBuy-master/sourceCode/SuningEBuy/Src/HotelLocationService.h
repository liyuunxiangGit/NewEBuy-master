//
//  HotelLocationService.h
//  SuningEBuy
//
//  Created by admin on 12-10-9.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HotelLocationService;

@protocol HotelLocationDelegate <NSObject>
@optional
-(void)getHotelLocationListService:(HotelLocationService *)service 
                    Result:(BOOL)isSuccess
                  errorMsg:(NSString *)errorMsg;
@end

@interface HotelLocationService : DataService
{
    HttpMessage *locationMsg;
}
@property (nonatomic,weak) id<HotelLocationDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *businessCircleList;
@property (nonatomic,strong) NSMutableArray *SARList;

-(void)beginLocationHttpRequest:(NSString *)cityName;
- (void)getHotelLocaionListFinish:(BOOL)isSuccess;
- (void)parseHoteLocaionlList:(NSDictionary*)items;
@end
