//
//  FlightRoomHttpDataSource.m
//  SuningEBuy
//
//  Created by shasha on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightRoomHttpDataSource.h"
#import "FlightRoomInfoDTO.h"

@implementation FlightRoomHttpDataSource

+ (NSMutableArray *)parseFlightRoomList:(NSArray*)items{
    
    if (!items||(NSNull *)items == [NSNull null]) {
        
        return nil;
        
    }
        
    NSArray *array = items;
    
    if (array != nil && [array count] > 0) {
        
        NSMutableArray *flightRoomList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in array ) {
            
            FlightRoomInfoDTO *dto = [[FlightRoomInfoDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            [flightRoomList addObject:dto];
            
            TT_RELEASE_SAFELY(dto);
            
        }
        
        if([flightRoomList count]!=0){
			
		    return flightRoomList;
			
		}
		else{
			
			TT_RELEASE_SAFELY(flightRoomList);
			
			return nil;
		}
        
    }
    
    return nil;


}

@end
