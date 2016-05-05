//
//  SearchHotelService.h
//  SuningEBuy
//
//  Created by admin on 12-10-9.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QueryHotelDTO.h"
#import "HotelOrder.h"
#import "HotelListDTO.h"
@class SearchHotelService;
@protocol HotelSearchServiceDelegate <NSObject>

@optional
-(void)getHotelListService:(SearchHotelService *)service 
                         Result:(BOOL)isSuccess
                       errorMsg:(NSString *)errorMsg;

@end

@interface SearchHotelService : DataService
{
    HttpMessage *queryHotelMsg;       
}

@property (nonatomic,weak) id<HotelSearchServiceDelegate>  delegate;
@property (nonatomic,strong) NSMutableArray *hotelList;
@property (nonatomic,strong) NSString       *pageCount;



-(void)beginSearchHotelHttpRequest:(QueryHotelDTO *)dto;
- (void)getHotelListFinish:(BOOL)isSuccess;
- (void)parseHotelList:(NSDictionary *)items;
@end
